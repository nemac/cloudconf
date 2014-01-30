package { 'nodejs':
  ensure => installed
}

package { 'npm':
  ensure => installed
}

package { 'mongodb':
  ensure => installed
}

package { 'mongodb-server':
  ensure => installed
}
