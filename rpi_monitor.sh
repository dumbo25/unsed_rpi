#!/bin/bash
# script to install and setup rpi_monitor
#
# RPi-Monitor is designed to start automatically and collect metrics. The web 
# interface is available on address http://raspberrypi.local:8888.

Bold=$(tput bold)
Normal=$(tput sgr0)
Red=$(tput setaf 1)
Green=$(tput setaf 2)
Blue=$(tput setaf 4)
Black=$(tput sgr0)

echo -e "\n ${Bold}${Blue} Install and configure rpi_monitor ${Black}${Normal}"

sudo ufw allow from 192.168.1.0/24 to any port 8888

apt install dirmngr -y
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2C0D3C0F
wget http://goo.gl/vewCLL -O /etc/apt/sources.list.d/rpimonitor.list

apt update
apt install rpimonitor -y

/etc/init.d/rpimonitor update

echo -e "\n ${Bold}${Blue} rpi_monitor install script is done ${Black}${Normal}"
