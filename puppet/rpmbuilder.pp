import '/vagrant/settings.pp'

class { "basic-server" : }

package { 'netcdf' :
  ensure => installed
}

package { 'netcdf-devel' :
  ensure => installed
}

package { 'python' :
  ensure => installed
}

package { 'python-devel' :
  ensure => installed
}

package { 'gcc-c++' :
  ensure => installed
}

package { 'fedora-packager' :
  ensure => installed
}

package { 'createrepo' :
  ensure => installed
}

package { 'tito' :
  ensure => installed
}

package { 'cmake':
  ensure => installed
}

package { 'zlib':
  ensure => installed
}

package { 'zlib-devel':
  ensure => installed
}

package { 'libpng':
  ensure => installed
}

package { 'libpng-devel':
  ensure => installed
}

package { 'libjpeg-turbo':
  ensure => installed
}

package { 'libjpeg-turbo-devel':
  ensure => installed
}

package { 'freetype':
  ensure => installed
}

package { 'freetype-devel':
  ensure => installed
}

package { 'geos':
  ensure => installed
}

package { 'geos-devel':
  ensure => installed
}

package { 'postgresql':
  ensure => installed
}

package { 'postgresql-libs':
  ensure => installed
}

package { 'postgresql-devel':
  ensure => installed
}

package { 'libxml2':
  ensure => installed
}

package { 'libxml2-devel':
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

package { 'nemac-proj':
  ensure => installed
}

package { 'nemac-proj-devel':
  ensure => installed
}

package { 'netcdf4-python':
  ensure => installed
}

package { 'python-pandas':
  ensure => installed
}

package { 'python-psycopg2':
  ensure => installed
}

package { 'python-psycopg2-doc':
  ensure => installed
}

package { 'nodejs':
  ensure => installed
}

package { 'npm':
  ensure => installed
}

