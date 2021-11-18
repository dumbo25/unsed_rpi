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

. rpi_setup.cfg

sudo apt-get install libapache2-mod-evasive -y

# Create a log directory:
sudo mkdir /var/log/mod_evasive
sudo chown www-data:www-data /var/log/mod_evasive

rm evasive.conf
wget "https://raw.githubusercontent.com/dumbo25/unsed_rpi/main/evasive.conf"

echo "DEBUG: neeed to change edit to sed"
sed -i 's/#DOSEmailNotify.*/DOSEmailNotify '"$YourEmail'"/g' evasive.conf
# sed -i 's,'"$pattern"',Say hurrah to &: \0/,' "$file"
exit
echo "DEBUG: neeed to change above"

sudo cp evasive.conf /etc/apache2/mods-available/evasive.conf

sudo service apache2 restart

echo -e "\n ${Bold}${Blue} mod_evasive is done ${Black}${Normal}"
