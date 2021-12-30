#!/bin/bash

# Author: karin
# Created Time: 2021/10/05
# Release: 1.0
# Script Description: EmuELEC4.x kernel.img unpack and mkpack.

clear

if [ ! -f kernel.img ];then
	echo -e "\n请将需要解包的kernel.img文件放置于此脚本所在的同一目录\n"
	exit 0
fi

FILE_TYPE=`file kernel.img | awk '{print $2 " " $3}' | cut -d \, -f 1`
if [ "$FILE_TYPE" != "Android bootimg" ];then
	echo -e "\n此kernel.img文件类型不适合此脚本，无法解包打包\n"
	exit 0
fi

sudo echo -n ""

down_tool(){
	echo -e "\n1.下载工具..."
	sudo apt -y install make gcc >> /dev/null 2>&1
	#git clone git@gitee.com:ryuukarin/android-unpackbootimg.git bootimg >> /dev/null 2>&1
	git clone https://github.com/anestisb/android-unpackbootimg.git bootimg >> /dev/null 2>&1
	cd bootimg
	make  >> /dev/null 2>&1
	cd ..
	echo -en "    \033[36m****************\033[0m"
	echo -en "\033[46;30m完成\033[0m\n\n"
}

unpackbootimg(){
	mkdir boot
	cd bootimg/
	echo -e "2.解包kernel.img..."
	./unpackbootimg -i ../kernel.img -o ../boot >> /dev/null 2>&1
	cd ../boot
	mkdir kernel.img-ramdisk && cd kernel.img-ramdisk
	sudo cpio -i -F ../kernel.img-ramdisk.gz >> /dev/null 2>&1
	echo -en "    \033[36m****************\033[0m"
	echo -en "\033[46;30m完成\033[0m\n\n"
}

splash(){
	echo -en "3.替换开机画面..."
	echo -en "\n\033[;32m    1) 请将要替换的图片放到该脚本所在目录下\033[0m"
	echo -en "\n\033[;32m    2) 把图片命名为kernel_splash.png\033[0m"
	echo -en "\n\033[;32m    3) 按任意建继续\033[0m"
	read -p ""

	if [ ! -f ../../kernel_splash.png ];then
		echo -en "\n\033[;33m   #) \033[0m"
		echo -en "\033[43;30m提示：\033[0m"
		echo -en "\n\033[;33m      没有kernel_splash.png图片\n      请放置图片并改名后重新运行此脚本\033[0m\n\n"
		sudo rm -rf ../../boot/
		exit 0
	fi
	sudo cp ../../kernel_splash.png ./splash/splash-1080.png
	echo -en "    \033[36m****************\033[0m"
	echo -en "\033[46;30m完成\033[0m\n\n"
}


cpram(){
	find . | cpio -o -H newc > ../kernel.img-ramdisk.gz
}

mkbootimg(){
	echo -en "4.打包kernel.img...\n"
	rm ../kernel.img-ramdisk.gz
	cpram >> /dev/null 2>&1
	cd ..
	sudo rm -rf kernel.img-ramdisk/
	mv ../kernel.img ../kernel.img.bk
	if [ ! -f kernel.img-second ];then
		../bootimg/mkbootimg --kernel kernel.img-zImage --ramdisk kernel.img-ramdisk.gz --base 01078000 --kernel_offset 00008000 --ramdisk_offset fff88000 --second_offset ffe88000 --tags_offset fef88100 -o ../kernel.img
	else
		../bootimg/mkbootimg --kernel kernel.img-zImage --ramdisk kernel.img-ramdisk.gz --second kernel.img-second --base 01078000 --kernel_offset 00008000 --ramdisk_offset fff88000 --second_offset ffe88000 --tags_offset fef88100 -o ../kernel.img
	fi
	cd ..
	rm -rf ./boot/
	echo -en "    \033[36m****************\033[0m"
	echo -en "\033[46;30m完成\033[0m\n"
}
end_msg(){
	echo -en "\nkernel.img替换开机画面已完成！"
	echo -en "\n\033[;33m===================================\033[0m"
	echo -en "\n\033[43;30m说明：\033[0m"
	echo -en "\n\033[;33m # 新打包文件：kernel.img\n # 原本的文件：kernel.img.bk\033[0m"
	echo -en "\n\033[;33m===================================\033[0m\n\n"
}

down_tool
unpackbootimg
splash
mkbootimg
end_msg

