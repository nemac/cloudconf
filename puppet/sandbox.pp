import '/vagrant/settings.pp'

class { "basic-server" : }
class { "apache-server" : }
class { "mariadb-server" : }
class { "php-server" : }
class { "python-json-image" : }
class { "drupal-dev-server" : }

package { 'netcdf':
  ensure => installed
}

package { 'netcdf-devel':
  ensure => installed
}

package { 'netcdf4-python':
  ensure => installed
}

package { 'nemac-proj':
  ensure => installed
}

package { 'nemac-proj-devel':
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

package { 'php-cli':
  ensure => installed
}

package { 'php-devel':
  ensure => installed
}

package { 'php-soap':
  ensure => installed
}

package { 'php-xml':
  ensure => installed
}

package { 'freetype':
  ensure => installed
}

package { 'zlib':
  ensure => installed
}

package { 'libpng':
  ensure => installed
}

package { 'libjpeg-turbo':
  ensure => installed
}

package { 'geos':
  ensure => installed
}

package { 'postgresql':
  ensure => installed
}

package { 'postgresql-libs':
  ensure => installed
}


package { 'libxml2':
  ensure => installed
}

package { 'python-psycopg2':
  ensure => installed
}

package { 'python-psycopg2-doc':
  ensure => installed
}
