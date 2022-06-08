#!/bin/sh

mount -o remount,rw /flash

USB_TYPE=`df -T | grep EEROMS | awk '{print $2}'`

case $USB_TYPE in
    "fuseblk")
        echo "ntfs" > /flash/ee_fstype
    	;;
    "ntfs"|"ext4"|"exfat")
    	$USB_TYPE > /flash/ee_fstype
    	;;
    *)
        echo "vfat" > /flash/ee_fstype
        ;;
esac 

mount -o remount,ro /flash

sh /usr/bin/mount_romfs.sh > /dev/null 2>&1

echo "Please Restart EmulationStation!"
