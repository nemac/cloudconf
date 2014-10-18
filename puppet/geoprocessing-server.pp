import '/vagrant/settings.pp'

class { "basic-server" : }
class { "nappl-server" : }
class { "apache-server" : }

# package { 'gdal':
#   ensure => installed
# }
# 
# package { 'gdal-python':
#   ensure => installed
# }
# 
# package { 'gdal-devel':
#   ensure => installed
# }
