#!/bin/bash


#this script is for partioning and mounting sdcard or usbflash


filesystem_type=$1
arg2=$2


if [ -z $filesystem_type  ];then
        echo " "$0" <file_system_type> : "$filesystem_type" is not specified"
        exit 1
fi


if [ -z $arg2  ];then
        echo " "$0" <partition_select>  : "$arg2" is not specified"
        exit 1
fi

mount_point="/mnt/mnt$filesystem_type"


sudo mkfs.$filesystem_type /dev/$arg2
sudo mkdir -p ${mount_point}

sudo mount -t ${filesystem_type} /dev/${arg2} ${mount_point}
