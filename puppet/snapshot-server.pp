import '/vagrant/settings.pp'

class { "basic-server" : }

package { 'nodejs':
  ensure => installed
}

package { 'npm':
  ensure => installed
}

package { 'awscli':
  ensure => installed
}
