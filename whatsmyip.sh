#!/bin/bash

####################################################################
#
# script_name = whatsmyip.sh
# author_name = Jefferson Kirkland
#     Company = ParsedContent Solutions
#
####################################################################
#
# When this script is executed, it will try to determine if it is
# beig run on either Solaris, Linux or Mac OSx.  It then determines
# the IP and prints it out.
# 
####################################################################

### Functions ###
get_macnics() {
	ifconfig  | grep UP | grep en | cut -d: -f1
}

get_linuxnics() {
	ifconfig | grep inet | grep -v inet6 | grep -v "127.0" | cut -d: -f2 | cut -d' ' -f1
}

get_solarisnics() {
	ifconfig | grep inet | grep -v "127.0" | cut -d' ' -f2
}

get_macip() {
	for i in "${Interfaces[@]}"
	do
		if [[ $(ifconfig $i | grep inet) ]]
		then
			Upinterfaces=("${Upinterfaces[@]}" $(ifconfig $i | grep inet | grep -v "inet6" | cut -d' ' -f2));
		fi
	done
	for t in "${Upinterfaces[@]}"
    do  
		echo $t
    done
}


### Array Declarations
declare -a Interfaces=()
declare -a Upinterfaces=()

### Variable Declarations
system=$(uname)

if [ $system == "Darwin" ]
then
	Interfaces=("${Interfaces[@]}" $(get_macnics));
	get_macip
elif [ $system == "Linux" ]
then
	get_linuxnics
elif [ $system == "SunOS" ]
then
	/sbin/ifconfig bge0 | grep "inet" | cut -d' ' -f2
else
	echo "Unknown"
fi
