# Raspberry Pi setup scripts
This repository is a collection of bash scripts to aid in setting up a Raspberry Pi using Raspberry Pi OS (or raspbian) to run headless. In the past, I used [diet-pi](https://dietpi.com/) or Raspberry Pi OS Lite. Overtime, I realized if I had a problem there are more web resources for Raspberry Pi OS and I switched. Also, I can control what to remove and what to keep.

raspi-config must be run before rpi_setup.sh

Some of the scripts remove pacakges, which isn't really necessary. Removing the packages does save microSD Card space. And if any of the packages start services, then these services will not run, which could save some CPU processing time. This is more valuable on an RPi0 and of little value on an RPi4.

Other scripts set up harden the RPi from common security hacks. 

One script adds rpi_monitor.

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

