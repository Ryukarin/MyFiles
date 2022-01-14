## 介绍

bios.tar.gz*：常用的各个模拟器平台所需的bios文件以及优化系统的各种文件。

EESet.sh：用于 EmuELEC 系统的优化及修改，具体如下：

- 更改语言和时区
- 更改系统开机视频路径（替换 `/storage/.config/splash/emuelec_intro_1080p.mp4` 即可）
- 解决了 drastic 安装脚本安装报错问题（NDS游戏模拟器，需用到键盘来映射手柄）
- Emulationstation 的汉化更全面
- 提供了各平台模拟器所需要的 bios 文件
- 补全原生系统 SETUP 菜单部分缺失的图片
- 对系统 SETUP菜单进行了汉化、还原

## 使用方法

启动EmuELEC主机并联网，用远程ssh工具（Putty、MobaXterm 等）连接EmuELEC主机后，执行如下命令：

账号密码分别为：`root`，`emuelec`

### 下载bios

```shell
# 下载bios文件并解压
# 分卷压缩 tar -zcf - bios/ | split -d -b 50m - bios.tar.gz
cd /storage/roms/
wegt https://github.com/Ryukarin/MyFiles/raw/main/EEFiles/bios.tar.gz00
wegt https://github.com/Ryukarin/MyFiles/raw/main/EEFiles/bios.tar.gz01
wegt https://github.com/Ryukarin/MyFiles/raw/main/EEFiles/bios.tar.gz02
wegt https://github.com/Ryukarin/MyFiles/raw/main/EEFiles/bios.tar.gz03
wegt https://github.com/Ryukarin/MyFiles/raw/main/EEFiles/bios.tar.gz04
cat bios.tar.gz* > bios.tar.gz
tar -zxf bios.tar.gz
rm -rf bios.tar.gz*
```

### 下载EESet.sh

```shell
# 下载files文件并解压
cd /flash/
wget https://github.com/Ryukarin/MyFiles/raw/main/EEFiles/files.tar.gz
tar -zxf files.tar.gz
rm -rf files.tar.gz

# 下载EESet.sh脚本文件
wget https://raw.githubusercontent.com/Ryukarin/MyFiles/main/EEFiles/EESet.sh
bash EESet.sh
# 根据脚本选择对应的功能
```



