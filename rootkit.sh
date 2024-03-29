#!/bin/bash
# script to install and setup mod_evasive
#
# A rootkit is malware designed to provide privileged access to a computer 
# while actively hiding its presence. This script installs utilities that
# try and find thi smalware on a raspberry pi
#
# rkhunter scans for rootkits, backdoors and possible local exploits. 
# 
# chrootkit checks for known rootkits. 

Bold=$(tput bold)
Normal=$(tput sgr0)
Red=$(tput setaf 1)
Green=$(tput setaf 2)
Blue=$(tput setaf 4)
Black=$(tput sgr0)

echo -e "\n ${Bold}${Blue} Install and configure tools to find rootkits ${Black}${Normal}"

apt install rkhunter chkrootkit -y

rm rkhunter
wget https://raw.githubusercontent.com/dumbo25/unsed_rpi/main/rkhunter
rm /etc/default/rkhunter
cp rkhunter /etc/default/rkhunter

rm chkrootkit.conf
wget https://raw.githubusercontent.com/dumbo25/unsed_rpi/main/chkrootkit.conf
rm /etc/chkrootkit.conf
cp chkrootkit.conf /etc/chkrootkit.conf

# Run the checkers weekly:
mv /etc/cron.weekly/rkhunter /etc/cron.weekly/rkhunter_update
mv /etc/cron.daily/rkhunter /etc/cron.weekly/rkhunter_run
mv /etc/cron.daily/chkrootkit /etc/cron.weekly/

echo -e "\n ${Bold}${Blue} rootkit installation is done ${Black}${Normal}"

