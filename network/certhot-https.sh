#!/bin/bash

# Is package installed
function package_exists() {
    return dpkg -l "$1" &> /dev/null
}


# Add backports to sources.list
if ! [[ -n $(grep "stretch-backports" /etc/apt/sources.list) ]]; then
echo -e "\n\nAdd backports to sources.list...\n\n"
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "
deb http://deb.debian.org/debian stretch-backports main
"| sudo tee -a /etc/apt/sources.list
sudo apt-get update
echo -e "\n\nAdd backports to sources.list is successful!\n\n"
fi

# Install Certbot from backprots
if ! [[ -n $(command -v certbot) ]]; then
echo -e "\n\nInstall Certbot...\n\n"
sudo apt-get install certbot python-certbot-nginx -t stretch-backports
echo -e "\n\nInstall Certbot successful!\n\n"
fi


# Install Python
# Certbot currently requires Python 2.7 or 3.4+
if ! package_exists python3.6 ; then
	echo -e "\n\nInstall Python 3.6...\n\n"
	sudo apt-get install python3.6 -y
	echo -e "\n\nInstall Python 3.6 is successful!\n\n"
fi


# Install correct DNS plugin
if ! package_exists python3-certbot-dns-cloudflare ; then
	sudo apt-get install python3-certbot-dns-cloudflare -y
fi


# Set up credentials
sudo mkdir -p ~/.secrets/certbot
sudo touch ~/.secrets/certbot/cloudflare.ini
# Cloudflare API credentials used by Certbot
# dns_cloudflare_email = cloudflare@example.com
# dns_cloudflare_api_key = 0123456789abcdef0123456789abcdef01234567
echo "
dns_cloudflare_email = 
dns_cloudflare_api_key = 
"| sudo tee ~/.secrets/certbot/cloudflare.ini

sudo certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini \
  -d const520.com \
  -d www.const520.com 

# Run Certbot
sudo certbot run -a manual -i nginx -d const520.com

# Test automatic renewal
sudo certbot renew --dry-run