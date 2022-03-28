#!/bin/env bash 
# Dependencies: tesseract-ocr imagemagick gnome-screenshot xclip

#Name: OCR Picture
#Author:andrew
#Fuction: take a screenshot and OCR the letters in the picture
#Path: /home/Username/...
#Date: 2020-02-10

#you can only scan one character at a time
#下面路径的Username为你自己的家目录

SCR="/home/Username/Documents/temp"

####take a shot what you wana to OCR to text
gnome-screenshot -a -f $SCR.png

####increase the png
mogrify -modulate 100,0 -resize 400% $SCR.png 
#should increase detection rate

####OCR by tesseract
tesseract $SCR.png $SCR &> /dev/null -l eng+chi1

####去除识别内容的空格、最后一行
sed -i 's/ //g' $SCR.txt
sed -i '$d' $SCR.txt

####识别内容复制到剪切板
cat $SCR.txt | xclip -selection clipboard

####打开识别后的文本文件，不需要则注销即可
gedit $SCR.txt

exit
