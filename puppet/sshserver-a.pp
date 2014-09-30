import '/vagrant/settings.pp'

exec { disable_selinux_sysconfig:
    command => '/bin/sed -i "s@^\(SELINUX=\).*@\1disabled@" /etc/selinux/config',
    unless  => '/bin/grep -q "SELINUX=disabled" /etc/selinux/config',
}

exec { 'set-hostname':
    command => "/bin/sed -i 's/HOSTNAME=.*/HOSTNAME=${server_name}/' /etc/sysconfig/network",
    unless  => "/bin/grep -q 'HOSTNAME=${server_name}' /etc/sysconfig/network",
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

package { 'emacs-nox':
  ensure => installed
}

package { 'unzip':
  ensure => installed
}

package { 'man':
  ensure => installed
}

package { 'wget':
  ensure => installed
}

package { 'git':
  ensure => installed
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
