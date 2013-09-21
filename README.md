In order to run servers in this project, you need to add the following files to this
directory:

* *aws.yml*: create this file by making a copy of the file
aws-example.yml named aws.yml.  If you are only planning to use this
project to create VirtualBox servers, you do not need to edit the
values in aws.yml --- the actual values don't matter, but the file
must be present.

Also, in the cloud0 directory, create the following two files

* *settings.pp*: create this file by making a copy of the file
settings-example.pp named settings.pp.  Then edit your settings.pp to
change the mysql_root_password to something (anything) without spaces.
You don’t need to remember this password -- just make up something.

* *settings.yml*: create this file by making a copy of the file
settings-example.yml named settings.yml.  You don't need to edit this
file at all --- just create the copy.

(Important note: in all three of the above, do not simply rename the
original '*-example.*' files -- leave these files unchanged, and make
a copy of each one without the '-example' in the name.)

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
