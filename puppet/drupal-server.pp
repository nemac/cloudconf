import '/vagrant/settings.pp'

class { "basic-server" : }
class { "nappl-server" : }
class { "apache-server" : }
class { "mysql-server" : }
class { "php-server" : }
class { "drupal-server" : }
