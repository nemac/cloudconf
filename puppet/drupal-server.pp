import '/vagrant/settings.pp'

class { "basic-server" : }
class { "nappl-server" : }
class { "apache-server" : }
class { "mariadb-server" : }
class { "php-server" : }
class { "drupal-server" : }
