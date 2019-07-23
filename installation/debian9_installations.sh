#!/bin/bash


# redis installation
function install_redis
{
	echo ""
	echo ""
	echo "Install redis begin<<<<<<<<<<<<<<<<<<<<"
	echo ""
	echo ""
	
	# download
	echo ""	
	echo "Download..."
	echo ""
	wget http://download.redis.io/releases/redis-5.0.5.tar.gz

	
	# unzip	
	echo ""
	echo "Unzip..."
	echo ""
	install_path=/tools
	sudo mkdir -p $install_path
	sudo tar -xzvf redis-5.0.5.tar.gz -C $install_path
	
	
	# make
	echo ""
	echo "Make..."
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
echo "Begin installation..."
echo ""
echo ""

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

install_redis

echo ""
echo ""
echo "All installation process is over!"
echo "************************************************************"
echo ""
echo ""

exit