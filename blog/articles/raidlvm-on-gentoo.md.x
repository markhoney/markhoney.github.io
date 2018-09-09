---
layout: blog-post
title: "RAID/LVM on Gentoo"
author: "Mark Honeychurch"
date: 2008-03-16
---

Here are some notes I've made whilst building my NAS server. The server is based on Gentoo Linux and uses software RAID5, LVM and the [XFS file system](http://oss.sgi.com/projects/xfs/) from Silicon Graphics.


First, install the RAID tools (mdadm), LVM (lvm2) and Samba (samba).

``` bash
login as: root
Using keyboard-interactive authentication.
Password:
Last login: Sun Apr  1 23:38:46 2007 from 192.168.1.1
server ~ #emerge -va mdadm lvm2 samba_
```

Next we need to remove all existing partitions on each of the disks we want to use (in my case 5 x 320Gb PATA)


``` bash
server ~ #fdisk /dev/hda_
```

The keystrokes we want to use are:

<dl>
<dt>d</dt><dd>Delete partition, this should remove the partition if there was previously one one there. If there's more than one partition, specify the partition number and repeat for each partition on the drive</dd>
<dt>n</dt><dd>New partition</dd>
<dt>p</dt><dd>Primary</dd>
<dt>1</dt><dd>Partition number 1</dd>
<dt>Enter</dt><dd>Start at the first cylinder</dd>
<dt>Enter</dt><dd>End at the last cylinder (use the whole drive)</dd>
<dt>t</dt><dd>Change partition type</dd>
<dt>fd</dt><dd>Linux RAID auto</dd>
<dt>p</dt><dd>Print the partition table (check that all looks okay)</dd>
<dt>w</dt><dd>Write the new partition table and exit</dd></dl>

You can also use 'p' within fdisk to print (to screen) the partition table, 'm' to show a list of options and 'l' to show a list of partition types. Repeat this step for each drive.


Next we zero the superblock of all our drives, which wipes all info from any previous RAID installs we've done on the drives.


<div class="window putty p">


<pre>
server ~ #mdadm --zero-superblock /dev/hda1_</pre>
</div>

Repeat the above step for each drive we're using



Now we create the RAID array. In my case, I created the array as a 5 disk array with one disk missing (this disk had data on it at the time). This creates a degraded RAID5 array, and the last disk can be added later.

<div class="window putty p">


<pre>
server ~ #mdadm --create --verbose /dev/md0 --level=5 --raid-devices=5 --chunk=512 /dev/hd[cegi]1 missing_</pre>
</div>
We can see in the line above that we're using verbose mode so that we can see what's going on, creating the device at /dev/md0, creating the array with RAID level 5, using 5 disks, setting a chunk size of 512Kb and using partitions hdc1, hde1, hdg1, hgi1 and 'missing', which denotes that one of our drives is not present (the one that still has data on it). Not the shorthand way that we can identify the drives using square brackets. Also note that our drives are only every other letter (c, e, g, i and eventually k). This is because I've limited the drives to one per IDE channel, to improve performance.

Now we can grab the details of our new RAID array and load them into a config file for mdadm to use in the future

<div class="window putty p">


<pre>
server ~ #mdadm --detail --scan &gt; /etc/mdadm.conf_</pre>
</div>

We can now edit this file to provide an email address to be mailed if one of the drives fails.


<div class="window putty p">


<pre>
server ~ #nano /etc/mdadm.conf_</pre>
</div>

The file should look like the following:

<pre>
DEVICE          /dev/hd[cegi]1
ARRAY           /dev/md0 level=raid5 num-devices=5 devices=/dev/hd[aceg]1 missing
MAILADDR        mark@honeychurch.org</pre>


DEVICE          /dev/hd[cegik]1
ARRAY           /dev/md0 level=raid5 num-devices=5 devices=/dev/hd[acegm]1
MAILADDR        mark@honeychurch.org




vgscan
vgchange -a y

pvcreate /dev/md0

pvdisplay



vgcreate -s 32M vg0 /dev/md0

vgdisplay vg0



vgdisplay vg0 | grep "Total PE"

lvcreate -l 38155 vg0 -n lv0

lvdisplay /dev/vg0/lv0



mkfs.xfs -d su=512k,sw=4 /dev/vg0/lv0

mount /dev/vg0/lv0 /raid


/dev/vg0/lv0 /raid xfs defaults 0 0






mdadm /dev/md0 -a /dev/hdm1

mdadm --detail /dev/md0







mknod /dev/md0 b 9 0

mdadm --assemble /dev/md0 /dev/hd[aceg]1
mdadm --assemble /dev/md0 /dev/hd[acegm]1

mdadm --assemble --scan /dev/hd[aceg]1
mdadm --assemble --scan /dev/hd[acegm]1


vgscan vg0
vgchange -a y vg0

mkdir /raid
mount /dev/vg0/lv0 /raid














umount /dev/vg0/lv0
lvremove /dev/vg0/lv0

vgchange -a n vg0
vgremove vg0


[Defragmenting an XFS Volume](http://bitubique.com/tutorials/defragment-xfs-file-system)

My next filer, which I'll purchase and build once the price of [1Tb drives](http://www.pricespy.co.nz/cat_3.html#g232) has stabilised, will have 4 x 1Tb
Western Digital Caviar SATA drives, possibly an [ST Lab A-224 4 channel SATA controller](http://ascent.co.nz/productspecification.aspx?ItemID=359940) (as there seem to be no cheap SATA 3Gb cards available at the moment), and will run on [Openfiler](http://www.openfiler.com/). Hopefully, Openfiler 2.3 will be out by then, although I'm not holding my breath!

