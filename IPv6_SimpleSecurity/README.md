# Purpose  
Take notes for Recommended Simple Security Capabilities in Customer Premises Equipment (CPE) for Providing Residential IPv6 Internet Service   

# Table of Contents  

# 3.  Detailed Recommendations
## 3.1.  Stateless Filters  
``` 
   REC-1: Packets bearing multicast source addresses in their outer IPv6 headers MUST NOT be forwarded or transmitted on any interface.

   REC-2: Packets bearing multicast destination addresses in their outer IPv6 headers of equal or narrower scope (see "IPv6 Scoped Address Architecture" [RFC4007]) than the configured scope boundary level of the gateway MUST NOT be forwarded in any direction.  The DEFAULT scope boundary level SHOULD be organization-local scope, and it SHOULD be configurable by the network administrator.

   REC-3: Packets bearing source and/or destination addresses forbidden to appear in the outer headers of packets transmitted over the public Internet MUST NOT be forwarded.  In particular, site-local addresses are deprecated by [RFC3879], and [RFC5156] explicitly forbids the use of address blocks of types IPv4-Mapped Addresses, IPv4-Compatible
   Addresses, Documentation Prefix, and Overlay Routable Cryptographic Hash IDentifiers (ORCHID).

   REC-4: Packets bearing deprecated extension headers prior to their
   first upper-layer-protocol header SHOULD NOT be forwarded or
   transmitted on any interface.  In particular, all packets with
   routing extension header type 0 [RFC2460] preceding the first upper-
   layer-protocol header MUST NOT be forwarded.  See [RFC5095] for
   additional background.

   REC-5: Outbound packets MUST NOT be forwarded if the source address in their outer IPv6 header does not have a unicast prefix configured for use by globally reachable nodes on the interior network.

   REC-6: Inbound packets MUST NOT be forwarded if the source address in their outer IPv6 header has a global unicast prefix assigned for use by globally reachable nodes on the interior network.

   REC-7: By DEFAULT, packets with unique local source and/or destination addresses [RFC4193] SHOULD NOT be forwarded to or from
   the exterior network.

   REC-8: By DEFAULT, inbound DNS queries received on exterior interfaces MUST NOT be processed by any integrated DNS resolving
   server.

   REC-9: Inbound DHCPv6 discovery packets [RFC3315] received on exterior interfaces MUST NOT be processed by any integrated DHCPv6
   server or relay agent.
``` 

# Troubleshooting


# Reference
* [RFC6092 - IPv6 Simple Security 10 septembre 2013](http://computer-outlines.over-blog.com/article-ipv6-security-7-rfc6092-and-rfc4890-with-full-details-120085093.html)  
![alt tag](http://a52.idata.over-blog.com/500x309/2/45/56/50/SEC/S7/S7b.gif)  

* []()  
* []()  


* []()  
![alt tag]()  

# h1 size

## h2 size

### h3 size

#### h4 size

##### h5 size

*strong*strong  
**strong**strong  

> quote  
> quote

- [ ] checklist1
- [x] checklist2

* 1
* 2
* 3

- 1
- 2
- 3
