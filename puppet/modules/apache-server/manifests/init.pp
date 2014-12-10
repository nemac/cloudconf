class apache-server {

  package { 'httpd':
    ensure => 'present'
  }

  service { 'httpd':
    require => Package['httpd'],
    ensure => running,            # this makes sure httpd is running now
    enable => true                # this make sure httpd starts on each boot
  }

  service { 'iptables':
    ensure => stopped,
    enable => false
  }

  service { 'ip6tables':
    ensure => stopped,
    enable => false
  }

  # make sure the log dir is accessible to the nappl group
  file { "/var/log/httpd":
    require => Package['nappl'],
    ensure  => directory,
    group   => "nappl",
    mode    => 0750
  }  

}
