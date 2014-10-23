import '/vagrant/settings.pp'

class { "basic-server" : }
class { "nappl-server" : }
class { "apache-server" : }

package { 'netcdf':
  ensure => installed
}

package { 'netcdf-devel':
  ensure => installed
}

package { 'netcdf4-python'
  ensure => installed
}

package { 'proj':
  ensure => installed
}

package { 'proj-devel':
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