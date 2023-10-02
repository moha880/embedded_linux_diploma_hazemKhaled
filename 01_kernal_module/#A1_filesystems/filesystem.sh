#!/bin/bash


#this script is for partioning and mounting sdcard or usbflash

# Define the command to check for
desired_command="gparted"

arg1=$1
arg2=$2
arg3=$3


disk="/dev/"${arg1}


if [ -z $arg1  ];then
        echo " "$0" <disk_name> : is not specified"
        exit 1
fi


if [ -z $arg2  ];then
        echo " "$0" <number of partions>  :  is not specified"
        exit 1
fi

if [ -z $arg3  ];then
        echo " "$0" <the partion size>  :  is not specified"
        exit 1
fi

# Check if the command is available
if ! command -v "$desired_command" &>/dev/null;then
	echo "$desired_command is not installed. Attempting to install..."
    # Check if the system uses apt-get (Debian-based)
	if [ -x "$(command -v apt-get)" ]; then
		sudo apt-get update
		sudo apt-get install -y "$desired_command"
	else
        	echo "Unsupported package manager. Please install $desired_command manually."
	fi
else
    echo "$desired_command is already installed."

fi



partition_count=$(sudo parted "$disk" print | awk '/^ *[0-9]/ { count++ } END { print count }')
if [ $partition_count -eq $arg2 ];then 
	echo "already the device "$arg1" is partioned to "$arg2 "partiones"
	exit 0
else

sudo fdisk "$disk" <<EOF
m	#help
n       # Create a new partition
p       # Select primary partition type
$arg2

+10M
w
EOF
fi
