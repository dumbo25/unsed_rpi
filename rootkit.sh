A rootkit is malware designed to provide privileged access to a computer while actively hiding its presence.

rkhunter scans for rootkits, backdoors and possible local exploits. 

chrootkit checks for known rootkits. 

Install the tools:

$ sudo apt-get install rkhunter chkrootkit -y

Edit rkhunter's config file:

$ sudo nano /etc/default/rkhunter

and change these lines to be:

CRON_DAILY_RUN="true"

CRON_DB_UPDATE="true"

Edit chrootkit's config file:

$ sudo nano /etc/chkrootkit.conf

and change these lines to be:

RUN_DAILY="true"

RUN_DAILY_OPTS=""

Run the checkers weekly:

$ sudo mv /etc/cron.weekly/rkhunter /etc/cron.weekly/rkhunter_update

$ sudo mv /etc/cron.daily/rkhunter /etc/cron.weekly/rkhunter_run

$ sudo mv /etc/cron.daily/chkrootkit /etc/cron.weekly/
