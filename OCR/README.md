# Ubuntu进行OCR图片文字识别

## 安装tesseract

```shell
# 安装tesseract
sudo apt install tesseract-ocr
sudo apt install gnome-screenshot xclip imagemagick
# 下载中文库到/usr/share/tesseract-ocr/4.00/tessdata目录下
cd /usr/share/tesseract-ocr/4.00/tessdata
sudo wget https://github.com/Ryukarin/MyFiles/raw/main/OCR/chi1.traineddata
```
## 下载脚本OCR.sh
```shell
cd ~/Documents
wget https://raw.githubusercontent.com/Ryukarin/MyFiles/main/OCR/OCR.sh
chmod +x OCR.sh
```

## 设置快捷键
进入：设置→键盘 拉到底部，点击+

名称：自由设置，建议以shell脚本名称命名（如OCR）

命令：`bash ~/Documents/OCR.sh`

快捷键：设置你习惯的按键（如F4键）
