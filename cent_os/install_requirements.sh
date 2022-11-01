#!/usr/bin/env bash

# Warning: This script is a demo. Do not run this script directly.

# install anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh
sh Anaconda3-2022.10-Linux-x86_64.sh

# install sz rz
yum -y install lrzsz

# install ffmpeg
# Errors may occur
yum -y install ffmpeg ffmpeg-devel

# from article https://blog.csdn.net/u013314786/article/details/89682800
wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz
xz -d ffmpeg-release-amd64-static.tar.xz
tar -xvf ffmpeg-release-amd64-static.tar
cd ffmpeg-release-amd64-static
ln -s ffmpeg /usr/bin/ffmpeg
ln -s ffprobe /usr/bin/ffprobe

# install imgcat
ln -s /root/DeepFaceLab_MP/tools/imgcat /usr/bin/imgcat
chmod 777 /usr/bin/imgcat


# install docker
yum install docker
mv /var/lib/docker /data/docker
ln -s /data/docker /var/lib/docker
service docker start
docker pull xychelsea/deepfacelab:latest-gpu

docker run --rm -it -v workspace:/usr/local/deepface/workspace \
    xychelsea/deepfacelab:latest-gpu /bin/bash

service docker stop
