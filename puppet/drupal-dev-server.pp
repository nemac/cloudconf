import '/vagrant/settings.pp'

class { "basic-server" : }
class { "apache-server" : }
class { "mariadb-server" : }
class { "php-server" : }
class { "drupal-server" : }
class { "python-json-image" : }

class { "drupal-dev-server" : }
