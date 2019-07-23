#!/bin/bash



# JDK installation

function install_jdk
{
	echo ""
	echo ""
	echo "Install jdk begin<<<<<<<<<<<<<<<<<<<<"
	echo ""
	echo ""	
	
	if [ -x "$(command -v java)" ]; then
		echo ""
		echo "jdk is exist!"
		echo ""
	else
	
		if ! [[ -n $(ls | grep jdk*.tar.gz) ]]; then
			echo "[ERROR] The jdk-xxx.tar.gz file is not exist in current path! Please upload jdk installation package."
		else			
			archive_filename=$(ls | grep jdk*.tar.gz | head -n 1)
			sudo tar xzvf $archive_filename -C $install_path
			
			# configuring environment
			jdk_name=$(tar tf $archive_filename | head -n 1)
			jdk_name=${jdk_name/\/*/}

			JAVA_HOME=$install_path/$jdk_name
			echo "java home is $JAVA_HOME"
			if [ -d $JAVA_HOME/bin ]; then
				sed -i "/\b\(JAVA_HOME\)\b/d" ~/.profile
echo "
export JAVA_HOME=$JAVA_HOME
export PATH=\$PATH:\$JAVA_HOME/bin
">>~/.profile ;
				echo ""
				echo "Success! You need logout or restart. Your JAVA_HOME is $JAVA_HOME"
        		echo ""
			else
				echo ""
				echo "Fail! $JAVA_HOME/bin is invalid directory";
				echo ""
			fi
		fi
	fi
	
}

function uninstall_jdk
{
	sudo rm -rf /tools/jdk*
	sed -i "/\b\(JAVA_HOME\)\b/d" ~/.profile
	echo ""
	echo "Uninstall jdk is successful!"
	echo ""
}

# MySQL installation

function install_mysql
{
	echo ""
	echo "Install mysql is successful!"
	echo ""
}

function uninstall_mysql
{
	echo ""
	echo "Uninstall mysql is successful!"
	echo ""
}

# Tomcat installation

function install_tomcat
{
	echo ""
	echo "Install tomcat is successful!"
	echo ""
}

function uninstall_tomcat
{
	echo ""
	echo "Uninstall tomcat is successful!"
	echo ""
}

# redis installation
function install_redis
{
	echo ""
	echo ""
	echo "Install redis begin<<<<<<<<<<<<<<<<<<<<"
	echo ""
	echo ""
	
	if [[ -n $(find /tools -name redis-server) ]] 
	then
		echo ""
		echo "redis is exist!"
		echo ""
	else
		# download
		if [[ -n $(ls | grep redis) ]]; then
			echo "Move old package..."
			sudo mkdir -p oldPackage
			sudo mv redis* oldPackage/
		fi
		echo ""	
		echo "Download..."
		echo ""
		wget http://download.redis.io/releases/redis-5.0.5.tar.gz

		
		# unzip	
		echo ""
		echo "Unzip..."
		echo ""
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
	fi
}

function uninstall_redis
{
	sudo rm -rf /tools/redis*
	echo ""
	echo "Uninstall redis is successful!"
	echo ""
}

function install_nginx
{
	echo ""
	echo ""
	echo "Install nginx begin<<<<<<<<<<<<<<<<<<<<"
	echo ""
	echo ""
	
	# PCRE – Supports regular expressions. Required by the NGINX Core and Rewrite modules.
	wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.42.tar.gz
	tar -zxf pcre-8.42.tar.gz -C $install_path
	cd $install_path/pcre-8.42
	./configure
	sudo make
	sudo make install
	
	# zlib – Supports header compression. Required by the NGINX Gzip module.
	wget http://zlib.net/zlib-1.2.11.tar.gz
	tar -zxf zlib-1.2.11.tar.gz -C $install_path
	cd $install_path/zlib-1.2.11
	./configure
	sudo make
	sudo make install
	
	# OpenSSL – Supports the HTTPS protocol. Required by the NGINX SSL module and others.
	wget http://www.openssl.org/source/openssl-1.1.1b.tar.gz
	tar -zxf openssl-1.1.1b.tar.gz -C $install_path
	cd $install_path/openssl-1.1.1b
	./Configure darwin64-x86_64-cc --prefix=/usr
	sudo make
	sudo make install
	
	# Downloading the Sources
	wget https://nginx.org/download/nginx-1.14.2.tar.gz
	tar zxf nginx-1.14.2.tar.gz -C $install_path
	cd $install_path/nginx-1.14.2
	./configure
	#sudo make
	#sudo make install
	#sudo nginx
}

function uninstall_nginx
{
	echo ""
	echo "Uninstall nginx is successful!"
	echo ""
}

# main

echo "************************************************************"
echo "Begin installation..."
echo ""
echo ""


# Environment Check


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


# begin installation

install_path=/tools
sudo mkdir -p $install_path

read -p "
Please select your operation:
1. install 2. uninstall
" operation_code


if [ $operation_code=1 ]; then 
	read -p "
Selecting your want to install package:
0. install All 1. install JDK 2. install MySQL 3.intsall Tomcat 4.intsall Redis 5. nginx 
" install_code
	for (( i=0; i<${#install_code}; i++)); do
		case ${install_code:i:1} in
		0) install_jdk
			install_mysql 
			install_tomcat 
			install_redis 
			;;
		1) install_jdk 
			;;
		2) install_mysql 
			;;
		3) install_tomcat 
			;;
		4) install_redis 
			;;
		5) install_nginx
			;;
		esac
	done
else
	read -p "
Selecting your want to uninstall package:
0. uninstall All 1. uninstall JDK 2. uninstall MySQL 3.uninstall Tomcat 4.uninstall Redis 5. uninstall nginx 
" uninstall_code
	for (( i=0; i<${#uninstall_code}; i++)); do
		case ${uninstall_code:i:1} in
		0) uninstall_jdk
			uninstall_mysql 
			uninstall_tomcat 
			uninstall_redis
			uninstall_nginx
			;;
		1) uninstall_jdk 
			;;
		2) uninstall_mysql 
			;;
		3) uninstall_tomcat 
			;;
		4) uninstall_redis 
			;;
		5) uninstall_nginx
			;;
		esac
	done
fi


echo ""
echo ""
echo "All tasks are over!"
echo "************************************************************"
echo ""
echo ""

exit
