#!/bin/bash

###########################################
#
# script_name = whatsmyip.sh
# author_name = Jefferson Kirkland
#     Company = ParsedContent Solutions
#
###########################################
#
# When this script is executed, it will try to determine if it is
# beig run on either Solaris, Linux or Mac OSx.  It then determines
# the IP and prints it out.
#
###########################################

system=$(uname)

if [ $system == "Darwin" ]
then
	/sbin/ifconfig en1 | grep "inet" | grep -v "inet6" | cut -d' ' -f2
elif [ $system == "Linux" ]
then
	/sbin/ifconfig eth0 | grep “inet addr” | cut -d: -f2 | cut -d’ ‘ -f1
elif [ $system == "SunOS" ]
then
	/sbin/ifconfig bge0 | grep "inet" | cut -d' ' -f2
else
	echo "Unknown"
fi
