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

6to4 prefix:

6to4 address:

Native IPv6 address:

6to4 router (or 6to4 border router):

6to4 host:

6to4 site:

Relay router:

6to4 exterior routing domain:

Reference 
==============================
* [Connection of IPv6 Domains via IPv4 Clouds RFC 3056](https://tools.ietf.org/html/rfc3056)
* [Basic Transition Mechanisms for IPv6 Hosts and Routers RFC 4213](https://tools.ietf.org/html/rfc4213)
* [[6OVER4] "Transmission of IPv6 over IPv4 Domains without Explicit Tunnels", RFC 2529, March 1999](https://tools.ietf.org/html/rfc2529)


* []()
![alt tag]()

6.1. IPv6 Tunneling
https://www.tldp.org/HOWTO/Adv-Routing-HOWTO/lartc.tunnel-ipv6.addressing.html

IPv6 Tunnel Broker?使??IPv6??????環境?構築??
https://qiita.com/kazuhidet/items/b295d4932f478c488646#ipv6%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AA%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF%E3%82%92%E6%A7%8B%E7%AF%89%E3%81%97%E3%81%9F%E3%81%84
