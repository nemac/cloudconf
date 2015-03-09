class nfs-server {
  exec { lockd_tcpport:
      command => '/bin/echo "LOCKD_TCPPORT=32803" >> /etc/sysconfig/nfs',
      unless  => '/bin/grep -q "^LOCKD_TCPPORT=32803$" /etc/sysconfig/nfs'
  }

  exec { lockd_udpport:
      command => '/bin/echo "LOCKD_UDPPORT=32769" >> /etc/sysconfig/nfs',
      unless  => '/bin/grep -q "^LOCKD_UDPPORT=32769$" /etc/sysconfig/nfs'
  }

  exec { mountd_port:
      command => '/bin/echo "MOUNTD_PORT=892" >> /etc/sysconfig/nfs',
      unless  => '/bin/grep -q "^MOUNTD_PORT=892$" /etc/sysconfig/nfs'
  }

  service { 'rpcbind':
    ensure => running,
    enable => true,
    subscribe => [Exec['lockd_tcpport'],Exec['lockd_udpport'],Exec['mountd_port']]
  }

  service { 'nfs':
    ensure => running,
#   enable => true,
    subscribe => [Exec['lockd_tcpport'],Exec['lockd_udpport'],Exec['mountd_port'],Service['rpcbind']]
  }

}
