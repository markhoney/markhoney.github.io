---
layout: blog-post
title: Availability of Internet Addresses
author: "Mark Honeychurch"
---

There are various addressing schemes on the internet - IPv4 and the new, still not very well adopted IPv6, MAC addresses, etc. I wonder how the number of each of these fares when stacked up against the world's population of ~7 billion people.

## IPv4 Addresses

An IPv4 address consists of 4 numbers, each between 0 and 256, separated by dots (e.g. 52.11.108.247). The theoretical maximum number of addresses is therefore 256 to the 4th power:

> 256⁴ = 256 x 256 x 256 x 256 = 4,294,967,296

If we divide this by our 7 billion people, we get:

> 4,294,967,296 / 7,000,000,000 = 0.61

This is 0.61 IP addresses per person, or an IP address per 0.61 / 1 = 1.63 people.

Eek, that doesn't seem to be enough! Remember that every home has a public IP, and each internet connected mobile device (mobile phones, etc) also has a public IP.

## IPv6 Addresses

IPv6 was created to help alleviate the issue of a lack of IPv4 addresses. An IPv6 address consists of 6 groups of two hexadecimal (0-9 or a-f) digits, separated by colons (e.g. 16:a2:aa:73:60:4b). The theoretical maximum number of addresses is therefore 16 to the 16th power:

> 16¹⁶ = 16 x 16 x 16 x 16 x 16 x 16 x 16 x 16 x 16 x 16 x 16 x 16 x 16 x 16 x 16 x 16 = 18,446,744,073,709,600,000

If we divide this by our 7 billion people, we get:

> 18,446,744,073,709,600,000 / 7,000,000,000 = 2,635,249,153

This is around 2.6 billion addresses per person - much better! It's interesting that IPv5 doesn't really seem to have taken off as an alternative to IPv4 as of yet - a lot of infrastructure supports IPv6, but wherever public IPv6 addresses are given out it's alongside an IPv4 address.

## MAC Addresses

MAC addresses are used for both Ethernet and Bluetooth, and are unique IDs allotted to all network communication devices (e.g. network cards, wireless devices), and consist of 6 pairs of hexadecimal characters, separated by colons (e.g. 05:AB:F5:20:94:9C). The theoretical maximum number of addresses is therefore 16 to the 12th power:

> 16¹² = 16 x 16 x 16 x 16 x 16 x 16 x 16 x 16 x 16 x 16 x 16 x 16 = 281,474,976,710,656

If we divide this by our 7 billion people, we get:

> 281,474,976,710,656 / 7,000,000,000 = 40,211

This is about 40 thousand addresses per person - which seems acceptable.
