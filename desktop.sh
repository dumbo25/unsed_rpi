#!/bin/bash
# sript to remove packages from raspbian that I don't use very often
# list of all packages by size (be sure to check quotes are correct)
# dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -nr

Bold=$(tput bold)
Normal=$(tput sgr0)
Red=$(tput setaf 1)
Green=$(tput setaf 2)
Blue=$(tput setaf 4)
Black=$(tput sgr0)

echo -e "\n ${Bold}${Blue} Remove desktop packages ${Black}${Normal}"
echo -e "\n ${Bold}${Blue}   disk space used before removal ${Black}${Normal}"
df -h

echo packages to remove:
sudo apt remove --purge libreoffice* -y
sudo apt remove -—purge chromium* -y
sudo apt remove --purge libx11-.* -y
sudo apt remove --purge x11-* -y
sudo apt remove --purge xserver* -y 
sudo apt remove --purge lightdm* -y
sudo apt remove --purge raspberrypi-ui-mods -y
sudo apt remove --purge lxde* -y
sudo apt remove --purge desktop* -y
sudo apt remove --purge gnome* -y
sudo apt remove --purge gstreamer* -y
sudo apt remove --purge gtk* -y
sudo apt remove --purge hicolor-icon-theme* -y
sudo apt remove --purge lx* -y
sudo apt remove --purge mesa* -y

sudo apt autoremove -y
sudo apt clean

echo -e "\n ${Bold}${Blue}   disk space used after removal ${Black}${Normal}"
df -h
