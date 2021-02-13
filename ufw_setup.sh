#!/bin/bash
# sript to setup uncomplicated firewall

echo "set up uncomplicated firwall (ufw)"

# update and uphrade packages
# sudo apt update -y
# sudo apt upgrade -y
# sudo apt autoremove -y

# install ufw
# sudo apt-get install ufw -y

# enable ufw
# sudo ufw enable

# configure ufw
#  ssh uses port 22
sudo ufw limit ssh
sudo ufw allow from 192.168.1.0/24 to any port 22
sudo ufw deny ssh

# deny all incoming requests and allow all outgoing requests
sudo ufw default deny incoming
sudo ufw default allow outgoing

# http uses port and should be allowed within the LAN
sudo ufw allow from 192.168.1.0/24 to any port 80
sudo ufw deny http

# https uses port 443 and should be allowed from within th eLAN
sudo ufw allow from 192.168.1.0/24 to any port 443
sudo ufw deny https

# ICMP/ping doesn't use a port. However, this is required to allow pings form within the LAN
sudo ufw allow from 192.168.1.0/24 to any port 7
