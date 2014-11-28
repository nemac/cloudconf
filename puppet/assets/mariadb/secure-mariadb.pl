#! /usr/bin/perl

use DBI;

# This script secures the local mysql/mariadb instance by doing the following:
#     1. check for a mysql root user password in the file /root/.my.cnf
#     2. connect to the running db
#     3. delete all users except root@localhost
#     4. if no password was found in step 1, write a new /root/.my.cnf file
#        containing a randomly generated password, and reset the mysql root
#        user's password to that.

sub doquery {
    my $sql = shift;
    my $sth = $dbh->prepare($sql);
    $sth->execute();
    return $sth;
}

sub get_password_from_ini_file {
    # Return the (first) password in the given ini file, if the file exists.
    # If the file does not exist, return the empty string.
    my $file = shift;
    my $line, $x, $password;
    $password = "";
    if (-f $file) {
	open(IN, "<$file");
	while ($line=<IN>) {
	    chomp($line);
	    if (($x) = ($line =~ /^password\s*=\s*(.*+)$/)) {
		$password = $x;
		$password =~ s/^'(.*)'$/$1/;
		$password =~ s/^"(.*)"$/$1/;
	    }
	}
	close(IN);
    }
    return $password;
}

sub generate_random_password {
    # Return a random 10-char string
    my $chars = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z',
		 'a','b','c','d','e','f','g','h','i','j','k','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
		 '0','1','2','3','4','5','6','7','8','9','0','1','2','3','4','5','6','7','8','9'];
    my $nchars = $#$chars+1;
    my $len = 10;
    my $password = "";
    while ($len >= 0) {
	$password .= $chars->[ int(rand($nchars)) ];
	--$len;
    }
    return $password;
}

sub write_my_cnf {
    # write a .my.cnf file containing the given root password to the given file
    my $file = shift;
    my $password = shift;
    open(OUT, ">$file");
    print OUT "[client]\n";
    print OUT "user=root\n";
    print OUT "host=localhost\n";
    print OUT "password='$password'\n";
    print OUT "socket=/var/lib/mysql/mysql.sock\n";
    close(OUT);
}

$mycnf = "/root/.my.cnf";

# get the current password, if any
$password = get_password_from_ini_file($mycnf);

# connect to the db, using above password, if any
print "secure-mariadb.pl: Connecting to database...\n";
if ($password) {
    $dbh = DBI->connect("DBI:mysql:mysql", "root", $password);
} else {
    $dbh = DBI->connect("DBI:mysql:mysql", "root");
}

# delete all users except root@localhost
print "secure-mariadb.pl: dropping unnecessary users...\n";
my $sth = doquery("select user,host from user");
while (defined($hr=$sth->fetchrow_hashref())) {
    if (($hr->{user} ne "root") || ($hr->{host} ne "localhost")) {
	doquery( sprintf("DROP USER '%s'\@'%s' ;\n", $hr->{user}, $hr->{host}) );
    }
}

# if no password found above, write a new random one to /root/.my.cnf, and
# reset the mysql root user's pw to that.
if ($password eq "") {
    print "secure-mariadb.pl: Generating and saving root user password...\n";
    $password = generate_random_password();
    doquery("update user set password=PASSWORD('$password') where user='root'");
    doquery("flush privileges");
    write_my_cnf($mycnf, $password);
}

print "secure-mariadb.pl: done.\n";
