import '/vagrant/settings.pp'

class { "basic-server" : }

# needed for cirrus:
package { 'nodejs' :
  ensure => installed
}
package { 'npm' :
  ensure => installed
}
