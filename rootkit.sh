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

A rootkit is malware designed to provide privileged access to a computer while actively hiding its presence.

rkhunter scans for rootkits, backdoors and possible local exploits. 

chrootkit checks for known rootkits. 

Install the tools:

$ sudo apt-get install rkhunter chkrootkit -y

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
