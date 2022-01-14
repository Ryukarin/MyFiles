#!/bin/bash

# Author: karin
# Created Time: 2021/10/05
# Release: 1.0
# Script Description: EmuELEC4.x SYSTEM unpack and mkpack.

echo -n ""
clear

if [ ! -f SYSTEM ];then
	echo -e "\n请将SYSTEM文件放置于此脚本所在的同一目录\n"
	exit 0
fi

FILE_TYPE=`file SYSTEM | awk '{print $2 " " $3}' | cut -d \, -f 1`
if [ "$FILE_TYPE" != "Squashfs filesystem" ];then
	echo -e "\n此SYSTEM文件类型不适合此脚本\n"
	exit 0
fi

unsquashfs(){
	sudo apt install squashfs-tools >> /dev/null 2>&1
	echo -en "\n1.解包SYSTEM..."
	echo -en "\n\033[32m    1) 由于文件较大，解包过程比较长，请耐心等待\033[0m"
	echo -en "\n\033[32m    2) 解包完成后，会生成./squashfs-root/目录\033[0m"
	echo -en "\n\033[32m    3) 解包进行中...\033[0m"
	sudo unsquashfs SYSTEM >> /dev/null 2>&1
	echo -en "\n    \033[36m****************\033[0m"
	echo -en "\033[46;30m完成\033[0m\n"
}

edit(){
	echo -en "\n2.修改系统配置...";
	sudo sed -i 's/\/usr\/config\/splash\/emuelec_intro_1080p.mp4/\/storage\/.config\/splash\/emuelec_intro_1080p.mp4/g' ./squashfs-root/usr/bin/show_splash.sh
	sudo touch -r ./squashfs-root/usr/bin/bezels.sh ./squashfs-root/usr/bin/show_splash.sh
	echo -en "\n\033[32m    1) 默认自动修改开机视频位置：/storage/.config/splash/emuelec_intro_1080p.mp4\033[0m"
	echo -en "\n\033[32m    2) 其他配置请修改相应的文件，需要sudo权限修改\033[0m"
	echo -en "\n\033[32m    3) 相关修改完成后，按任意键继续\033[0m"
	read -p ""
	echo -en "    \033[36m****************\033[0m"
	echo -en "\033[46;30m完成\033[0m\n"
}



mksquashfs(){
	echo -en "\n3.打包SYSTEM...";
	echo -en "\n\033[32m    1) 由于文件较多，打包过程比较长，请耐心等待\033[0m"
	echo -en "\n\033[32m    2) 打包进行中...\033[0m"
	mv SYSTEM SYSTEM.bk
	sudo mksquashfs squashfs-root/ SYSTEM -comp lzo -Xalgorithm lzo1x_999 -Xcompression-level 9 -b 524288 -no-xattrs >> /dev/null 2>&1
	sudo rm -rf squashfs-root/
	echo -en "\n    \033[36m****************\033[0m"
	echo -en "\033[46;30m完成\033[0m\n"
}

end_msg(){
	echo -en "\nSYSTEM修改已完成！"
	echo -en "\n\033[;33m===================================\033[0m"
	echo -en "\n\033[43;30m说明：\033[0m"
	echo -en "\n\033[;33m # 新打包文件：SYSTEM\n # 原本的文件：SYSTEM.bk\033[0m"
	echo -en "\n\033[;33m===================================\033[0m\n\n"
}

unsquashfs
edit
mksquashfs
end_msg

