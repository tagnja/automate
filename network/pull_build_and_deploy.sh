#!/bin/bash

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

proj_name=hot-crawler
if ! [[ -n ls $proj_name ]]
	git clone https://github.com/tagnja/hot-crawler.git
fi

cd $proj_name
mvn package spring-boot:repackage

if [[ -n $(pgrep -f java) ]]
	pid=$(pgrep -f java | head -n 1)
	echo -e "\n\nkill pid $pid\n\n"
	sudo kill -9 $pid
	echo -e "\n\nkill pid $pid is successful!\n\n"
fi

java -jar ./target/hotcrawler-1.0-SNAPSHOT.jar &