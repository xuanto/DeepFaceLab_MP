#!/usr/bin/env bash

set -e

# install anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh
sh Anaconda3-2022.10-Linux-x86_64.sh

# install ffmpeg
# yum -y install ffmpeg ffmpeg-devel

# from article https://blog.csdn.net/u013314786/article/details/89682800
wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz
xz -d ffmpeg-release-amd64-static.tar.xz
tar -xvf ffmpeg-release-amd64-static.tar.xz
cd ffmpeg-release-amd64-static
ln -s /data/software/ffmpeg-git-20190424-amd64-static/ffmpeg /usr/binffmpeg
ln -s /data/software/ffmpeg-git-20190424-amd64-static/ffprobe /usr/binffprobe

echo "successfully install ffmpeg ffprobe"
