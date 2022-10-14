# DeepFaceLab_MP
支持多平台的DeepFaceLab换脸，可以在服务器上快速部署换脸工程~
DeepFaceLab on Mutilplue plantforms

工程在conda虚拟环境中运行，无须担心破坏系统环境，方便安装与卸载。

附imgcat等实用小工具，默认安装直接可用~

## Intro

This project provides scripts inspired by [DeepFaceLab_Linux](https://github.com/lbfs/DeepFaceLab_Linux) and [DeepFaceLab_MacOS](https://github.com/lbfs/DeepFaceLab_Linux) to setup and run [DeepFaceLab](https://github.com/iperov/DeepFaceLab) on any operation system (except windows).

You'll need `git`, `ffmpeg` and `anaconda` available to execute these scripts. The scripts will create a conda env sandbox and will install all necessary dependencies there.


## ubuntu

大部分ubuntu服务器默认使用dash，会导致脚本中的source和conda等命令无法使用，因此安装过程需要拆分成两步。

安装命令：

```
# 下载deepfacelab并创建虚拟环境
sh ubuntu/setup_ubuntu_step1.sh
# 启动虚拟环境
conda activate dfl
# 完成最后的安装
sh ubuntu/setup_ubuntu_step1.sh
# 重启虚拟环境
conda deactivate
conda activate dfl
```

本项目在腾讯云服务器上进行部署，未测试其他平台服务器兼容情况。欢迎提CR~


## MacOS

MacOs不支持GPU加速，实测Macbook Pro可以跑，速度也还行

Attention! This project can not use GPU.



## Linux




## Windows

暂不支持

