sudo apt-get install dirmngr
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2C0D3C0F
sudo wget http://goo.gl/vewCLL -O /etc/apt/sources.list.d/rpimonitor.list

sudo apt-get update
sudo apt-get install rpimonitor

RPi-Monitor is designed to start automatically and collect metrics. The web interface is available on address http://raspberrypi.local:8888.

sudo /etc/init.d/rpimonitor update
