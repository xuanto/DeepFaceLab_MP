#!/usr/bin/env bash

set -e

# install python3-virtualenv
sudo yum install python3-virtualenv

# install ffmpeg
# from article: https://blog.csdn.net/XIAOGUANG_/article/details/105343886
sudo yum install epel-release -y
sudo yum update -y
sudo rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
sudo yum -y install ffmpeg ffmpeg-devel
