#!/bin/bash

# installing JDK from zip archive by download
install_jdk () {
echo "Parameter #1 is $1"

	# Download and Unzip
	cd /tools
	$ wget https://download.oracle.com/otn/java/jdk/8u211-b12/478a62b7d4e34b78b671c754eaaf38ab/jdk-8u211-linux-x64.tar.gz?AuthParam=1559726436_cc277fdbb24ae9269dcc4fa67f490bbb
	$ tar -xzvf jdk-xxx -C /tools/

	# Set environment
	# /etc/profile = To set environment variable to all users, $HOME/.bashrc = To set environment for login user., $HOME/.bash_profile = To set environment for login user
	$ sudo vi /etc/profile  
	export JAVA_HOME=/tools/jdk1.8.0_211
	export PATH=/tools/jdk1.8.0_211/bin:$PATH
	$ source /etc/profile
	$ java -version
}

# installing tomcat from zip archive by download
install_tomcat () {
echo "Parameter #1 is $1"
}

# installing MySQL from source by download.
install_mysql () {
echo "Parameter #1 is $1"
}

#-----------------------------------------------------------
# Install Begin

try {

mkdir /tools, cd /tools 
judge is it installed, 
	if not wget xxx, tar xxx, configurations , test is installing successful.
	if exist, alert is reinstall it.

}
catch{

undo

}


exit