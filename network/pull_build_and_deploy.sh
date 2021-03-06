#!/bin/bash

github_user=tagnja
proj_name=hot-crawler
target_name=hotcrawler
package_manager=apt-get
server_location=inland
server_ip=$(curl http://ifconfig.me/ip)
proj_start_time=20
process_name=hotcrawler

function showProcess
{
	pid=$(pgrep -f $1 | head -n 1)
	port=$(sudo lsof -i -P | grep -i LISTEN | grep $pid)
	echo -e "\n\nYour application run at $server_ip and listen on\n$port\n\n"
}


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
fi
echo -e "\n\n Server location is $server_location. \n\n"


# install JDK
if ! [ -x "$(command -v java)" ]; then
	echo -e "\n\n Install JDK... \n\n"
	sudo $package_manager install java
	echo -e "\n\n JDK installation is successful! \n\n"
fi


# install Git
if ! [ -x "$(command -v git)" ]; then
	echo -e "\n\n Install git... \n\n"
	sudo $package_manager install git -y
	echo -e "\n\n Git installation is successful! \n\n"
fi

# install Maven
if ! [ -x "$(command -v mvn)" ]; then
	echo -e "\n\n Install maven... \n\n"
	sudo $package_manager install maven -y
	echo -e "\n\n Maven installation is successful! \n\n"
else
	# update Maven conf by server_location
	echo -e "\n\n Update maven config... \n\n" 
	

	echo -e "\n\n Update maven config is successful... \n\n" 
fi




# install redis
if ! [ -x "$(which redis-server)" ]; then
	echo -e "\n\n Install Redis... \n\n"
	sudo $package_manager install redis -y
	echo -e "\n\n Redis installation is successful! \n\n"
else
	if ! [[ -n $(pgrep -f redis) ]]; then
		echo -e "\n\n Start Redis... \n\n"
		service redis stop
		service redis start
		echo -e "\n\n Start Redis is successful! \n\n"
	else
		echo -e "\n\n Redis already started. \n\n"
	fi
fi


# git clone project
if ! [[ -n $(ls $proj_name) ]]; then
	echo -e "\n\n Git clone... \n\n"
	git clone https://github.com/$github_user/$proj_name.git
	echo -e "\n\n Git clone is successful! \n\n"
fi

# git pull project
cd $proj_name
echo -e "\n\n Pull project... \n\n"
git pull
echo -e "\n\n Pull project is successful! \n\n"

# build project
echo -e "\n\n Build project... \n\n"
mvn package spring-boot:repackage
echo -e "\n\n Build project is finished! \n\n"

# start project
if [[ -n $(pgrep -f $process_name) ]]; then
	pid=$(pgrep -f $process_name | head -n 1)
	echo -e "\n\n To kill pid $pid... \n"
	sudo kill -9 $pid
	echo -e "\n\n Kill pid $pid is successful! \n\n"
fi
echo -e "\n\n Start project... \n\n"

java -jar ./target/$target_name-1.0-SNAPSHOT.jar & 
sleep $proj_start_time
showProcess $process_name



