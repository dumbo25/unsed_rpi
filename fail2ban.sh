#!/bin/bash
# sript to setup fail2ban

Bold=$(tput bold)
Normal=$(tput sgr0)
Red=$(tput setaf 1)
Green=$(tput setaf 2)
Blue=$(tput setaf 4)
Black=$(tput sgr0)

echo -e "\n ${Bold}${Blue} Set up fail2ban ${Black}${Normal}"

apt install fail2ban -y

systemctl start fail2ban
systemctl enable fail2ban

> /etc/fail2ban/jail.local
echo "[sshd]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "port = 22" >> /etc/fail2ban/jail.local
echo "filter = sshd" >> /etc/fail2ban/jail.local
echo "logpath = /var/log/auth.log" >> /etc/fail2ban/jail.local
echo "maxretry = 3" >> /etc/fail2ban/jail.local

systemctl restart fail2ban

echo -e "\n ${Bold}${Blue} fail2ban set up complete ${Black}${Normal}"
