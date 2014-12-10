class basic-server {

  class { "nappl-server" : }

  exec { disable_selinux_sysconfig:
      command => '/bin/sed -i "s@^\(SELINUX=\).*@\1disabled@" /etc/selinux/config',
      unless  => '/bin/grep -q "SELINUX=disabled" /etc/selinux/config',
  }

  exec { 'set-hostname':
      # this is for CentOS 7:
      command => "/usr/bin/hostnamectl set-hostname ${server_name}"
      # this was for CentOS 6:
      #   command => "/bin/sed -i 's/HOSTNAME=.*/HOSTNAME=${server_name}/' /etc/sysconfig/network",
      #   unless  => "/bin/grep -q 'HOSTNAME=${server_name}' /etc/sysconfig/network",
  }

  exec { 'etc-hosts':
      command => "/bin/echo '127.0.0.1 ${server_name}' >> /etc/hosts",
      unless  => "/bin/grep -q '127.0.0.1 ${server_name}' /etc/hosts",
  }

  file { "/etc/ssh/ssh_config" :
    ensure => present,
    source => "/etc/puppet/files/assets/ssh/ssh_config",
    owner   => "root",
    group   => "root"
  }

  group { "admin" :
    ensure => present,
    system => true
  }

  exec { "admin-group-can-sudo":
    require => Group['admin'],
    command => '/bin/chmod u+w /etc/sudoers ; echo "%admin ALL=NOPASSWD: ALL" >> /etc/sudoers ; /bin/chmod u-w /etc/sudoers',
    unless  => '/bin/grep -q "%admin ALL=NOPASSWD: ALL" /etc/sudoers'
  }

  package { 'emacs-nox':
    ensure => installed
  }

  package { 'unzip':
    ensure => installed
  }

  #package { 'man': # package name changed from 'man' to 'man-pages' with CentOS 7
  package { 'man-pages':
    ensure => installed
  }

  package { 'make':
    ensure => installed
  }

  package { 'wget':
    ensure => installed
  }

  package { 'git':
    ensure => installed
  }

  package { 'screen':
    ensure => installed
  }

}
