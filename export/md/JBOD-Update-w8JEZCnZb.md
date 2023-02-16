# JBOD Update

###### tags: `45-Drives` `NSC-JBOD`

Log into root @ nsc-jbod
Install Disk and mount using /etc/fstab as read write
Run:
```
MakeData /mnt/JBOD/Archive_XX
```

---> This Takes a long time to complete don't worry just get a cup of coffee...

Then->

Run:
```
scp /tmp/Data.txt jbod@jbod:~/JBOD_Search/static/Data.txt
```

Verify by website: jbod.nscsite.org


All Done!!
