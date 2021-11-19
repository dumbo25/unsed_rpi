#!/bin/bash
# script to install and setup mod_evasive
#
# mod_evasive is a module for Apache, which provides evasive action in the event
# of a Denial of Service attack or brute force attack. Install mod_evasive by 
# running the command:

Bold=$(tput bold)
Normal=$(tput sgr0)
Red=$(tput setaf 1)
Green=$(tput setaf 2)
Blue=$(tput setaf 4)
Black=$(tput sgr0)

echo -e "\n ${Bold}${Blue} Install and configure mod_evasive to lessen DOS attacks ${Black}${Normal}"

sudo apt-get install dirmngr
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2C0D3C0F
sudo wget http://goo.gl/vewCLL -O /etc/apt/sources.list.d/rpimonitor.list

sudo apt-get update
sudo apt-get install rpimonitor

RPi-Monitor is designed to start automatically and collect metrics. The web interface is available on address http://raspberrypi.local:8888.

sudo /etc/init.d/rpimonitor update
