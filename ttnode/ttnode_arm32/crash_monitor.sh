#!/bin/bash

DISK_DIR=/mnt/disk
d=`date '+%F %T'`
num=`ps fax | grep '/ttnode' | egrep -v 'grep|echo|rpm|moni|guard' | wc -l`
echo $num;
if [ $num -lt 1 ];then
    echo "[$d] ttnode is dead...restarting" >> /usr/node/tt.log
    echo "[$d] ttnode is dead...restarting"
    /usr/node/ttnode -p $DISK_DIR
fi
