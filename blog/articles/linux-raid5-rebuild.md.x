---
layout: blog-post
title: "Linux RAID5 Rebuild"
author: "Mark Honeychurch"
date: 2008-08-24
---

My new NAS is currently rebuilding its RAID5 array, and I figured it'd be good to watch the progress of the rebuild. To this end, I hacked together a quick and dirty script to display the contents of /proc/mdstat at one second intervals. Just place the below code in a file called mdinfo.sh (nano mdinfo.sh and paste), make it executable (chmod +x mdinfo.sh) and run it (./mdinfo.sh). To quit, just press Control-C.
<a name='more'></a>

<code>
#!/bin/sh

i=1

while [ $i -eq 1 ]
do
  clear
  cat /proc/mdstat
  sleep 1
done</code>
To keep an eye on a file copy (I'll be copying 1.2Tb to my new NAS), you can just swap the command 'cat /proc/mdstat' for 'df' and/or 'df -h'. 'df' shows disk usage and 'df -h' shows disk usage in 'human readable' form. I use both, one after the other, so that I can see a) that the copy is running (as the 'human readable' format changes infrequently once the count is at 10GB or more, even over my gigabit network) and b) how long the copy has to go (as it's hard to work this out from looking at the disk space in 1k blocks). This script I called cpinfo.sh on my server:

<!--break-->
<code>
#!/bin/sh

i=1

while [ $i -eq 1 ]
do
  clear
  df
  echo
  df -h
  sleep 1
done</code>

