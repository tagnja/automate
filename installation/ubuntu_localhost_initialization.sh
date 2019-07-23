#!/bin/bash

# Update source.list

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
"| sudo tee /etc/apt/sources.list  # add -a for append (>>) ;
sudo apt-get update
sudo apt-get upgrade

# Install basic software

if ! [ -x "$(command -v sudo)" ]; then
    echo ""
    echo "Install sudo<<<<<<<<<<<<<<<<<<<<"
    echo ""
    apt-get install sudo -y
    echo ""
    echo "Install sudo is successful! >>>>>>>>>>>>>>>>>>>>>>"
    echo ""
fi

if ! [ -x "$(command -v make)" ]; then
    echo ""
    echo "Install make<<<<<<<<<<<<<<<<<<<<"
    echo ""
    sudo apt-get install build-essential -y
    echo ""
    echo "Install make is successful! >>>>>>>>>>>>>>>>>>>>>>"
    echo ""
fi

if ! [ -x "$(command -v wget)" ]; then
    echo ""
    echo "Install wget<<<<<<<<<<<<<<<<<<<<"
    echo ""
    sudo apt-get install wget -y
    echo ""
    echo "Install wget is successful! >>>>>>>>>>>>>>>>>>>>>>"
    echo ""
fi

if ! [ -x "$(command -v curl)" ]; then
    echo ""
    echo "Install curl<<<<<<<<<<<<<<<<<<<<"
    echo ""
    sudo apt-get install curl -y
    echo ""
    echo "Install curl is successful! >>>>>>>>>>>>>>>>>>>>>>"
    echo ""
fi