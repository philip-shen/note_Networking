# Abstract
The document defines a method for assigning an interim unique IPv6 address prefix to any site that currently has at least one globally unique IPv4 address, and specifies an encapsulation mechanism for transmitting IPv6 packets using such a prefix over the global IPv4 network.

The motivation for this method is to allow isolated IPv6 domains or hosts, attached to an IPv4 network which has no native IPv6 support,
to communicate with other such IPv6 domains or hosts with minimal manual configuration, before they can obtain natuve IPv6
connectivity.  It incidentally provides an interim globally unique IPv6 address prefix to any site with at least one globally unique
IPv4 address, even if combined with an IPv4 Network Address Translator (NAT).

1.Introduction
==============================
The document defines a method for assigning an interim unique IPv6 address prefix to any site that currently has at least one globally unique IPv4 address, and specifies an encapsulation mechanism for transmitting IPv6 packets using such a prefix over the global IPv4 network.

The basic mechanism described in the present document, which applies to sites rather than individual hosts, will scale indefinitely by limiting the number of sites served by a given relay router see [see Section 5.2](https://tools.ietf.org/html/rfc3056#section-5.2).  It will introduce no new entries in the IPv4 routing table, and exactly one new entry in the native IPv6 routing table [see Section 5.10](https://tools.ietf.org/html/rfc3056#section-5.10).

IPv6 sites or hosts connected using this method do not require IPv4-compatible IPv6 addresses [MECH](https://tools.ietf.org/html/rfc2893) or configured tunnels.  In this way IPv6 gains considerable independence of the underlying wide area network and can step over many hops of IPv4 subnets.
The abbreviated name of this mechanism is 6to4 (not to be confused with [6OVER4](https://tools.ietf.org/html/rfc2529)).  The 6to4 mechanism is typically implemented almost entirely in border routers, without specific host modifications except a suggested address selection default.  Only a modest amount of router configuration is required.

1.1. Terminology
==============================
The terminology of [IPV6](https://tools.ietf.org/html/rfc2460) applies to this document.

6to4 pseudo-interface:
``` 
6to4 encapsulation of IPv6 packets inside IPv4 packets occurs at a point that is logically equivalent to an IPv6 interface, with the link layer being the IPv4 unicast network.  This point is referred to as a pseudo-interface.  Some implementors may treat it exactly like any other interface and others may treat it like a tunnel end-point.
``` 

6to4 prefix:
an IPv6 prefix constructed according to the rule in [Section 2](https://tools.ietf.org/html/rfc3056#section-2) below.

6to4 address:
``` 
an IPv6 address constructed using a 6to4 prefix.
``` 

Native IPv6 address:
``` 
an IPv6 address constructed using another type of prefix than 6to4.
``` 

6to4 router (or 6to4 border router):
``` 
an IPv6 router supporting a 6to4 pseudo-interface.  It is normally the border router between an IPv6 site and a wide-area IPv4 network.
``` 

6to4 host:
``` 
an IPv6 host which happens to have at least one 6to4 address. In all other respects it is a standard IPv6 host.

Note: an IPv6 node may in some cases use a 6to4 address for a configured tunnel.  Such a node may function as an IPv6 host using a
6to4 address on its configured tunnel interface, and it may also serve as a IPv6 router for other hosts via a 6to4 pseudo-interface,
but these are distinct functions.
``` 

6to4 site:
``` 
a site running IPv6 internally using 6to4 addresses, therefore containing at least one 6to4 host and at least one 6to4 router.
``` 

Relay router:
``` 
a 6to4 router configured to support transit routing between 6to4 addresses and native IPv6 addresses.
``` 

6to4 exterior routing domain:
``` 
a routing domain interconnecting a set of 6to4 routers and relay routers.  It is distinct from an IPv6 site's interior routing domain, and distinct from all native IPv6 exterior routing domains.
``` 

2.IPv6 Prefix Allocation
==============================
The IANA has permanently assigned one 13-bit IPv6 Top Level Aggregator (TLA) identifier under the IPv6 Format Prefix 001 [AARCH, AGGR]  for the 6to4 scheme.Its numeric value is 0x0002, i.e., it is 2002::/16 when expressed as an IPv6 address prefix.

     | 3 |  13  |    32     |   16   |          64 bits               |
     +---+------+-----------+--------+--------------------------------+
     |FP | TLA  | V4ADDR    | SLA ID |         Interface ID           |
     |001|0x0002|           |        |                                |
     +---+------+-----------+--------+--------------------------------+
     
Thus, this prefix has exactly the same format as normal /48 prefixes assigned according to [AGGR].  It can be abbreviated as 2002:V4ADDR::/48.

2.1 Address Selection
==============================
To ensure the correct operation of 6to4 in complex topologies, source and destination address selection must be appropriately implemented.
If the source IPv6 host sending a packet has at least one 2002::address assigned to it, and if the set of IPv6 addresses returned by the DNS for the destination host contains at least one 2002::address, then the source host must make an appropriate choice of the source and destination addresses to be used.
The mechanisms for address selection in general are under study at the time of writing [SELECT](https://tools.ietf.org/html/rfc6724).

3. Encapsulation in IPv4
==============================
IPv6 packets are transmitted in IPv4 packets [RFC 791] with an IPv4 protocol type of 41, the same as has been assigned [MECH] for IPv6  packets that are tunneled inside of IPv4 frames.
``` 
      0                   1                   2                   3
      0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |Version|  IHL  |Type of Service|          Total Length         |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |         Identification        |Flags|      Fragment Offset    |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |  Time to Live | Protocol 41   |         Header Checksum       |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |                       Source Address                          |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |                    Destination Address                        |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |                    Options                    |    Padding    |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |            IPv6 header and payload ...              /
     +-------+-------+-------+-------+-------+------+------+
```      
     
Reference 
==============================
* [Connection of IPv6 Domains via IPv4 Clouds RFC 3056](https://tools.ietf.org/html/rfc3056)
* [Basic Transition Mechanisms for IPv6 Hosts and Routers RFC 4213](https://tools.ietf.org/html/rfc4213)
* [[6OVER4] "Transmission of IPv6 over IPv4 Domains without Explicit Tunnels", RFC 2529, March 1999](https://tools.ietf.org/html/rfc2529)
* [[AARCH] "IP Version 6 Addressing Architecture", RFC 2373, July 1998.](https://tools.ietf.org/html/rfc2373)
* [[AGGR] "An IPv6 Aggregatable Global Unicast Address Format", RFC 2374, July 1998.](https://tools.ietf.org/html/rfc2374)
* [[SELECT] "Default Address Selection for IPv6", RFC6724, September 2012](https://tools.ietf.org/html/rfc6724)
* [[MECH] "Basic Transition Mechanisms for IPv6 Hosts and Routers", RFC 4213, October 2005.](https://tools.ietf.org/html/rfc4213)

* []()
![alt tag]()

6.1. IPv6 Tunneling
https://www.tldp.org/HOWTO/Adv-Routing-HOWTO/lartc.tunnel-ipv6.addressing.html

IPv6 Tunnel Broker?使??IPv6??????環境?構築??
https://qiita.com/kazuhidet/items/b295d4932f478c488646#ipv6%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AA%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF%E3%82%92%E6%A7%8B%E7%AF%89%E3%81%97%E3%81%9F%E3%81%84
