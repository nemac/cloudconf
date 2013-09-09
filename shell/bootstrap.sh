#! /bin/bash

if test -f /vagrant/settings.pp ; then
  chmod g=,o= /vagrant/settings.pp
fi

if test ! -f /usr/bin/puppet ; then
  rpm -Uvh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm
  yum -y install puppet
fi

if test ! -d /etc/puppet/modules/stdlib ; then
  puppet module install puppetlabs/stdlib
fi

if test ! -f /etc/yum.repos.d/epel.repo ; then
  rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
fi

if test ! -f /etc/yum.repos.d/nemac.repo ; then
  cp /etc/puppet/files/assets/nemac/nemac.repo /etc/yum.repos.d
fi

exit 0
