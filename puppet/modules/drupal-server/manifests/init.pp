class drupal-server {

  exec { 'install-drush' :
      command => '/usr/bin/pear channel-discover pear.drush.org ; /usr/bin/pear install drush/drush ; cd /usr/share/pear/drush/lib ; /bin/mkdir tmp ; cd tmp ; /bin/tar xfz /etc/puppet/files/assets/drush-dependencies/Console_Table-1.1.3.tgz ; /bin/rm -f package.xml ; /bin/mv Console_Table-1.1.3 .. ; cd .. ; /bin/rm -rf tmp',
      unless => '/usr/bin/test -f /usr/bin/drush'
  }

}
