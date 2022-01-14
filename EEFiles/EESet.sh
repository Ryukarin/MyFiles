#!/bin/sh

# Author: karin
# Created Time: 2021/09/26
# Release: 1.0
# Script Description: EmuELEC system settings and modification scripts of aarch64 device.
# Method: Run command 'bash /flash/EESet.sh'

#touch命令参数（日期时间）
DT1=`stat /storage/.config/emuelec/configs/emuelec.conf |awk 'NR==6{print $0}'|sed -r 's/[^0-9.]+//g'|cut -b 1-12,15-17`
DT2=`stat /storage/.config/emuelec/configs/locale/zh_CN/LC_MESSAGES/emulationstation2.po |awk 'NR==6{print $0}'|sed -r 's/[^0-9.]+//g'|cut -b 1-12,15-17`
DT3=`stat /usr/bin/scripts/setup/gamelist.xml |awk 'NR==6{print $0}'|sed -r 's/[^0-9.]+//g'|cut -b 1-12,15-17`


/storage/.config/emuelec/configs/locale/zh_CN/LC_MESSAGES/emulationstation2.po

menu(){
    clear
    echo -e "\n                    \033[42;37m EESet_v4.x \033[0m"
    echo -e "+----------------------------------------------------+"
    echo -e "|\033[47;32m                                                    \033[0m|"
    echo -e "|\033[47;32m 【a】 一键优化                                     \033[0m|"
    echo -e "|\033[47;32m                                                    \033[0m|"
#    echo -e "|\033[47;32m 【b】 复制bios文件                                 \033[0m|"
#    echo -e "|\033[47;32m                                                    \033[0m|"
    echo -e "|\033[47;32m 【l】 更改语言和时区                               \033[0m|"
    echo -e "|\033[47;32m                                                    \033[0m|"
    echo -e "|\033[47;32m 【v】 修改开机视频路径                             \033[0m|"
    echo -e "|\033[47;32m                                                    \033[0m|"
    echo -e "|\033[47;32m 【d】 修复drastic安装脚本                          \033[0m|"
    echo -e "|\033[47;32m                                                    \033[0m|"
    echo -e "|\033[47;32m 【t】 优化默认主题Crystal                          \033[0m|"
    echo -e "|\033[47;32m                                                    \033[0m|"
    echo -e "|\033[47;32m 【h】 汉化Emulationstation                         \033[0m|"
    echo -e "|\033[47;32m                                                    \033[0m|"
    echo -e "|\033[47;32m 【s】 补全SETUP菜单图片                            \033[0m|"
    echo -e "|\033[47;32m                                                    \033[0m|"
    echo -e "|\033[47;32m 【c】 汉化SETUP菜单                                \033[0m|"
    echo -e "|\033[47;32m                                                    \033[0m|"
    echo -e "|\033[47;32m 【e】 还原SETUP菜单                                \033[0m|"
    echo -e "|\033[47;32m                                                    \033[0m|"
    echo -e "|\033[47;32m 【q】 退出EESet                                    \033[0m|"
    echo -e "|\033[47;32m                                                    \033[0m|"
    echo -e "+----------------------------------------------------+\n"
}

## 修改EmuELEC系统时区为上海、语言为中国
language(){
    echo -e "正在更改语言、时区..."
    sed -i 's/timezone=America\/Mexico_City/timezone=Asia\/Shanghai/g' /storage/.config/emuelec/configs/emuelec.conf 
    sed -i 's/language=en_US/language=zh_CN/g' /storage/.config/emuelec/configs/emuelec.conf
    touch -t $DT1 /storage/.config/emuelec/configs/emuelec.conf
    touch -t $DT1 /storage/.config/emuelec/configs/
}

## 对Emulationstation的汉化进行了修改及追加，更彻底
es2ch(){
    echo -e "正在汉化Emulationstation..."
    cp /flash/files/emulationstation2* /storage/.config/emuelec/configs/locale/zh_CN/LC_MESSAGES/
    find /storage/.config/emuelec/configs/locale/zh_CN/LC_MESSAGES/ -name "*" -exec touch -t $DT2 {} \;
}

## 系统setup菜单的修改配置

#补充缺失的图片
setup(){
    echo "正在修复SETUP菜单（补全缺失的图片）..."
    sed -i 's/\/usr\/bin\/scripts\/setup/\/storage\/roms\/setup/g' /storage/.config/emulationstation/es_systems.cfg
    cp -r /usr/bin/scripts/setup/ /storage/roms/ >> /dev/null 2>&1
    cp /flash/files/*.png /storage/roms/setup/downloaded_images/
    touch -t $DT1 /storage/.config/emulationstation/es_systems.cfg
    find /storage/roms/setup/ -name "*" -exec touch -t $DT3 {} \;
    touch -t $DT3 /storage/roms/setup/
}
# setup和ports菜单改为中文
setup2zh(){
    echo "正在汉化SETUP菜单..."
    cp /flash/files/setup_gamelist.xml /storage/roms/setup/gamelist.xml
#    cp /flash/files/ports_gamelist.xml /storage/roms/ports_scripts/gamelist.xml
    touch -t $DT1 /storage/roms/setup/gamelist.xml
#    touch -t $DT1 /storage/roms/ports_scripts/gamelist.xml
}
# setup和ports菜单改为英文
setup2en(){
    echo "正在还原SETUP菜单..."
    cp /usr/bin/scripts/setup/gamelist.xml /storage/roms/setup/
#    cp /usr/bin/ports/gamelist.xml /storage/roms/ports_scripts/
    touch -t $DT1 /storage/roms/setup/gamelist.xml
#    touch -t $DT1 /storage/roms/ports_scripts/gamelist.xml
}

## 修复NDS游戏模拟器drastic的脚本无法安装问题，无需联网
drastic(){
    echo "正在修复drastic的安装脚本..."
    cp /flash/files/install_drastic.sh /storage/roms/setup/
    touch -t $DT1 /storage/roms/setup/install_drastic.sh
    if grep -q "aarch64" /etc/motd; then
        cp /flash/files/drastic_aarch64.tar.gz /storage/.emulationstation/scripts/drastic.tar.gz
    else
        cp /flash/files/drastic_no_aarch64.tar.gz /storage/.emulationstation/scripts/drastic.tar.gz
    fi
    touch -t $DT1 /storage/.emulationstation/scripts/drastic.tar.gz
}

## 复制bios
#bios(){
#    echo "正在复制bios文件..."
#    cp -r /flash/files/bios/ /storage/roms/
#    touch -t $DT3 /storage/roms/bios/
#}

## 修改主题相应的字体配置文件，使菜单看起来更舒适
theme(){
    echo "正在优化默认主题Crystal..."
    cp /flash/files/OpenSans* /storage/.config/emulationstation/themes/Crystal/fonts/
    ROW1=$[`awk '/<menuTextSmall name/{print NR}' /storage/.config/emulationstation/themes/Crystal/theme.xml`+1]
    sed -i $ROW1"s"/font2m/font1s/ /storage/.config/emulationstation/themes/Crystal/theme.xml
    #ROW2=`awk '/font1m/{print NR}' /storage/.config/emulationstation/themes/Crystal/lang/zh_min.xml`
    #sed -i $ROW2"s"/OpenSans-SemiBold.ttf/OpenSans-Light.ttf/' /storage/.config/emulationstation/themes/Crystal/lang/zh_min.xml
    find /storage/.config/emulationstation/themes/Crystal/ -name "*" -exec touch -t $DT2 {} \;
}

## 开机视频可更改，替换/stoeage/.config/splash/emuelec_intro_1080p.mp4即可
video(){
    echo "正在修改开机视频路径..."
    cp /usr/bin/show_splash.sh /storage/.config/emuelec/configs/all/show_splash.sh
    sed -i 's/\/usr\/config\/splash\/emuelec_intro_1080p.mp4/\/storage\/.config\/splash\/emuelec_intro_1080p.mp4/g' /storage/.config/emuelec/configs/all/show_splash.sh
    touch -t $DT1 /storage/.config/emuelec/configs/all/show_splash.sh
    touch -t $DT1 /storage/.config/emuelec/configs/all/
    sed -i 's/\/usr\/bin\/show_splash.sh/\/storage\/.config\/emuelec\/configs\/all\/show_splash.sh/g' /storage/.config/autostart.sh
    touch -t $DT1 /storage/.config/autostart.sh
}

## 输入执行
action(){
	echo -n -e "\033[;36m请输入要执行的动作【字母】：\033[0m"
	read cc
}


selection(){
    case "$cc" in
        a|A)
	    echo ""
            language
            es2ch
            setup
            setup2zh
            drastic
#            bios
            theme
            video
            echo -e "\n一键优化已完成，请重启EmulationStation！\n";;
#        b|B)
#	    echo ""
#            bios
#            echo -e "\nbios相关文件复制已完成，添加游戏后请重启EmulationStation！\n";;
        l|L)
	    echo ""
            language
            echo -e "\n语言已改为中文，时区为上海，请重启EmulationStation！\n";;
        v|V)
	    echo ""
            video
            echo -e "\n开机视频已经可以替换，请重启EmulationStation！\n替换/storage/.config/splash/emuelec_intro_1080p.mp4即可\n";;
        d|D)
	    echo ""
            drastic
            echo -e "\ndrastic安装脚本已修复，请重启EmulationStation！\n然后再进入SETUP菜单即可进行安装\n";;
        t|T)
	    echo ""
            theme
            echo -e "\n默认主题Crystal已优化，请重启EmulationStation！\n";;
        h|H)
	    echo ""
            es2ch
            echo -e "\nEmulationstation已汉化，请重启EmulationStation！\n";;
        s|S)
	    echo ""
            setup
            echo -e "\nSETUP菜单缺失图片已补全，请重启EmulationStation！\n";;
        c|C)
	    echo ""
            setup2zh
            echo -e "\nSETUP和ports菜单已汉化，请重启EmulationStation！\n";;
        e|E)
	    echo ""
            setup2en
            echo -e "\nSETUP和ports菜单已还原，请重启EmulationStation！\n";;
        q|Q)
	    echo ""
            echo -e "正在退出EESet...\n"
            exit 0;;
        *)
            menu
            echo -e -n "\033[;31m提示：\033[0m"
            action
            selection;;
    esac
}

menu
action
selection
