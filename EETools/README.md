## 介绍

此目录有两个脚本，分贝是对 EmuELEC 的核心系统文件 `kernel.img`、`SYSTEM` 的修改脚本。

- `kernel.sh`
- `system.sh`

## 使用

下载脚本到本地，然后执行脚本，按照提示操作即可。

`bash kernel.sh`

`bash system.sh`

## 说明

将镜像文件 `EmuELEC-xxx.img` 烧录到U盘或TF卡之后，EMUELEC分区有以下文件。

```shell
-rw-r--r-- 1 karin karin       795 10月  7 07:37 aml_autoscript
drwxr-xr-x 2 karin karin      8192 10月  7 07:37 device_trees
-rw-r--r-- 1 karin karin    344064 10月  7 07:37 dtb.img
-rw-r--r-- 1 karin karin  12871680 10月  7 07:37 kernel.img
-rw-r--r-- 1 karin karin        48 10月  7 07:37 kernel.img.md5
-rw-r--r-- 1 karin karin 811888640 10月  7 07:37 SYSTEM
-rw-r--r-- 1 karin karin        48 10月  7 07:37 SYSTEM.md5
```

其中下面两个是系统的核心组成，如需修改，则使用次此目录下的两个脚本。

- `kernel.img`

- `SYSTEM`

`kernel`：linux系统的内核

`SYSTEM`：系统文件

