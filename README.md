# Raspberry Pi setup scripts
This repository is a collection of bash scripts to aid in setting up a Raspberry Pi using Raspberry Pi OS (or raspbian) to run headless. In the past, I used [diet-pi](https://dietpi.com/) or Raspberry Pi OS Lite. Overtime, I realized if I had a problem there are more web resources for Raspberry Pi OS and I switched. Also, I can control what to remove and what to keep.

raspi-config must be run before rpi_setup.sh

Some of the scripts remove packages, which isn't necessary. Removing the packages does save microSD Card space (3.0GB used after update and upgrade, and 1.8GB after pacakges removed. So, more than a 33% redeuction in microSD Card space used). I typically run rPi headless. So, I don't need or use the desktop, chrome and so on. 

Removing the packages also prevents any related services from running. A service that is unused and running wastes CPU. This is more valuable on an RPi0 and of little value on an RPi4. But, I do it anyway.

Other scripts harden the RPi against common security hacks. 

One script adds rpi monitor, wich is a webserver giving stats on your RPi.

A more detailed description of setting up a Raspberry Pi and the [Raspberry Pi OS is in this link](https://sites.google.com/site/cartwrightraspberrypiprojects/home/steps/setup-raspberry-pi-3-with-raspbian)

## rpi_setup.sh
This is the master script and runs the other scripts.

Download the script 
```
wget "https://raw.githubusercontent.com/dumbo25/unsed_rpi/main/unused_rpi.sh"
wget "https://raw.githubusercontent.com/dumbo25/unsed_rpi/main/unused_rpi.cfg"
```

Edit the .cfg to include your values (hostname, your wifi password, and so on)

sudo chmod +x rpi_setup.sh

sudo bash rpi_setup.sh

## Help

To see the help and the options.

```
sudo bash rpi_setup.sh -h 
```

