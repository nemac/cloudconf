class drupal-dev-server {

  # needed for sass/less:
  package { 'rubygem-bundler':
    ensure => installed
  }

  # needed for sass/less:
  package { 'ruby-devel':
    ensure => installed
  }

  # needed for sass/less:
  package { 'gcc':
    ensure => installed
  }

  # needed for sass/less:
  package { 'gcc-c++' :
    ensure => installed
  }

}
