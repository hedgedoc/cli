# Shrink a partition on an iso

https://askubuntu.com/questions/1174487/re-size-the-img-for-smaller-sd-card-how-to-shrink-a-bootable-sd-card-image




This article gives a solution that solves my problem (*). It is quite similar to the other one, but it better explains how to calculate and which meaning have the numbers and the partitions.

The key information was the use of the command truncate. Following the full solution in order to not lose the answer.

A preliminary step consists in cloning the SD card in your PC:

    use lsblk to see which devices are available and if their partitions are mounted

    unmount all partitions of the device you want to copy on your pc. For example:

     umount /dev/sdc1
     umount /dev/sdc2

    create a copy of the whole sd card with all the partitions unmounted

     dd if=/dev/sdc of=/path/to/file/myimage.img

Shrinking images on Linux

Context of the problem:

Having a myimage.img bigger then the hardware support (if it is smaller there should be no problem; however, using the same strategy, you can better fit the image in the hardware support).

The secret is to use standard Linux tools and instruments: GParted, fdisk and truncate.

Requirements:

    A Linux PC
    The .img you want to shrink (myimage.img in this example)

Creating loopback device:

GParted is an application typically used to manage partition tables and filesystems. In order to shrink the image, GParted is going to be used along the first part of the answer.

    GParted operates on devices, not simple files like images. This is why we first need to create a device for the image. We do this using the loopback-functionality of Linux.

Let's enable enable the loopback:

sudo modprobe loop

Let's request a new (free) loopback device:

sudo losetup -f

The command returns the path to a free loopback device:

/dev/loop0

Let's create a device of the image:

sudo losetup /dev/loop0 myimage.img

The device /dev/loop0 represents myimage.img. We want to access the partitions that are on the image, so we need to ask the kernel to load those too:

sudo partprobe /dev/loop0

This should give us the device /dev/loop0p1, which represents the first partition in myimage.img. We do not need this device directly, but GParted requires it.

Resize partition using GParted:

Let's load the new device using GParted:

sudo gparted /dev/loop0

When the GParted application opens, it should appear a window similar to the following:

![](https://hd.newspring.org/uploads/80e81a2c-58c2-4586-b94a-1a132dd24a82.png)


Now notice a few things:

    There is one partition.
    The partition allocates the entire disk/device/image.
    The partition is filled partly.

We want to resize this partition so that is fits its content, but not more than that.

Select the partition and click Resize/Move. A window similar to the following will pop up:

![](https://hd.newspring.org/uploads/b9626d69-0fba-4ebc-aa5f-b5898abfa3d9.png)

Drag the right bar to the left as much as possible.

Note that sometimes GParted will need a few MB extra to place some filesystem-related data. You can press the up-arrow at the New size-box a few times to do so. For example, I pressed it 10 times (=10MiB) for FAT32 to work. For NTFS you might not need to at all.

Finally press Resize/Move. You will return to the GParted window. This time it will look similar to the following:

![](https://hd.newspring.org/uploads/30135153-d014-4e46-aac2-c7947ac158cb.png)



Notice that there is a part of the disk unallocated. This part of the disk will not be used by the partition, so we can shave this part off of the image later. GParted is a tool for disks, so it doesn't shrink images, only partitions, we have to do the shrinking of the image ourselves.

Press Apply in GParted. It will now move files and finally shrink the partition, so it can take a minute or two, but most of the time it finishes quickly. Afterwards close GParted.

Now we don't need the loopback-device anymore, so unload it:

sudo losetup -d /dev/loop0

Shaving the image:

Now that we have all the important data at the beginning of the image it is time to shave off that unallocated part. We will first need to know where our partition ends and where the unallocated part begins. We do this using fdisk:

fdisk -l myimage.img

Here we will see an output similar to the following:

Disk myimage.img: 6144 MB, 6144000000 bytes, 12000000 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x000ea37d

      Device Boot      Start         End      Blocks   Id  System
myimage.img1            2048     9181183     4589568    b  W95 FAT32

Note two things in the output:

    The partition ends on block 9181183 (shown under End)
    The block-size is 512 bytes (shown as sectors of 1 * 512)

We will use these numbers in the rest of the example. The block-size (512) is often the same, but the ending block (9181183) will differ for you. The numbers mean that the partition ends on byte 9181183512 of the file. After that byte comes the unallocated-part. Only the first 9181183512 bytes will be useful for our image.

Next we shrink the image-file to a size that can just contain the partition. For this we will use the truncate command (thanks uggla!). With the truncate command need to supply the size of the file in bytes. The last block was 9181183 and block-numbers start at 0. That means we need (9181183+1)*512 bytes. This is important, else the partition will not fit the image. So now we use truncate with the calculations:

truncate --size=$[(9181183+1)*512] myimage.img

(*) it seems that the original post by FrozenCow has been moved here.
