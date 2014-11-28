class php-server {

  package { 'php':
    ensure => installed,
  }
  
  exec { 'set-php-memory-limit' :
    require => Package["php"],
    command => "/bin/sed -i 's/^memory_limit = .*$/memory_limit = 512M/' /etc/php.ini",
    unless  => "/bin/grep -q 'memory_limit = 512M' /etc/php.ini"
  }
  
  package { 'php-gd':
    ensure => installed,
  }
  
  package { 'php-mbstring':
    ensure => installed,
  }
 
# This package does not exist in CentOS 7; not sure what we needed it for, so leaving it
# out for now.  May need to revisit this. 
#  package { 'php-domxml-php4-php5' :
#    ensure => installed,
#  }
  
  package { 'php-pear':
    ensure => installed
  }

}
