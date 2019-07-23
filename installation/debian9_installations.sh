#!/bin/bash

install_redis () {

echo "install redis begin..."
wget http://download.redis.io/releases/redis-5.0.5.tar.gz
install_path=/tools
if [ ! $jdk_path ]; then
	mkdir /tools
	return
fi
tar -xzvf redis-5.0.5.tar.gz -C /tools/
cd /tools/redis-5.0.5
make
bash /src/redis-server
echo "install redis end..."

}

echo "******************************"

install_redis

echo "All installation process is over!"

exit