class mariadb-server {

  package { 'mariadb':
      ensure => installed
  }

  package { 'mariadb-libs':
      ensure => installed
  }

  package { 'mariadb-server':
    ensure => installed
  }

  service { 'mariadb':
    require => Package['mariadb-server'],
    ensure => running,            # this makes sure it's running now
    enable => true                # this make sure it starts on each boot
  }

  package { 'perl-DBD-MySQL':
      ensure => installed
  }

  package { 'php-mysql':
      ensure => installed
  }

  exec { 'secure-mariadb-server' :
      require => [Service["mariadb"],Package["perl-DBD-MySQL"]],
      command => '/usr/bin/perl /etc/puppet/files/assets/mariadb/secure-mariadb.pl'
  }

  exec { 'vagrant-user-has-mysql-root-access':
    require => Package['mariadb'],
    command => '/etc/puppet/files/assets/util/give_user_mysql_root_access vagrant'
  }

}
