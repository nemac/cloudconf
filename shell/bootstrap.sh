#! /bin/bash

if test -f /vagrant/settings.pp ; then
  chmod g=,o= /vagrant/settings.pp
fi

yum -y update

if test ! -f /usr/bin/puppet ; then
  if grep -q ' 7.0' /etc/redhat-release ; then
    # for CentOS 7:
    rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
  else
    # for CentOS d6:
    rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
    #rpm -Uvh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm
  fi
  yum -y install puppet
fi

if test ! -d /etc/puppet/modules/stdlib ; then
  puppet module install puppetlabs/stdlib
fi

if test ! -f /etc/yum.repos.d/epel.repo ; then
#  rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
   yum -y install epel-release
fi

# The following installs the NEMAC yum repository.  This obviously depends
# on the set yum.nemac.org being up and running.  If you are bootstrapping
# the server for that site itself, though, presumably it won't be up and
# running when this script runs.  To work around that:
#   1. put a copy of the git repo github.com:nemac/yum.nemac.org on ANY
#      public web server
#   2. change the address here to that server
#   3. on that server, edit the file nemac.repo to change yum.nemac.org
#      to the address of that server
#   4. configure the server (this step involves running this script)
#   5. install the yum.nemac.org site on the server
#   6. edit the file /etc/yum.repos.d/nemac.repo on the server to change
#      the URL back to yum.nemac.org
#   7. remove the temporary copy of the site that you created in step 1
if test ! -f /etc/yum.repos.d/nemac.repo ; then
  curl http://yum.nemac.org/nemac.repo > /etc/yum.repos.d/nemac.repo
fi

exit 0
