## Armbian系统部署甜糖星愿

### 使用说明：

玩客云（网心云）等Armbian版32位

玩客云刷好armbian系统后，连上网线，U盘插入设备，root进入系统执行以下命令

```shell
#lsblk
#事先查看你的U盘设备名是否为 /dev/sda1，不是的话需要将下面下载的脚本中的/dev/sda1替换成你查看到的设备名
wget https://raw.githubusercontent.com/Ryukarin/MyFiles/main/ttnode/ttnode_arm32/tt_setup.sh
bash tt_setup.sh
```

