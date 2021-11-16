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

echo -e "\n ${Bold}${Blue} Remove unused packages ${Black}${Normal}"
echo -e " ${Bold}${Blue}   disk space used before removal ${Black}${Normal}"
df -h

echo -e "\n ${Bold}${Blue}   packages to remove (ignore warnings) ${Black}${Normal}"
sudo apt remove --purge libreoffice* -y
sudo apt remove --purge wolfram-engine -y
sudo apt remove -—purge chromium-browser -y
sudo apt remove --purge scratch2 -y
sudo apt remove --purge minecraft-pi  -y
sudo apt remove --purge sonic-pi  -y
sudo apt remove --purge dillo -y
sudo apt remove --purge gpicview -y
sudo apt remove --purge penguinspuzzle -y
sudo apt remove --purge oracle-java8-jdk -y
sudo apt remove --purge openjdk-7-jre -y
sudo apt remove --purge oracle-java7-jdk -y 
sudo apt remove --purge openjdk-8-jre -y
sudo apt remove --purge libx11-.* -y
sudo apt-get remove --purge x11-* -y

sudo apt autoremove -y
sudo apt clean

echo -e "\n ${Bold}${Blue}   disk space used after removal ${Black}${Normal}"
df -h
