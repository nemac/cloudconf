This directory contains the configuration for the 'cloud0' server, which supports:

* Apache Web Sites
* Drupal Web Sites

In order to start this server, you need to add the following file:

* *puppet/assets/mysql/password.pp*: Mysql root password file.  This file should
  have the password that will be set for the Mysql 'root' account on the server;
  it should be of the following form:
  ```
    $mysql_root_password = "<mysql root password here>"
  ```
