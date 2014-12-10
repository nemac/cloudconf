class nappl-server {

  package { 'nappl':
    ensure => installed
  }

  # The nappl package creates the 'git' user.  The following
  # ensures that nappl is installed, and creates the 'git'
  # user's ~/.ssh dir:
  file { "/home/git/.ssh":
    require => Package['nappl'],
    ensure  => directory,
    owner   => "git",
    group   => "git",
    mode    => 0700
  }  

  # Ensure that the 'git' user's ~/.ssh/authorized_keys file is present; it's what
  # we use to allow staff to do "git push git@server.nemac.org ...".
  file { "/home/git/.ssh/authorized_keys":
    require => File['/home/git/.ssh'],
    ensure  => present,
    owner   => "git",
    group   => "git",
    mode    => 0600
  }

  exec { 'vagrant-user-in-git-goup':
    require => Package['nappl'],
    command => '/etc/puppet/files/assets/util/add_user_to_group vagrant git' 
  }
  exec { 'vagrant-user-in-nappl-goup':
    require => Package['nappl'],
    command => '/etc/puppet/files/assets/util/add_user_to_group vagrant nappl' 
  }
  file { '/etc/hosts':
    ensure => present,
    group => nappl,
    mode => 0664
  }

}
