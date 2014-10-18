class mysql-server {

  class { 'mysql::server':
    config_hash => { 'root_password' => $mysql_root_password }
  }

  class { 'mysql::php': }

  exec { 'secure-mysql-server' :
      require => Class["mysql::server"],
      command => '/usr/bin/mysql --defaults-extra-file=/root/.my.cnf --force mysql < /etc/puppet/files/assets/mysql/secure.sql'
  }

  exec { 'vagrant-user-has-mysql-root-access':
    require => Class["mysql::server"],
    command => '/etc/puppet/files/assets/util/give_user_mysql_root_access vagrant'
  }

}
