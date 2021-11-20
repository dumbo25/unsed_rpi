#!/bin/bash
# sript to setup uncomplicated firewall

Bold=$(tput bold)
Normal=$(tput sgr0)
Red=$(tput setaf 1)
Green=$(tput setaf 2)
Blue=$(tput setaf 4)
Black=$(tput sgr0)

echo -e "\n ${Bold}${Blue} Set up uncomplicated firewall (ufw) ${Black}${Normal}"

# enable ufw
yes | sudo ufw enable 

# configure ufw
# deny all incoming requests and allow all outgoing requests
sudo ufw default deny incoming
sudo ufw default allow outgoing

#  ssh uses port 22
# The "limit ssh" rule is good to have. It limits ssh to one connection as
# a time. However, I use three terminal windows using ssh when developing
# a new project. So, I am commenting this out
# sudo ufw limit ssh 
sudo ufw allow from 192.168.1.0/24 to any port 22
# the following line disables ssh
# sudo ufw deny ssh

# http uses port and should be allowed within the LAN
sudo ufw allow from 192.168.1.0/24 to any port 80
sudo ufw deny http

# https uses port 443 and should be allowed from within the LAN
sudo ufw allow from 192.168.1.0/24 to any port 443
sudo ufw deny https

# ICMP/ping doesn't use a port. However, this is required to allow pings form within the LAN
sudo ufw allow from 192.168.1.0/24 to any port 7

sudo ufw status

echo -e "\n ${Bold}${Blue} Done with uncomplicated firewall (ufw) ${Black}${Normal}"
