#!/bin/bash

server_location=inland
package_manager=apt-get

# check package manager
echo -e "\n\n Check package manager... \n\n"
if [ -x "$(command -v yum)" ]; then
	package_manager=yum
fi
echo -e "\n\n Package manager is $package_manager. \n\n"


# check server location
echo -e "\n\n Check server location... \n\n"
ping -c 1 -w 5 google.com 
if [ $? -eq 0 ]; then 
	server_location=abroad
	echo "server is abroad."
else
	echo "server is inland."
fi
echo -e "\n\n Server location is $server_location. \n\n"


# update sources.list
if [ "$server_location" = "inland" ]; then 
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
echo "\n\n sources.list update to aliyun. \n\n"
fi

# install sudo
if ! [ -x "$(command -v sudo)" ]; then
    echo -e "\n\n install sudo ... \n\n"
    $package_manager install sudo -y
    echo -e "\n\n install sudo is successful ! \n\n"
fi

# apt update
sudo $package_manager update && $package_manager upgrade -y && $package_manager autoremove && $package_manager autoclean

# system basic
if [ "$package_manager" = "yum" ]; then 
	sudo yum -y install yum-utils
	sudo yum -y groupinstall development
fi



# install make
if ! [ -x "$(command -v make)" ]; then
    echo -e "\n\n Install make... \n\n"
    sudo $package_manager install build-essential -y
    echo -e "\n\n Install make is successful! \n\n"
fi

# install python3
if ! [ -x "$(command -v python)" ]; then
	echo -e "\n\n Install python... \n\n"
	if [ "$package_manager" = "yum" ]; then 
		# IUS Community repositories
		sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm
		sudo yum -y install python36u python36u-pip 
		sudo yum -y python36u-devel
	else
		sudo apt-get install python3.6
	fi
	python --version
	echo -e "\n\n Install python 3.6 is successful ! \n\n"
fi

# install packages
declare -a arr=("wget" "curl" "pgrep" "lsof" "git" "vim")

for i in "${arr[@]}"; do
	if ! [ -x "$(command -v $i)" ]; then
		echo -e "\n\n Install $i ... \n\n"
		sudo $package_manager install $i -y
		echo -e "\n\n Install $i is successful! \n\n"
	else
		echo -e "\n\n $i is already installed ! \n\n"
	fi
done



# config vim
if [ -x "$(command -v vim)" ]; then
echo "
:set number

set tabstop=4       
set shiftwidth=4    
set softtabstop=4   
set expandtab      

set autoindent     
set cindent        

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
"| sudo tee ~/.vimrc
fi
