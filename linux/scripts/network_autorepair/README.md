# Raspberry Pi (and Linux) Wifi Repair Automation
> This bash script checks for wireless internet connection and, if it is failing, tries to fix it.   

## Source

- Github source code:
https://github.com/ltpitt/bash-network-repair-automation

## Prerequisites

- Download and install requirements:  
`sudo apt-get install ifupdown fping -y`

## How to use

- Clone (or download) this repo locally:  
`git clone https://github.com/ltpitt/bash-network-repair-automation.git`
- Edit your root user's crontab:  
`sudo crontab -e`
- This line will execute the check every minute. Please customize the script path according to the folder where you cloned the repo:  
`* * * * * /yourpath/network_check.sh`
- If you also want to reboot in case wifi is not working after the fix uncomment the required lines in the code (you'll find a detailed explanation in the script comments):  
`nano network_check.sh`  
- If you want to perform automatic repair fsck in case of reboot (this is the last possible recovery action) remember to uncomment *fsck autorepair* editing rcS with the following command:  
`sudo nano /etc/default/rcS`
