#!/bin/bash

github_user=tagnja
proj_name=hot-crawler
target_name=hotcrawler

if ! [ -x "$(command -v git)" ]; then
	echo -e "\n\ninstall git...\n\n"
	sudo apt-get install git -y
	echo -e "\n\ngit installation is successful!\n\n"
fi

if ! [ -x "$(command -v mvn)" ]; then
	echo -e "\n\ninstall maven...\n\n"
	sudo apt-get install maven -y
	echo -e "\n\nmaven installation is successful!\n\n"
fi


if ! [[ -n $(ls $proj_name) ]]; then
	git clone https://github.com/$github_user/$proj_name.git
fi

cd $proj_name
git pull
mvn package spring-boot:repackage

if [[ -n $(pgrep -f java) ]]; then
	pid=$(pgrep -f java | head -n 1)
	echo -e "\n\nkill pid $pid\n\n"
	sudo kill -9 $pid
	echo -e "\n\nkill pid $pid is successful!\n\n"
fi

echo -e "\n\nstart project..\n\n"
java -jar ./target/$target_name-1.0-SNAPSHOT.jar &

