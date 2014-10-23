import '/vagrant/settings.pp'

class { "basic-server" : }
class { "nappl-server" : }

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
