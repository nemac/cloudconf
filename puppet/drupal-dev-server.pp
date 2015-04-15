import '/vagrant/settings.pp'

class { "basic-server" : }
class { "apache-server" : }
class { "mariadb-server" : }
class { "php-server" : }
class { "drupal-server" : }
class { "python-json-image" : }

class { "drupal-dev-server" : }


package { 'nemac-proj':
  ensure => installed
}

package { 'nemac-gdal':
  ensure => installed
}

package { 'nemac-gdal-devel':
  ensure => installed
}

package { 'nemac-gdal-python':
  ensure => installed
}
