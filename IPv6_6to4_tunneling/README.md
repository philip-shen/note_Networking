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

3.1. Link-Local Address and NUD
==============================
The link-local address of a 6to4 pseudo-interface performing 6to4 encapsulation would, if needed, be formed as described in Section 3.7
 of [MECH].

The configured tunnels are IPv6 interfaces (over the IPv4 "link layer") and thus MUST have link-local addresses.  The link-local addresses are used by, e.g., routing protocols operating over the tunnels.
If an IPv4 address is used for forming the IPv6 link-local address, the interface identifier is the IPv4 address, prepended by zeros. Note that the "Universal/Local" bit is zero, indicating that the interface identifier is not globally unique.  The link-local address is formed by appending the interface identifier to the prefix FE80::/64.
```
      +-------+-------+-------+-------+-------+-------+------+------+
      |  FE      80      00      00      00      00      00     00  |
      +-------+-------+-------+-------+-------+-------+------+------+
      |  00      00      00      00   |        IPv4 Address         |
      +-------+-------+-------+-------+-------+-------+------+------+
```

Neighbor Unreachability Detection (NUD) is handled as described in Section 3.8 of [MECH] 

Configured tunnel implementations MUST at least accept and respond to the probe packets used by Neighbor Unreachability Detection (NUD)
 [RFC2461](https://tools.ietf.org/html/rfc2461).  The implementations SHOULD also send NUD probe packets to detect when the configured tunnel fails at which point the implementation can use an alternate path to reach the destination.

For the purposes of Neighbor Discovery, the configured tunnels specified in this document are assumed to NOT have a link-layer address, even though the link-layer (IPv4) does have an address.
This means that:
```
   -  the sender of Neighbor Discovery packets SHOULD NOT include Source
      Link Layer Address options or Target Link Layer Address options on
      the tunnel link.

   -  the receiver MUST, while otherwise processing the Neighbor
      Discovery packet, silently ignore the content of any Source Link
      Layer Address options or Target Link Layer Address options
      received on the tunnel link.
```

4. Maximum Transmission Unit 
==============================
MTU size considerations are as described for tunnels in [MECH].

5. Unicast scenarios, scaling, and transition to normal prefixes
==============================
5.1 Simple scenario - all sites work the same
==============================
```
                            _______________________________
                           |                               |
                           |  Wide Area IPv4 Network       |
                           |_______________________________|
                                  /                    \
                        192.1.2.3/         9.254.253.252\
 _______________________________/_   ____________________\____________
|                              /  | |                     \           |
|IPv4 Site A          ##########  | |IPv4 Site B          ##########  |
| ____________________# 6to4   #_ | | ____________________# 6to4   #_ |
||                    # router # || ||                    # router # ||
||IPv6 Site A         ########## || ||IPv6 Site B         ########## ||
||2002:c001:0203::/48            || ||2002:09fe:fdfc::/48            ||
||_______________________________|| ||_______________________________||
|                                 | |                                 |
|_________________________________| |_________________________________|
```
In the case of the global Internet, there is no requirement that the sites all connect to the same Internet service provider.  The only requirement is that any of the sites is able to send IPv4 packets with protocol type 41 to any of the others.  By definition, each site has an IPv6 prefix in the format defined in Section 2.  It will therefore create DNS records for these addresses.
For example, site A which owns IPv4 address 192.1.2.3 will create DNS records with the IPv6 prefix {FP=001,TLA=0x0002,NLA=192.1.2.3}/48 (i.e., 2002:c001:0203::/48).  Site B which owns address 9.254.253.252 will create DNS records with the IPv6 prefix {FP=001,TLA=0x0002,NLA=9.254.253.252}/48 (i.e., 2002:09fe:fdfc::/48).

5.2 Mixed scenario with relay to native IPv6
==============================
```
            ____________________________         ______________________
           |                            |       |                      |
           |  Wide Area IPv4 Network    |       |   Native IPv6        |
           |                            |       |   Wide Area Network  |
           |____________________________|       |______________________|
                /                    \             //
      192.1.2.3/         9.254.253.252\           // 2001:0600::/48
  ____________/_   ____________________\_________//_
             /  | |                     \       //  |
    ##########  | |IPv4 Site B          ##########  |
  __# 6to4   #_ | | ____________________# 6to4   #_ |
    # router # || ||                    # router # ||
    ########## || ||IPv6 Site B         ########## ||
               || ||2002:09fe:fdfc::/48            ||
  __Site A_____|| ||2001:0600::/48_________________||
    as before   | |                                 |
  ______________| |_________________________________|

```
There must be at least one router acting as a relay between the 6to4 domain and a given native IPv6 domain.  There is nothing special
 about it; it is simply a normal router which happens to have at least one logical 6to4 pseudo-interface and at least one other IPv6 interface.  Since it is a 6to4 router, it implements the additional sending and decapsulation rules defined in Section 5.3.

5.3 Sending and decapsulation rules
==============================
The only change to standard IPv6 forwarding is that every 6to4 router (and only 6to4 routers) MUST implement the following additional
 sending and decapsulation rules.

In the sending rule, "next hop" refers to the next IPv6 node that the packet will be sent to, which is not necessarily the final destination, but rather the next IPv6 neighbor indicated by normal IPv6 routing mechanisms.
If the final destination is a 6to4 address, it will be considered as the next hop for the purpose of this rule.
If the final destination is not a 6to4 address, and is not local, the next hop indicated by routing will be the 6to4 address of a relay router.

ADDITIONAL SENDING RULE for 6to4 routers
```
        if the next hop IPv6 address for an IPv6 packet
           does match the prefix 2002::/16, and
           does not match any prefix of the local site
               then
               apply any security checks (see Section 8);
               encapsulate the packet in IPv4 as in Section 3,
               with IPv4 destination address = the NLA value V4ADDR
               extracted from the next hop IPv6 address;
               queue the packet for IPv4 forwarding.               
```
A simple decapsulation rule for incoming IPv4 packets with protocol type 41 MUST be implemented:

ADDITIONAL DECAPSULATION RULE for 6to4 routers
```
          apply any security checks (see Section 8);
          remove the IPv4 header;
          submit the packet to local IPv6 routing.

```

Reference 
==============================
* [Connection of IPv6 Domains via IPv4 Clouds RFC 3056](https://tools.ietf.org/html/rfc3056)
* [[MECH] Basic Transition Mechanisms for IPv6 Hosts and Routers RFC 4213, October 2005.](https://tools.ietf.org/html/rfc4213)
* [[6OVER4] "Transmission of IPv6 over IPv4 Domains without Explicit Tunnels", RFC 2529, March 1999](https://tools.ietf.org/html/rfc2529)
* [[AARCH] "IP Version 6 Addressing Architecture", RFC 2373, July 1998.](https://tools.ietf.org/html/rfc2373)
* [[AGGR] "An IPv6 Aggregatable Global Unicast Address Format", RFC 2374, July 1998.](https://tools.ietf.org/html/rfc2374)
* [[SELECT] "Default Address Selection for IPv6", RFC6724, September 2012.](https://tools.ietf.org/html/rfc6724)
* [[MECH] "Basic Transition Mechanisms for IPv6 Hosts and Routers", RFC 4213, October 2005.](https://tools.ietf.org/html/rfc4213)

* []()
![alt tag]()

6.1. IPv6 Tunneling
https://www.tldp.org/HOWTO/Adv-Routing-HOWTO/lartc.tunnel-ipv6.addressing.html

IPv6 Tunnel Broker?使??IPv6??????環境?構築??
https://qiita.com/kazuhidet/items/b295d4932f478c488646#ipv6%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AA%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF%E3%82%92%E6%A7%8B%E7%AF%89%E3%81%97%E3%81%9F%E3%81%84
