#!/bin/bash

echo "更改为国内源..."
mv /etc/apt/sources.list /etc/apt/sources.list.bak
wget -O /etc/apt/sources.list https://raw.githubusercontent.com/Ryukarin/MyFiles/main/ttnode/sources.list

echo "更新软件包..."
apt install -y wget ca-certificates qrencode unzip tar >/dev/null 2>&1
apt update -y >/dev/null 2>&1
apt upgrade 
apt autoremove >/dev/null 2>&1

echo "设置开机自动挂载磁盘..."
mkdir /mnt/disk
DISK_DIR=/mnt/disk	#
#用`lsblk`命令查看你的磁盘信息，找到磁盘名称，如不一样，需修改下面命令的磁盘名称sda1
DISK_UUID=`blkid /dev/sda1 | awk 'BEGIN{FS="\""}{print $1 $2}' | awk '{print $2}'`
DISK_TYPE=`blkid /dev/sda1 | awk 'BEGIN{FS="\""}{print $4}'`
#挂载磁盘
mount /dev/sda1 $DISK_DIR
#设置开机自动挂载磁盘
#sed -i '$a\'$DISK_UUID'\t'$DISK_DIR'\t'$DISK_TYPE'\tdefaults\t0 0' /etc/fstab
echo -e "$DISK_UUID\t$DISK_DIR\t$DISK_TYPE\tdefaults\t0 0" >> /etc/fstab
lsblk | grep $DISK_DIR
#重新加载/etc/fstab内容
mount -a

echo "配置甜糖星愿..."
cd /usr
#if判断32 还是64
#cat /proc/version

wget https://github.com/Ryukarin/MyFiles/raw/main/ttnode/ttnode_arm32/node.tar.gz
tar -xvf node.tar.gz
rm -rf node.tar.gz
chmod 777 /usr/node/*
#启动甜糖星愿
/usr/node/ttnode -p $DISK_DIR
PS_TT=`ps -ef | grep ttnode | grep -v grep | awk 'BEGIN{FS=" /"}{print $NF}'`
echo /$PS_TT
#确认是否输出为/usr/node/ttnode

echo "设置守护进程..."
echo '* * * * * /usr/node/crash_monitor.sh' >> /etc/crontab 
#每隔一分钟执行一次/usr/node/crash_monitor.sh脚本

echo "设置开机自动开启22端口和运行甜糖星愿..."
sed -i '$d' /etc/rc.local
sed -i '$aservice sshd start' /etc/rc.local
sed -i '$a/usr/node/ttnode -p '$DISK_DIR'' /etc/rc.local
sed -i '$aexit 0' /etc/rc.local

echo "修改网卡mac地址..."
echo -e "http://www.metools.info/other/o66.html\n浏览器打开此网页，点击【MAC生成】按钮，复制生成的MAC地址"
read -p "输入上面生成的MAC地址：" MACADD
sed -i '6a\hwaddress '$MACADD'' /etc/network/interfaces
echo "部署完成！请重启系统..."
echo -e "系统重启后输入如下命令查看输出结果，是否和上面生成的MAC地址相同\nifconfig | grep ether"


 
