---
layout: blog-post
title: "NexentaStor HTTP Transport"
author: "Mark Honeychurch"
date: 2008-08-20
---

I'm currently preparing to build my new NAS (I'm waiting on a SATA motherboard to arrive) and upgrade the old NAS from [Gentoo Linux](http://www.gentoo.org/) to [NexentaStor](http://www.nexenta.com/corp/). The reason I'm changing is primarily so that I can use ZFS, which NexentaStor utilises (as it's a Solaris-based appliance). This is similar to NetApp's WAFL filesystem (and is currently the reason for a spate of [lawsuits](http://www.sun.com/lawsuit/zfs/) between Sun and NetApp), and so should offer decent performance benefits. Nexenta offer a free [Developer Edition](http://www.nexenta.com/corp/index.php?option=com_content&amp;task=view&amp;id=18&amp;Itemid=75) which allows up to 1TB of data to be saved on the appliance. When you go over 1TB, the data's still accessible but all management functions are locked down.

During the install of NexentaStor on my VMware box (and I'm using the newly free [VMware ESXi](http://www.vmware.com/products/esxi/) for this), I chose the default HTTPS front-end transport option. Instructions showed up explaining how to change this from the command line to HTTP, but figuring I could find this out later I carried on with the install.

Well, it turns out that the HTTPS front-end is pretty slow, so I decided to switch to HTTP. Unfortunately, I couldn't find instructions on how to do this within the front-end, manual or even with google. So I rebuilt the box and decided to put the information up online in case anyone else is having the same problem as me. The command to switch between HTTP and HTTPS transports for NextentaStor is:

``` bash
setup appliance init
```
