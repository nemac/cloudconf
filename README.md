In order to run servers in this project, you need to add the following files to this
directory:

* *aws.yml*: Amazon EC2 credentials file.  The file should have the following form:
  ```
      aws:
        instance_type     : 't1.micro'
        access_key_id     : '<amazon ec2 access key id goes here>'
        secret_access_key : '<amazon ec2 secret access key goes here>'
        keypair_name      : 'keypair1'
        security_groups   : [ 'webserver' ]
        ami               : 'ami-fc314395'
  ```
  
* *keypair1.pem*: keypair file for accessing Amazon server (this file should be named
  according to whatever the value of keypair_name is in aws.yml).   The file should
  have the following form:
  ```
      -----BEGIN RSA PRIVATE KEY-----
      ...
      -----END RSA PRIVATE KEY-----
  ```

Note that the above two files are required even if you are just running servers
locally with Virtualbox; the files are not used in that case -- the values in them may
be gibberish -- but they must be present.
  
* * In the cloud0 and cloud1 directory there are two files that you to rename.  
Rename settings-example.pp and settings-example.yml to settings.pp and settings.yml respectively.  
Also, in the setting.pp file change the mysql_root_password to something (anything) without spaces.  
Note: you don’t need to remember this password.  
  
* *puppet/assets/mysql/password.pp*: Mysql root password file.  This file should
  have the password that will be set for the Mysql 'root' account on the server;
  it should be of the following form:
  ```
    $mysql_root_password = "<mysql root password here>"
  ```

User Management
===============

To create user user mbp:

    /etc/puppet/files/assets/util/create_user USER KEYFILE

        /usr/sbin/useradd -m -U mbp
        mkdir /home/mbp/.ssh
        chown mbp.mbp /home/mbp/.ssh
        chmod g=,u= /home/mbp/.ssh
        touch /home/mbp/.ssh/authorized_keys
        chmod g=,u= /home/mbp/.ssh/authorized_keys
        <append mbp's id_rsa.pub to /home/mbp/.ssh/authorized_keys>
    

To give mbp sudoer's priv:

    /etc/puppet/files/assets/util/give_user_sudoer_priv USER

        /usr/bin/usermod -a -G admin mbp

To give mbp 'git deploy' privs:

    /etc/puppet/files/assets/util/give_user_git_priv USER KEYFILE

        /usr/bin/usermod -a -G git mbp
        <append mbp's id_rsa.pub to /home/git/.ssh/authorized_keys>

To give mbp 'nappl' privs (ability to create/delete nappl containers):

    /etc/puppet/files/assets/util/give_user_nappl_priv USER

        /usr/bin/usermod -a -G nappl mbp
        cp /root/.my.cnf /home/mbp ; chown mbp.mbp /home/mbp/.my.cnf
