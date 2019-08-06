#!/bin/bash

# Prerequisites
sudo apt-get update
sudo apt-get install -y unzip xvfb libxi6 libgconf-2-4

# Install Google Chrome

sudo curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
sudo echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
sudo apt-get -y update
sudo apt-get -y install google-chrome-stable

# Install Chrome Driver
wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
sudo mv chromedriver /usr/bin/chromedriver
sudo chown root:root /usr/bin/chromedriver
sudo chmod +x /usr/bin/chromedriver

# Download Required Jar Files
wget https://selenium-release.storage.googleapis.com/3.13/selenium-server-standalone-3.13.0.jar
wget http://www.java2s.com/Code/JarDownload/testng/testng-6.8.7.jar.zip
unzip testng-6.8.7.jar.zip

# Start Chrome via Selenium Server
xvfb-run java -Dwebdriver.chrome.driver=/usr/bin/chromedriver -jar selenium-server-standalone.jar
chromedriver --url-base=/wd/hub
