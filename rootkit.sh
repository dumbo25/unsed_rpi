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

Edit rkhunter's config file:

$ sudo nano /etc/default/rkhunter

and change these lines to be:

CRON_DAILY_RUN="true"

CRON_DB_UPDATE="true"


Edit chrootkit's config file:

$ sudo nano /etc/chkrootkit.conf

and change these lines to be:

RUN_DAILY="true"

RUN_DAILY_OPTS=""

Run the checkers weekly:

$ sudo mv /etc/cron.weekly/rkhunter /etc/cron.weekly/rkhunter_update

$ sudo mv /etc/cron.daily/rkhunter /etc/cron.weekly/rkhunter_run

$ sudo mv /etc/cron.daily/chkrootkit /etc/cron.weekly/

echo -e "\n ${Bold}${Blue} rootkit installation is done ${Black}${Normal}"

