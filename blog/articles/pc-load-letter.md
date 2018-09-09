---
layout: blog-post
title: "PC Load Letter"
author: "Mark Honeychurch"
date: 2008-04-01
---

Whilst partaking in my daily browsing session of [digg](http://digg.com/), I found a link to an article on Lifehacker of [Top 10 Harmless Geek Pranks](http://lifehacker.com/373817/top-10-harmless-geek-pranks) (presumably for April Fool's). Number 2 in the list is a link to a [perl script](http://kovaya.com/miscellany/2007/10/insert-coin.html) which allows you to change the "Ready" prompt on HP printers using HPPJL (HP Printer Job Language).

I remember having seen something about this before (probably on digg!), but at the time my house wasn't networked, and instead just had a series of rectangular holes in one or more wall of each room. Well, now the house (or at least the study/spare room) has been wired up and the printer is permanently on the network, so I figured I'd give this a go. Now I love perl as much as the next person, but I was sure that I'd seen a windows version of this little widget - and as my work laptop is currently just running Windows XP (pending the release of [Ubuntu](http://www.ubuntu.com/) Hardy Heron in about 3 weeks' time), I figured that I'd have a quick hunt around for it.

Well, wouldn't you know - I linked from a google search to a [boingboing article](http://www.boingboing.net/2007/10/17/howto-change-the-pri.html) written by Cory Doctorow (and while you're at it, if you haven't read any of Cory's books, grab a copy of them from [his site](http://craphound.com/index.php?cat=5). His books are normally released freely under a Creative Commons license, and I especially recommend both "[Down and Out in the Magic Kingdom](http://craphound.com/down/)" and one of his short stories, "[0wnz0red](http://dir.salon.com/story/tech/feature/2002/08/28/0wnz0red/index.html)"), and in the comments there's a link to an [article on codebetter.com](http://codebetter.com/blogs/brendan.tompkins/archive/2004/07/23/20170.aspx). This article has a [C# command line program for Windows](http://www.codebetter.com/bsblog/HPHack.zip), which does exactly what we want. So, let's run it and see how we're _supposed_ to use it:

```console
Microsoft Windows [Version 6.0.6000]
Copyright (c) 2006 Microsoft Corporation.  All rights reserved.

C:\Users\mark>HPHack
HP Display Hack: hphack printername "message"

C:\Users\mark>
```

So, we can see that we just need to run HPHack with the name of the printer (in my case mark4100, a very inventive name for my HP Laserjet 4100!) and our message. Combining a lack of originality with a love of [Office Space](http://en.wikipedia.org/wiki/Office_space), I stole the idea in the codebetter article and decided to change the message on my printer to "PC Load Letter". To do this, we run the following:

```console
Microsoft Windows [Version 6.0.6000]
Copyright (c) 2006 Microsoft Corporation.  All rights reserved.

C:\Users\mark>HPHack mark4100 "PC Load Letter"


HP Display Hack
Host: mark4100
Message: PC Load Letter

Host is 172.22.2.180:9100
Finished


C:\Users\mark>
```

Of course, if you don't have DNS setup in your home (and let's face it, only geeks will be bothered with this sort of thing) you can just use the IP address of your printer instead:

```console
Microsoft Windows [Version 6.0.6000]
Copyright (c) 2006 Microsoft Corporation.  All rights reserved.

C:\Users\mark>HPHack 172.22.2.180 "PC Load Letter"


HP Display Hack
Host: 172.22.2.180
Message: PC Load Letter

Host is 172.22.2.180:9100
Finished


C:\Users\mark>
```
