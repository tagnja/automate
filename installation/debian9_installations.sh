#!/bin/bash



# JDK installation

function install_jdk
{
    echo ""	
}

# MySQL installation

function install_mysql
{
   echo ""
}

# Tomcat installation

function install_tomcat
{
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

# main

echo "************************************************************"
echo "Begin installation..."
echo ""
echo ""

# Input what to install. 

read -p "
Selecting your want to install package:
1.JDK 2.MySQL 3.Tomcat 4.Redis 0.ALL
" install_code


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


# begin installation

install_path=/tools
sudo mkdir -p $install_path

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
    esac
done


echo ""
echo ""
echo "All installation process is over!"
echo "************************************************************"
echo ""
echo ""

exit