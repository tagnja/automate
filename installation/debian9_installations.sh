#!/bin/bash

function install_redis
{
	echo ""
	echo ""
	echo "install redis begin<<<<<<<<<<<<<<<<<<<<"
	echo ""
	echo ""
	
	# download
	echo ""	
	echo "download..."
	echo ""
	wget http://download.redis.io/releases/redis-5.0.5.tar.gz

	
	# unzip	
	echo ""
	echo "unzip..."
	echo ""
	install_path=/tools
	sudo mkdir -p $install_path
	sudo tar -xzvf redis-5.0.5.tar.gz -C $install_path
	
	
	# make
	echo ""
	echo "make..."
	echo ""
	cd $install_path/redis-5.0.5
	sudo make

	# result
	echo ""
	echo ""
	echo "Install redis is successful! ( Start redis using $ cd /tools/redis-5.0.5; ./src/redis-server; )"
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	echo "";
	echo "";


}

# main

echo "************************************************************"
echo "begin installation..."
echo ""
echo ""

if ! [ -x "$(command -v sudo)" ]; then
    echo ""
    echo "install sudo<<<<<<<<<<<<<<<<<<<<"
    echo ""
    apt-get install sudo -y
    echo ""
    echo "install sudo is successful! >>>>>>>>>>>>>>>>>>>>>>"
    echo ""
fi

if ! [ -x "$(command -v make)" ]; then
    echo ""
    echo "install make<<<<<<<<<<<<<<<<<<<<"
    echo ""
    sudo apt-get install build-essential -y
    echo ""
    echo "install make is successful! >>>>>>>>>>>>>>>>>>>>>>"
    echo ""
fi

install_redis

echo ""
echo ""
echo "All installation process is over!"
echo "************************************************************"
echo ""
echo ""

exit