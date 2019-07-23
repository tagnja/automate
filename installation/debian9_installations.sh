#!/bin/bash

install_redis () {

	echo "**************************"
	echo "install redis begin..."

	# download
	echo ""	
	echo "download<<<<<<<<<<<<<<<<<<"
	wget http://download.redis.io/releases/redis-5.0.5.tar.gz

	
	# unzip	
	echo ""
	echo "unzip<<<<<<<<<<<<<<<<<<<<<"
	install_path=/tools
	sudo mkdir -p $install_path
	sudo tar -xzvf redis-5.0.5.tar.gz -C $install_path
	
	
	# make
	echo ""
	echo "make<<<<<<<<<<<<<<<<<<<<<<"
	cd $install_path/redis-5.0.5
	sudo make

	# result
	echo ""
	echo ""
	echo "Install redis is successful!...start redis using ./src/redis-server"
	echo "**************************"


}

echo "******************************"

install_redis

echo ""
echo ""
echo "All installation process is over!"
echo "******************************"

exit