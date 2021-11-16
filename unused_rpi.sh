#!/bin/bash
# sript to remove packages from raspbian that I don't use very often
# list of all packages by size (be sure to check quotes are correct)
# dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -nr

echo remove unused raspbian packages
echo size before removal 
df -h

echo packages to remove:
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

echo size after removing packages
df -h
