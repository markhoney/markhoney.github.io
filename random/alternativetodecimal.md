---
layout: blog-post
title: Alternative to our Decimal System
author: "Mark Honeychurch"
---

Our decimal system has its failings - it's not easy to do maths with. Any number that is a power of two would be a better base than base 10.

The smaller the base, the more cumbersome it is to write. For example, with base two (binary) numbers become very long very quickly. If we compare a 5 digit number in decimal and binary, we can see the issue:

* Decimal: 89,793
* Binary:  10101111011000001

If we go above our current decimal system, though, we start running into problems. For one, we won't have enough fingers to count on. Secondly, we're going to have to invent new digits, as 0-9 won't be sufficient. Hexadecimal (base 16) numbers use the letters a-f, but this might get confusing given that they're already used in our alphabet.

## Base 8

To me, it seems that base 8 (octal) is a good option. Counting on fingers becomes easy, because we can just ignore our thumbs. We would lose the digits 8 and 9, which would be odd.

Our decimal above - 89,793 - in octal would be:

* 257,301

The length difference will become bigger for larger numbers, but the divergence won't be too bad:

* Decimal: 4,159,265,358,979 (13 digits)
* Octal:   74,414,742,142,203 (14 digits)
* Binary:  111100100001100111100010001100010010000011 (42 digits)
