# Overview
This repository is a collection of bash scripts to aid in setting up a Raspberry Pi using Raspberry Pi OS (or raspbian) to run headless. In the past, I used [diet-pi](https://dietpi.com/) or Raspberry Pi OS Lite. Overtime, I realized if I had a problem there are more web resources for Raspberry Pi OS and I switched. Also, I can control what to remove and what to keep.

raspi-config must be run before these scripts.

Removing these pacakges isn't really necessary. They do save microSD Card space. And if any of the packages start services, then these services will not run, which could save some CPU processing time.

## unsed_rpi.sh
Remove packages I don't use.

Download the script 
wget "https://raw.githubusercontent.com/dumbo25/unsed_rpi/main/unused_rpi.sh"

sudo chmod +x unused_rpi.sh

sudo bash unused_rpi.sh

## desktop.sh
Remove desktop packages

Download the script 
wget "https://raw.githubusercontent.com/dumbo25/unsed_rpi/main/desktop.sh"

sudo chmod +x unused_rpi.sh

sudo bash unused_rpi.sh
