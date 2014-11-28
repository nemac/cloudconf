#! /usr/bin/python

# This script creates the file "/vagrant/settings.pp" if it does not yet exist, and makes it (and the entire /vagrant directory)
# so that only root can read it.  The file contains the variable $name, which is the server name.
# 
# The reason for having this file, and having it in this location, even on systems where vagrant is not being used, is for
# consistency with systems where vagrant is being used; this way we can use the same puppet scripts in both places.

import sys, random, os

if len(sys.argv) != 2:
    print "usage: create-vagrant-settings NAME"
    sys.exit(-1)

name = sys.argv[1]

if not os.path.exists("/vagrant"):
    os.system("mkdir /vagrant")
    os.system("chmod o=,g= /vagrant")

with open("/vagrant/settings.pp", "w") as f:
    f.write("$server_name = \"%s\"\n" % name)

os.system("chmod o=,g= /vagrant/settings.pp")
