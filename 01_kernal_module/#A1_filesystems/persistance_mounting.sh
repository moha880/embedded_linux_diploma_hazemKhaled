#!/bin/bash


#this script is for partioning and mounting sdcard or usbflash


device=$1

if [ -z $device  ];then
        echo " "$0" <file_system_type> : "$device" is not specified"
        exit 1
fi


device_path="/dev/"${device}

mounting_point=$(findmnt -n -o target "$device_path")

filesystem_type=$(lsblk -o FSTYPE "$device_path" | tail -n 1)

uuid=$(sudo blkid -s UUID -o value "$device_path")


echo "Filesystem type of $device is: $filesystem_type"


sudo echo "# "$mounting_point" was on "$device_path" during installation" >> /etc/fstab

sudo echo "UUID="$uuid"		"$mounting_point"	"$filesystem_type"	defaults    0   2" >> /etc/fstab
