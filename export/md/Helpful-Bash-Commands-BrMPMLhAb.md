# Helpful Bash Commands

# Forgot the password on a raspberry pi

to reset your password:

Power down and pull the SD card out from your Pi and put it into your computer.
Open the file 'cmdline.txt' and add ``` init=/bin/sh ```to the end. This will cause the machine to boot to single user mode.
Put the SD card back in the Pi and boot.
When the prompt comes up, type 'su' to log in as root (no password needed).
Type "passwd pi" and then follow the prompts to enter a new password.
Shut the machine down, then pull the card again and put the cmdline.txt file back the way it was by removing the 'init=/bin/sh' bit.


## Interrogate Ram Informantion from CLI


```
sudo dmidecode --type 16 # Max Possible
sudo dmidecode --type 17 # What is installed
```


## Need to change the label on an EXFAT Partion
```
# First list the Partitions with the labels
lsblk -f | grep JBOD


# Then change the labes with exfatlabel utility
exfatlabel /dev/sdu2 "Archive_18"


## To find who has a file opened on a server List Open Files with the lsof command

```
lsof
```

### KidCheck hubs reporting

```
watch -n 15 "pghb | tee -a /tmp/hublog.txt"
```

pghb is in /usr/local/bin/

it is a shell script used for pinging the kidcheck hubs.


```

#!/usr/bin/bash
echo
date
echo


if  ping -w 1  -c1 10.10.13.88 >> /dev/null ; then echo -- 88 -- First Time Hub UP ; else echo  -- 88 -- First Time Hub  DOWN ; fi
if  ping -w 1  -c1 10.10.13.52 >> /dev/null ; then echo -- 52 -- First Time Hub WIFI UP ; else echo  -- 52 -- First Time Hub WIFI DOWN ; fi
if  ping -w 1  -c1 10.10.13.85 >> /dev/null ; then echo -- 85 -- Main Hub 1 UP ; else echo  -- 85 -- Main Hub 1  DOWN ; fi
if  ping -w 1  -c1 10.10.13.58 >> /dev/null ; then echo -- 58 -- Main Hub 2 UP ; else echo  -- 58 -- Main Hub 2  DOWN ; fi
if  ping -w 1  -c1 10.10.13.62 >> /dev/null ; then echo -- 62 -- Main Hub 2 WIFI UP ; else echo -- 62 -- Main Hub 2 WIFI  DOWN ; fi
if  ping -w 1  -c1 10.10.9.24 >> /dev/null ; then echo -- 24 -- The Wire Hub UP ; else echo  -- 24 -- The Wire Hub  DOWN ; fi
if  ping -w 1  -c1 10.10.13.56 >> /dev/null ; then echo -- 56 -- Volunteer Hub UP ; else echo  -- 56 -- Volunteer Hub  DOWN ; fi
if  ping -w 1  -c1 10.10.13.90 >> /dev/null ; then echo -- 90 -- Mobile Express Hub UP ; else echo  -- 90 -- Mobile Express Hub  DOWN ; fi
if  ping -w 1  -c1 10.10.13.87 >> /dev/null ; then echo -- 87 -- West Express Hub UP ; else echo  -- 87 -- West Express Hub  DOWN ; fi




