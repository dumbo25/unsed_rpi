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

echo -e "\n ${Bold}${Blue} Remove unused packages ${Black}${Normal}"

sudo apt-get install libapache2-mod-evasive -y

# Create a log directory:
sudo mkdir /var/log/mod_evasive
sudo chown www-data:www-data /var/log/mod_evasive

echo "DEBUG: neeed to change edit to sed, awk, cat or get"
exit
/etc/apache2/mods-available/evasive.conf
wget ""
$ sudo nano /etc/apache2/mods-available/evasive.conf

and 

uncomment all lines except DOSSystemCommand. 

change DOSEmailNotify to your email address.

Save and exit the editor

Restart apache2

$ sudo service apache2 restart

If failed, then install Apache2 using:

$ sudo apt install apache2 libapache2-mod-wsgi -y

$ sudo service apache2 restart
