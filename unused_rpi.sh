#!/bin/bash
# sript to remove packages from raspbian that I don't use very often
# list of all packages by size (be sure to check quotes are correct)
# dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -nr

echo remove unused raspbian packages
echo size before removal 
df -h

echo packages to remove:
sudo apt-get remove --purge libreoffice* -y
sudo apt-get remove --purge wolfram-engine -y
sudo apt-get remove -—purge chromium-browser -y
sudo apt-get remove --purge scratch2 -y
sudo apt-get remove --purge minecraft-pi  -y
sudo apt-get remove --purge sonic-pi  -y
sudo apt-get remove --purge dillo -y
sudo apt-get remove --purge gpicview -y
sudo apt-get remove --purge penguinspuzzle -y
sudo apt-get remove --purge oracle-java8-jdk -y
sudo apt-get remove --purge openjdk-7-jre -y
sudo apt-get remove --purge oracle-java7-jdk -y 
sudo apt-get remove --purge openjdk-8-jre -y

sudo apt-get clean
sudo apt-get autoremove -y

echo size after removing packages
df -h
