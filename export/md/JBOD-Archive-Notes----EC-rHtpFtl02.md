# JBOD Archive Notes -- EC
Created by Emily Cyphers
## Overview
The JBOD archives are a collection of discs that hold data that was on 
file server NSC1. Files are selected to be moved to the archive. 
Those files are copied 3 times to 3 separate hard drives. 
One copy is placed into a server so the files can be shared on the 
network.  The other 2 copies are stored in waterproof boxes in 2 
separate buildings. 

## Here's the steps
* Prepare the drives
    * Materials needed
        * 3 hard drives the same size
        * apple computer
        * hard drive dock
    * Plug dock into computer and into wall power
    * Place one of the hard drives into the dock
    * Turn the dock power switch to ON
    * Wait several minutes till alert appears on the screen telling you to intialize the drive
    * Erase drive?  Yes
    * What format?  Select EXFAT
    * Name drive Archive_

* Install one of the drives in the windows server
    * Rename the drive to the next archive that needs to be built
        * (EG Archive_21)
    * Run the application RCGUI ![](https://hd.newspring.org/uploads/3fe67bb4-d9f8-405f-8a4e-ccfda46e9de2.png)

        * Click **{Source}** ![](https://hd.newspring.org/uploads/3479caae-0880-4f56-a18e-145a29fdcb45.png)

            * Choose folder to archive
        * Click **{Destination}** ![](https://hd.newspring.org/uploads/bd43a6e8-0ec7-4dc8-8092-833944ed3344.png)

            * Select the archive drive
            * Right click and create new folder
            * Ctrl+V to paste the name of the source folder to new folder
            * Highlight that folder and click **{Select Folder}** ![](https://hd.newspring.org/uploads/8be74b11-7d42-4257-b0d2-726c8c274f5a.png)

            * Click  **{Start Robocopy}** ![](https://hd.newspring.org/uploads/3dff2517-6bbb-4adc-ba60-bfd087234eba.png)

            * Wait till the files copy.  This may take several days.

    * Repeat process until the drive is full

* Shut down server and remove drive.
* Insert drive into the top bay of the drive duplicator 


![](https://hd.newspring.org/uploads/9405e15c-1587-428e-91ef-d030e4066cea.png)

* Insert the other 2 drives into the destination slots
* Press the copy button to duplicate the drives.
* Wait a day for process to complete
* Apply premade drive labels for the correct archive
* Verify the data
    * Reinstall the drives into drive bay
    ![](https://hd.newspring.org/uploads/8bc39a6a-3c7d-4b0d-81d6-e5182f9c1902.png)
    * For each drive highlight all folders that have been copied 
    * right click
    * select properties
    ![](https://hd.newspring.org/uploads/b81aae49-dd4f-429b-802f-a51ca5232209.png)

    * Verify the size / Number of folders and file count is the same!
    ![](https://hd.newspring.org/uploads/b90805e2-233e-4a6a-86c6-c343fbf939b2.png)

* Eject drives     
* Place the drives in their appropriate case
* Take the drive that goes into the server and take next steps

## Adding a drive to the JBOD Archive


![](https://hd.newspring.org/uploads/e53da93d-6445-4f01-bc9a-e7f44bb2f6e7.png)


Navigate to "nsc-jbod.nscsite.org:9090/45drives-disks" (Top Green arrow)
And log in as root
The passwords are found in bitwarden

Find the disk we just added by going to the 45Drives Disks tab (Light blue arrow)
Find device path (blue highlighted text) click on the disk you just added (red arrow)

In the terminal run the command 
```
ssh root@nsc-jbod.nscsite.org

cd /mnt/JBOD/


# To make sure that the path does not already exist to the Archive you want to create

ls  

# This makes the Folder that we will later share  Replace XX with Archive Number
mkdir Archive_XX 

# Now lets check to see what the UUID of the Disk is
cd /dev/disk/by-uuid/


# Run the ll command to tell you the relationship between the UUID and the Device Path
# The grep command filters the results to the one you found in the 45Drives Disks Module 
# Ours happens to be sdai, but yours will probably be different.

ll | grep sdai

# My results are below, you should copy
#     the 6232-340C number from this text string
# If you get more than one result you will most 
#     likely want the Device Path that ends with the number 2
# lrwxrwxrwx  1 root root  11 Jan 31 21:19 6232-340C -> ../../sdai2
# lrwxrwxrwx  1 root root  11 Jan 31 21:19 67E3-17ED -> ../../sdai1


```
![](https://hd.newspring.org/uploads/d7666110-bc80-4b61-bb14-b7e50aec2d16.png)

```

#  Now it is time to edit the /etc/fstab
#  You are logged in as root, please be careful 
#  Make a backup copy if you are not sure.  
#     It will be a gift to future you
#  And get help if you need it, Breaking this is a bad day!!!
#  This would be a great time to double check your work.  :)

vim /etc/fstab


# It might be best to copy this line and modify it.
/dev/disk/by-uuid/UUUU-UUUU /mnt/JBOD/Archive_XX    exfat   rw  0 0

# Swap XX for your Archive Number
# Swap UUUU-UUUU for your UUID


```
### See Example:

![](https://hd.newspring.org/uploads/5d0903e1-9069-43d5-922f-cab4b3dc5cdb.png)

```
/dev/disk/by-uuid/6232-340C /mnt/JBOD/Archive_31    exfat   rw  0 0
```

```
# Then run the command mount -a

mount -a

#  do a list of the files in your mount folder

ls /mnt/JBOD/Archive_XX

#  If all the files appear there then run MakeData and the path

MakeData /mnt/JBOD/Archive_XX

# change fstab back to read only


vim /etc/fstab
```

```
# Change
/dev/disk/by-uuid/6232-340C     /mnt/JBOD/Archive_31    exfat   rw      0 0
# To

/dev/disk/by-uuid/6232-340C     /mnt/JBOD/Archive_31    exfat   ro      0 0

#Save and Exit

# unmount and remount

umount /mnt/JBOD/Archive_XX
mount -a


```
Go to JBOD.NSCsite.org and verify that new data is in the archive

















