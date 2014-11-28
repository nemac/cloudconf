import '/vagrant/settings.pp'

#yyy exec { disable_selinux_sysconfig:
#yyy     command => '/bin/sed -i "s@^\(SELINUX=\).*@\1disabled@" /etc/selinux/config',
#yyy     unless  => '/bin/grep -q "SELINUX=disabled" /etc/selinux/config',
#yyy }
#yyy 
#yyy exec { 'set-hostname':
#yyy     command => "/usr/bin/hostnamectl set-hostname ${server_name}"
#yyy }
#yyy 
#yyy exec { 'etc-hosts':
#yyy     command => "/bin/echo '127.0.0.1 ${server_name}' >> /etc/hosts",
#yyy     unless  => "/bin/grep -q '127.0.0.1 ${server_name}' /etc/hosts",
#yyy }
#yyy 
#yyy file { "/etc/ssh/ssh_config" :
#yyy   ensure => present,
#yyy   source => "/etc/puppet/files/assets/ssh/ssh_config",
#yyy   owner   => "root",
#yyy   group   => "root"
#yyy }

#yyy package { 'emacs-nox':
#yyy   ensure => installed
#yyy }
#yyy 
#yyy package { 'unzip':
#yyy   ensure => installed
#yyy }
#yyy 
#yyy package { 'man-pages':
#yyy   ensure => installed
#yyy }
#yyy 
#yyy package { 'make':
#yyy   ensure => installed
#yyy }
#yyy 
#yyy package { 'wget':
#yyy   ensure => installed
#yyy }
#yyy 
#yyy package { 'git':
#yyy   ensure => installed
#yyy }

class apache-server {

#yyy   package { 'httpd':
#yyy     ensure => 'present'
#yyy   }
#yyy 
#yyy   service { 'httpd':
#yyy     require => Package['httpd'],
#yyy     ensure => running,            # this makes sure httpd is running now
#yyy     enable => true                # this make sure httpd starts on each boot
#yyy   }
#yyy 
#yyy   service { 'iptables':
#yyy     ensure => stopped,
#yyy     enable => false
#yyy   }
#yyy 
#yyy   service { 'ip6tables':
#yyy     ensure => stopped,
#yyy     enable => false
#yyy   }

}

class nappl-server {

#yyy   file { "/home/git/.ssh":
#yyy     require => Package['drutils'],
#yyy     ensure  => directory,
#yyy     owner   => "git",
#yyy     group   => "git",
#yyy     mode    => 0700
#yyy   }  
#yyy 
#yyy   file { "/home/git/.ssh/authorized_keys":
#yyy     require => File['/home/git/.ssh'],
#yyy     ensure  => present,
#yyy     owner   => "git",
#yyy     group   => "git",
#yyy     mode    => 0600
#yyy   }
#yyy 
#yyy   group { "admin" :
#yyy     ensure => present,
#yyy     system => true
#yyy   }
#yyy   exec { "admin-group-can-sudo":
#yyy     require => Group['admin'],
#yyy     command => '/bin/chmod u+w /etc/sudoers ; echo "%admin ALL=NOPASSWD: ALL" >> /etc/sudoers ; /bin/chmod u-w /etc/sudoers',
#yyy     unless  => '/bin/grep -q "%admin ALL=NOPASSWD: ALL" /etc/sudoers'
#yyy   }

#  group { "sudoers" :
#    ensure => present,
#    system => true
#  }
#  file { "/etc/sudoers.d/sudoers_group":
#    ensure => present,
#    content => "%sudoers        ALL=(ALL)       NOPASSWD: ALL",
#    owner => root,
#    group => root,
#    mode => 0440
#  }

#yyy   file { "/var/log/httpd":
#yyy     require => Package['drutils'],
#yyy     ensure  => directory,
#yyy     group   => "nappl",
#yyy     mode    => 0750
#yyy   }  

#yyy   exec { 'vagrant-user-in-git-goup':
#yyy     require => Package['drutils'],
#yyy     command => '/etc/puppet/files/assets/util/add_user_to_group vagrant git' 
#yyy   }
#yyy   exec { 'vagrant-user-in-nappl-goup':
#yyy     require => Package['drutils'],
#yyy     command => '/etc/puppet/files/assets/util/add_user_to_group vagrant nappl' 
#yyy   }
#yyy   file { '/etc/hosts':
#yyy     ensure => present,
#yyy     group => nappl,
#yyy     mode => 0664
#yyy   }

}

class { "nappl-server" : }
class { "apache-server" : }

#yyy package { 'drutils':
#yyy   ensure => installed
#yyy }

#yyy package { 'php':
#yyy   ensure => installed,
#yyy }
#yyy 
#yyy exec { 'set-php-memory-limit' :
#yyy   require => Package["php"],
#yyy   command => "/bin/sed -i 's/^memory_limit = .*$/memory_limit = 512M/' /etc/php.ini",
#yyy   unless  => "/bin/grep -q 'memory_limit = 512M' /etc/php.ini"
#yyy }
#yyy 
#yyy package { 'php-gd':
#yyy   ensure => installed,
#yyy }
#yyy 
#yyy package { 'php-mbstring':
#yyy   ensure => installed,
#yyy }

#yyy #package { 'php-domxml-php4-php5' :
#yyy #  ensure => installed,
#yyy #}
#yyy 
#yyy package { 'php-pear':
#yyy   ensure => installed
#yyy }

#yyy exec { 'install-drush' :
#yyy     command => '/usr/bin/pear channel-discover pear.drush.org ; /usr/bin/pear install drush/drush ; cd /usr/share/pear/drush/lib ; /bin/mkdir tmp ; cd tmp ; /bin/tar xfz /etc/puppet/files/assets/drush-dependencies/Console_Table-1.1.3.tgz ; /bin/rm -f package.xml ; /bin/mv Console_Table-1.1.3 .. ; cd .. ; /bin/rm -rf tmp',
#yyy     unless => '/usr/bin/test -f /usr/bin/drush'
#yyy }
#yyy 
#yyy class mariadb-server {
#yyy 
#yyy   package { 'mariadb':
#yyy       ensure => installed
#yyy   }
#yyy 
#yyy   package { 'mariadb-libs':
#yyy       ensure => installed
#yyy   }
#yyy 
#yyy   package { 'mariadb-server':
#yyy     ensure => installed
#yyy   }
#yyy 
#yyy   service { 'mariadb':
#yyy     require => Package['mariadb-server'],
#yyy     ensure => running,            # this makes sure it's running now
#yyy     enable => true                # this make sure it starts on each boot
#yyy   }
#yyy 
#yyy   package { 'perl-DBD-MySQL':
#yyy       ensure => installed
#yyy   }
#yyy 
#yyy   package { 'php-mysql':
#yyy       ensure => installed
#yyy   }
#yyy 
#yyy   exec { 'secure-mariadb-server' :
#yyy       require => [Service["mariadb"],Package["perl-DBD-MySQL"]],
#yyy       command => '/usr/bin/perl /etc/puppet/files/assets/mariadb/secure-mariadb.pl'
#yyy   }
#yyy 
#yyy   # exec { 'vagrant-user-has-mysql-root-access':
#yyy   #   require => Class["mysql::server"],
#yyy   #   command => '/etc/puppet/files/assets/util/give_user_mysql_root_access vagrant'
#yyy   # }
#yyy 
#yyy }

class { "mariadb-server" : }

package { 'rubygem-bundler':
  ensure => installed
}
package { 'ruby-devel':
  ensure => installed
}
package { 'gcc':
  ensure => installed
}
package { 'gcc-c++' :
  ensure => installed
}
