#! /usr/bin/python

# This script creates the file "/vagrant/settings.pp" if it does not yet exist, and makes it (and the entire /vagrant directory)
# so that only root can read it.  The file contains settings for two variables for use in puppet manifests: $name, which is the
# server name, and $mysql_root_password, which is exactly what its name implies.
# 
# The reason for having this file, and having it in this location, even on systems where vagrant is not being used, is for
# consistency with systems where vagrant is being used; this way we can use the same puppet scripts in both places.

import sys, random, os

if len(sys.argv) != 2:
    print "usage: create-vagrant-settings NAME"
    sys.exit(-1)

name = sys.argv[1]

chars = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
           "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
         "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

def random_password(n):
    pwchars = []
    for i in range(n):
        pwchars.append( chars[ random.randint(0, len(chars)-1) ] )
    return "".join(pwchars)

if not os.path.exists("/vagrant"):
    os.system("mkdir /vagrant")
    os.system("chmod o=,g= /vagrant")

if not os.path.exists("/vagrant/settings.pp"):
    with open("/vagrant/settings.pp", "w") as f:
        f.write("$server_name = \"%s\"\n" % name)
        f.write("$mysql_root_password = \"%s\"\n" % random_password(16))
    os.system("chmod o=,g= /vagrant/settings.pp")


