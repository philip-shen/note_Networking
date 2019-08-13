# Table of Content  
[1. Introduction](#1--introduction)  
[2. Terminology](#2--terminology)  
[2.1. General](#21--general)  
[2.2. Link Types](#22--link-types)  
[2.3. Addresses](#23--addresses)  
[Multicast address](#multicast-address)  
[3. Protocol Overview](#3--protocol-overview)  
[4. Message Formats](#4--message-formats)  
[4.1. Router Solicitation Message Format](#41--router-solicitation-message-format)  
[4.2. Router Advertisement Message Format](#42--router-advertisement-message-format)  
[4.3. Neighbor Solicitation Message Format](#43--neighbor-solicitation-message-format)  
[4.4. Neighbor Advertisement Message Format](#44--neighbor-advertisement-message-format)  
[4.5. Redirect Message Format](#45--redirect-message-format)  
[4.6. Option Formats](#46--option-formats)  
[4.6.1. Source/Target Link-layer Address](#461--sourcetarget-link-layer-address)  
[4.6.2. Prefix Information](#462--prefix-information)  
[4.6.3. Redirected Header](#463--redirected-header)  
[4.6.4. MTU](#464--mtu)  
[6. Router and Prefix Discovery](#6--router-and-prefix-discovery)  
[]()  
[]()  
[]()  
[]()  
[]()  
[]()  
[Reference](#reference)  

# 1.  Introduction
Nodes (hosts and routers) use Neighbor Discovery to determine the link-layer addresses for neighbors known to reside on attached links and to quickly purge cached values that become invalid.
Hosts also use Neighbor Discovery to find neighboring routers that are willing to forward packets on their behalf.
Finally, nodes use the protocol to actively keep track of which neighbors are reachable and which are not, and to detect changed link-layer addresses.

However, because ND uses link-layer multicast for some of its services, it is possible that on some link types (e.g., Non-Broadcast Multi-Access (NBMA) links), alternative protocols or mechanisms to implement those services will be specified (in the appropriate document covering the operation of IP over a particular link type).
The services described in this document that are not directly dependent on multicast, such as Redirects, Next-hop determination, Neighbor Unreachability Detection, etc., are expected to be provided as specified in this document.

# 2.  Terminology
# 2.1.  General
```
   IP          - Internet Protocol Version 6.

   ICMP        - Internet Control Message Protocol for the Internet Protocol Version 6.                 

   node        - a device that implements IP.

   router      - a node that forwards IP packets not explicitly addressed to itself.                 

   host        - any node that is not a router.

   upper layer - a protocol layer immediately above IP.  Examples are transport protocols such as TCP and UDP, control
                 protocols such as ICMP, routing protocols such as OSPF, and Internet-layer (or lower-layer) protocols being
                 "tunneled" over (i.e., encapsulated in) IP such as Internetwork Packet Exchange (IPX), AppleTalk, or IP
                 itself.

   link        - a communication facility or medium over which nodes can communicate at the link layer, i.e., the layer
                 immediately below IP.  Examples are Ethernets (simple or bridged), PPP links, X.25, Frame Relay, or ATM
                 networks as well as Internet-layer (or higher-layer) "tunnels", such as tunnels over IPv4 or IPv6 itself.
   
   interface   - a node's attachment to a link.

   neighbors   - nodes attached to the same link.

   address     - an IP-layer identifier for an interface or a set of interfaces.

   anycast address
               - an identifier for a set of interfaces (typically belonging to different nodes).  A packet sent to an
                 anycast address is delivered to one of the interfaces identified by that address (the "nearest" one,
                 according to the routing protocol's measure of distance).  See [ADDR-ARCH](https://tools.ietf.org/html/rfc4291).
```
[Anycast](https://en.wikipedia.org/wiki/Anycast)
Anycast is a network addressing and routing methodology in which a single destination address has multiple routing paths to two or more endpoint destinations. Routers will select the desired path on the basis of number of hops, distance, lowest cost, latency measurements or based on the least congested route. Anycast networks are widely used for content delivery network (CDN) products to bring their content closer to the end user. 

MultiCast
![alt tag](https://upload.wikimedia.org/wikipedia/commons/3/30/Multicast.svg)

AnyCast
![alt tag](https://upload.wikimedia.org/wikipedia/en/1/18/Anycast-BM.svg)
```
   prefix      - a bit string that consists of some number of initial bits of an address.                 

   link-layer address
               - a link-layer identifier for an interface.  Examples include IEEE 802 addresses for Ethernet links.

   on-link     - an address that is assigned to an interface on a specified link.  A node considers an address to be on-
                 link if:

   off-link    - the opposite of "on-link"; an address that is not
                 assigned to any interfaces on the specified link.

   longest prefix match
               - the process of determining which prefix (if any) in a set of prefixes covers a target address.  A target
                 address is covered by a prefix if all of the bits in the prefix match the left-most bits of the target
                 address.  When multiple prefixes cover an address, the longest prefix is the one that matches.
   
   reachability
               - whether or not the one-way "forward" path to a neighbor is functioning properly.  In particular, whether
                 packets sent to a neighbor are reaching the IP layer on the neighboring machine and are being processed
                 properly by the receiving IP layer.

   packet      - an IP header plus payload.

   link MTU    - the maximum transmission unit, i.e., maximum packet size in octets, that can be conveyed in one
                 transmission unit over a link.

   target      - an address about which address resolution information is sought, or an address that is the new first hop when
                 being redirected.

   proxy       - a node that responds to Neighbor Discovery query messages on behalf of another node.
                 
   ICMP destination unreachable indication
               - an error indication returned to the original sender of a packet that cannot be delivered for the reasons
                 outlined in [ICMPv6].

   random delay
               - when sending out messages, it is sometimes necessary to delay a transmission for a random amount of time in
                 order to prevent multiple nodes from transmitting at exactly the same time, or to prevent long-range
                 periodic transmissions from synchronizing with each other [SYNC].
                 
   random delay seed
               - if a pseudo-random number generator is used in calculating a random delay component, the generator
                 should be initialized with a unique seed prior to being used.
                 
```
# 2.2.  Link Types
Different link layers have different properties.  The ones of concern to Neighbor Discovery are:
```
   multicast capable
                  - a link that supports a native mechanism at the link layer for sending packets to all (i.e., broadcast)
                    or a subset of all neighbors.

   point-to-point - a link that connects exactly two interfaces.  A point-to-point link is assumed to have multicast
                    capability and a link-local address.

   non-broadcast multi-access (NBMA)
                  - a link to which more than two interfaces can attach, but that does not support a native form of multicast
                    or broadcast (e.g., X.25, ATM, frame relay, etc.).  Note that all link types (including NBMA) are
                    expected to provide multicast service for applications that need it (e.g., using multicast servers).
                    
   shared media   - a link that allows direct communication among a number of nodes, but attached nodes are configured
                    in such a way that they do not have complete prefix information for all on-link destinations.  That is,
                    at the IP level, nodes on the same link may not know that they are neighbors; by default, they
                    communicate through a router.
                    
   variable MTU   - a link that does not have a well-defined MTU (e.g.,IEEE 802.5 token rings).  Many links (e.g.,Ethernet)
                    have a standard MTU defined by the link-layer protocol or by the specific document
                    describing how to run IP over the link layer.

   asymmetric reachability
                  - a link where non-reflexive and/or non-transitive reachability is part of normal operation.  (Non-reflexive 
                    reachability means packets from A reach B, but packets from B don't reach A.  Non-transitive reachability
                    means packets from A reach B, and packets from B reach C, but packets from A don't reach C.)
                    Many radio links exhibit these properties.
```

# 2.3.  Addresses
Neighbor Discovery makes use of a number of different addresses defined in [ADDR-ARCH], including:
```
   all-nodes multicast address
               - the link-local scope address to reach all nodes, FF02::1.

   all-routers multicast address
               - the link-local scope address to reach all routers, FF02::2. 

   solicited-node multicast address
               - a link-local scope multicast address that is computed as a function of 
                  the solicited target's address.  The function is described in [ADDR-ARCH].
                 
   link-local address
               - a unicast address having link-only scope that can be used to reach neighbors.  
                  All interfaces on routers MUST have a link-local address.  
                  Also, [ADDRCONF] requires that interfaces on hosts have a link-local address.
                 
   unspecified address
               - a reserved address value that indicates the lack of an address 
                  (e.g., the address is unknown).  
                  It is never used as a destination address, but may be used as a source address 
                  if the sender does not (yet) know its own address 
                  (e.g., while verifying an address is unused during stateless address autoconfiguration [ADDRCONF]).
                  The unspecified address has a value of 0:0:0:0:0:0:0:0.                
```
# Multicast address  
[Multicast address](https://en.wikipedia.org/wiki/Multicast_address)  
**Well-known IPv6 multicast addresses**  

Address | Description
------------------------------------ | ---------------------------------------------
ff02::1 | All nodes on the local network segment
ff02::2 | All routers on the local network segment
ff02::5 | OSPFv3 All SPF routers
ff02::6 | OSPFv3 All DR routers
ff02::8 | IS-IS for IPv6 routers
ff02::9 | RIP routers
ff02::a | EIGRP routers
ff02::d | PIM routers
ff02::16 | MLDv2 reports (defined in RFC 3810)
ff02::1:2 | All DHCP servers and relay agents on the local network segment (defined in [RFC 3315](https://tools.ietf.org/html/rfc3315))
ff02::1:3 | All LLMNR hosts on the local network segment (defined in [RFC 4795](https://tools.ietf.org/html/rfc4795))
ff05::1:3 | All DHCP servers on the local network site (defined in RFC 3315)
ff0x::c | Simple Service Discovery Protocol
ff0x::fb | Multicast DNS
ff0x::101 | Network Time Protocol
ff0x::108 | Network Information Service
ff0x::181 | Precision Time Protocol (PTP) version 2 messages (Sync, Announce, etc.) except peer delay measurement
ff02::6b | Precision Time Protocol (PTP) version 2 peer delay measurement messages
ff0x::114 | Used for experiments

[Multicast DNS mDNS](https://en.wikipedia.org/wiki/Multicast_DNS)    
**Packet structure**  
UDP port 5353  

IPv4 | IPv6
------------------------------------ | ---------------------------------------------
MAC: 01:00:5E:00:00:FB |  MAC: 33:33:00:00:00:FB(IPv6mcast_16)
224.0.0.251 | ff02::fb

# 3.  Protocol Overview
This protocol solves a set of problems related to the interaction between nodes attached to the same link.

1~4:Host-Router Discovery Functions
5~8:Host-Host Communication Functions
9:Redirect Function
```
     1.Router Discovery: How hosts locate routers that reside on an attached link.

     2.Prefix Discovery: How hosts discover the set of address prefixes that define which destinations are on-link for an
                        attached link.  (Nodes use prefixes to distinguishdestinations that reside on-link from those only
                        reachable through a router.)

     3.Parameter Discovery: How a node learns link parameters (such as the link MTU) or Internet parameters (such as the hop limit
                           value) to place in outgoing packets.

     4.Address Autoconfiguration: Introduces the mechanisms needed in order to allow nodes to configure an address for an
                                 interface in a stateless manner.  Stateless address autoconfiguration is specified in [ADDRCONF].

     5.Address resolution: How nodes determine the link-layer address of an on-link destination (e.g., a neighbor) given only the
                           destination's IP address.

     6.Next-hop determination: The algorithm for mapping an IP destination address into the IP address of the neighbor to which
                              traffic for the destination should be sent.  The next-hop can be a router or the destination itself.

     7.Neighbor Unreachability Detection: How nodes determine that a neighbor is no longer reachable.  For neighbors used as
                                          routers, alternate default routers can be tried.  Forboth routers and hosts, address 
                                          resolution can be performed again.

     8.Duplicate Address Detection: How a node determines whether or not an address it wishes to use is already in use by another node.
     
     9.Redirect:  How a router informs a host of a better first-hop node to reach a particular destination.
```
Neighbor Discovery defines five different ICMP packet types: 
A pair of Router Solicitation and Router Advertisement messages, 
a pair of Neighbor Solicitation and Neighbor Advertisements messages, and a redirect message.   
The messages serve the following purpose:
```
     Router Solicitation: When an interface becomes enabled, hosts may send out Router Solicitations that request routers to
                        generate Router Advertisements immediately rather than at their next scheduled time.

     Router Advertisement: Routers advertise their presence together with various link and Internet parameters either periodically, 
                           or in response to a Router Solicitation message.  Router Advertisements contain prefixes that are used for
                           determining whether another address shares the same link (on-link determination) and/or address
                           configuration, a suggested hop limit value, etc.

     Neighbor Solicitation: Sent by a node to determine the link-layer address of a neighbor, or to verify that a neighbor is
                           still reachable via a cached link-layer address.  Neighbor Solicitations are also used for Duplicate
                           Address Detection.

     Neighbor Advertisement: A response to a Neighbor Solicitation message.  A node may also send unsolicited Neighbor
                           Advertisements to announce a link-layer address change.

     Redirect:  Used by routers to inform hosts of a better first hop for a destination.
                
```

# 4.  Message Formats
# 4.1.  Router Solicitation Message Format
```
      0                   1                   2                   3
      0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |     Type      |     Code      |          Checksum             |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |                            Reserved                           |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |   Options ...
     +-+-+-+-+-+-+-+-+-+-+-+-

   IP Fields:

      Source Address
                     An IP address assigned to the sending interface, or the unspecified address if no address is assigned
                     to the sending interface.
      Destination Address
                     Typically the all-routers multicast address.
      Hop Limit      255

   ICMP Fields:

      Type           133
      Code           0
      Checksum       The ICMP checksum.  See [ICMPv6].
      Reserved       This field is unused.  It MUST be initialized to zero by the sender and MUST be ignored by the receiver.

   Valid Options:

      Source link-layer address The link-layer address of the sender, if known.  MUST NOT be included if the Source Address                     
                     is the unspecified address.  Otherwise, it SHOULD be included on link layers that have addresses.
                     
```
# 4.2.  Router Advertisement Message Format
```
      0                   1                   2                   3
      0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |     Type      |     Code      |          Checksum             |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     | Cur Hop Limit |M|O|  Reserved |       Router Lifetime         |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |                         Reachable Time                        |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |                          Retrans Timer                        |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |   Options ...
     +-+-+-+-+-+-+-+-+-+-+-+-

   IP Fields:
      Source Address
                     MUST be the link-local address assigned to the interface from which this message is sent.
      Destination Address
                     Typically the Source Address of an invoking Router Solicitation or the all-nodes multicast address.
      Hop Limit      255

   ICMP Fields:
      Type           134
      Code           0
      Checksum       The ICMP checksum.  See [ICMPv6].

      Cur Hop Limit  8-bit unsigned integer.  The default value that should be placed in the Hop Count field of the IP
                     header for outgoing IP packets.  A value of zero means unspecified (by this router).

      M              1-bit "Managed address configuration" flag.  When set, it indicates that addresses are available via
                     Dynamic Host Configuration Protocol [DHCPv6].

                     If the M flag is set, the O flag is redundant and can be ignored because DHCPv6 will return all available                     
                     configuration information.

      O              1-bit "Other configuration" flag.  When set, it indicates that other configuration information is                     
                     available via DHCPv6.  Examples of such information are DNS-related information or information on other                     
                     servers within the network.

        Note: If neither M nor O flags are set, this indicates that no information is available via DHCPv6.        

      Reserved       A 6-bit unused field.  It MUST be initialized to zero by the sender and MUST be ignored by the receiver.

      Router Lifetime
                     16-bit unsigned integer.  The lifetime associated with the default router in units of seconds.  The                     
                     field can contain values up to 65535 and receivers should handle any value, while the sending rules in
                     Section 6 limit the lifetime to 9000 seconds.  A Lifetime of 0 indicates that the router is not a default router 
                     and SHOULD NOT appear on the default router list.

      Reachable Time 32-bit unsigned integer.  The time, in milliseconds, that a node assumes a neighbor is reachable after                     
                     having received a reachability confirmation.  Used by the Neighbor Unreachability Detection algorithm 
                     (see Section 7.3).  A value of zero means unspecified (by this router).

      Retrans Timer  32-bit unsigned integer.  The time, in milliseconds, between retransmitted Neighbor Solicitation messages.                    
                     Used by address resolution and the Neighbor Unreachability Detection algorithm
                     (see Sections 7.2 and 7.3).  A value of zero means unspecified (by this router).

   Possible options:

      Source link-layer address
                     The link-layer address of the interface from which the Router Advertisement is sent.
                     Only used on link layers that have addresses.  A router MAY omit this option in order to
                     enable inbound load sharing across multiple link-layer addresses.

      MTU            SHOULD be sent on links that have a variable MTU (as specified in the document that describes how to
                     run IP over the particular link type).  MAY be sent on other links.

      Prefix Information
                     These options specify the prefixes that are on-link and/or are used for stateless address                     
                     autoconfiguration.  A router SHOULD include all its on-link prefixes (except the link-local prefix) so                     
                     that multihomed hosts have complete prefix information about on-link destinations for the links to which they                     
                     attach.  If complete information is lacking, a host with multiple interfaces may not be able to choose the correct                     
                     outgoing interface when sending traffic to its neighbors.

```
# 4.3.  Neighbor Solicitation Message Format
```
Nodes send Neighbor Solicitations to request the link-layer address of a target node while also providing their own link-layer address to the target.  Neighbor Solicitations are multicast when the node needs to resolve an address and unicast when the node seeks to verify the reachability of a neighbor.

      0                   1                   2                   3
      0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |     Type      |     Code      |          Checksum             |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |                           Reserved                            |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |                                                               |
     +                                                               +
     |                                                               |
     +                       Target Address                          +
     |                                                               |
     +                                                               +
     |                                                               |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |   Options ...
     +-+-+-+-+-+-+-+-+-+-+-+-

    IP Fields:
      Source Address
                     Either an address assigned to the interface from which this message is sent or (if Duplicate Address                     
                     Detection is in progress [ADDRCONF]) the unspecified address.                     
      Destination Address
                     Either the solicited-node multicast address corresponding to the target address, or the target address.
      Hop Limit      255

   ICMP Fields:
      Type           135
      Code           0    
      Checksum       The ICMP checksum.  See [ICMPv6].
      Reserved       This field is unused.
      Target Address The IP address of the target of the solicitation.
                     It MUST NOT be a multicast address.

   Possible options:
      Source link-layer address
                     The link-layer address for the sender.  MUST NOT be included when the source IP address is the unspecified address.
```
# 4.4.  Neighbor Advertisement Message Format
```
       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |     Type      |     Code      |          Checksum             |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |R|S|O|                     Reserved                            |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                                                               |
      +                                                               +
      |                                                               |
      +                       Target Address                          +
      |                                                               |
      +                                                               +
      |                                                               |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |   Options ...
      +-+-+-+-+-+-+-+-+-+-+-+-

   IP Fields:

      Source Address
                     An address assigned to the interface from which the advertisement is sent.                    
      Destination Address
                     For solicited advertisements, the Source Address of an invoking Neighbor Solicitation or, if the                     
                     solicitation's Source Address is the unspecified address, the all-nodes multicast address.
                     For unsolicited advertisements typically the all-nodes multicast address.
      Hop Limit      255

   ICMP Fields:
      Type           136
      Code           0
      Checksum       The ICMP checksum.  See [ICMPv6].

      R              Router flag.  When set, the R-bit indicates that the sender is a router.  The R-bit is used by                     
                     Neighbor Unreachability Detection to detect a roter that changes to a host.                     

      S              Solicited flag.  When set, the S-bit indicates that the advertisement was sent in response to a                     
                     Neighbor Solicitation from the Destination address.
                     The S-bit is used as a reachability confirmation for Neighbor Unreachability Detection.  It MUST NOT
                     be set in multicast advertisements or in unsolicited unicast advertisements.

      O              Override flag.  When set, the O-bit indicates that the advertisement should override an existing cache
                     entry and update the cached link-layer address.
                     When it is not set the advertisement will not update a cached link-layer address though it will
                     update an existing Neighbor Cache entry for which no link-layer address is known.  It SHOULD NOT be
                     set in solicited advertisements for anycast addresses and in solicited proxy advertisements.
                     It SHOULD be set in other solicited advertisements and in unsolicited advertisements.
```
# 4.5.  Redirect Message Format
Routers send Redirect packets to inform a host of a better first-hop node on the path to a destination.  Hosts can be redirected to a
better first-hop router but can also be informed by a redirect that the destination is in fact a neighbor.
```
       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |     Type      |     Code      |          Checksum             |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                           Reserved                            |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                                                               |
      +                                                               +
      |                                                               |
      +                       Target Address                          +
      |                                                               |
      +                                                               +
      |                                                               |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                                                               |
      +                                                               +
      |                                                               |
      +                     Destination Address                       +
      |                                                               |
      +                                                               +
      |                                                               |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |   Options ...
      +-+-+-+-+-+-+-+-+-+-+-+-

   IP Fields:

      Source Address
                     MUST be the link-local address assigned to the interface from which this message is sent.
     Destination Address
                     The Source Address of the packet that triggered the redirect.
      Hop Limit      255

   ICMP Fields:

      Type           137
      Code           0
      Checksum       The ICMP checksum.  See [ICMPv6].
      Reserved       This field is unused.
      Target Address
                     An IP address that is a better first hop to use for the ICMP Destination Address.  When the target is                       
                     the actual endpoint of communication, i.e., the destination is a neighbor, the Target Address field
                     MUST contain the same value as the ICMP Destination Address field.
      Destination Address
                     The IP address of the destination that is redirected to the target.
                                          
```
# 4.6.  Option Formats
# 4.6.1.  Source/Target Link-layer Address
```
      0                   1                   2                   3
      0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |     Type      |    Length     |    Link-Layer Address ...
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

   Fields:

      Type
                     1 for Source Link-layer Address
                     2 for Target Link-layer Address
      Length         The length of the option (including the type and length fields) in units of 8 octets.  For example,                     
                     the length for IEEE 802 addresses is 1 [IPv6-ETHER].                    
      Link-Layer Address
                     The variable length link-layer address.

      Description
                     The Source Link-Layer Address option contains the link-layer address of the sender of the packet.
                     It is used in the Neighbor Solicitation, Router Solicitation, and Router Advertisement packets.                     
```
# 4.6.2.  Prefix Information
```

       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |     Type      |    Length     | Prefix Length |L|A| Reserved1 |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                         Valid Lifetime                        |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                       Preferred Lifetime                      |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                           Reserved2                           |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                                                               |
      +                                                               +
      |                                                               |
      +                            Prefix                             +
      |                                                               |
      +                                                               +
      |                                                               |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


   Fields:

      Type           3
      Length         4
      Prefix Length  8-bit unsigned integer.  The number of leading bits in the Prefix that are valid.  The value ranges                     
                     from 0 to 128.  The prefix length field provides necessary information for on-link determination                     
                     (when combined with the L flag in the prefix information option).
                     
      L              1-bit on-link flag.  When set, indicates that this prefix can be used for on-link determination.  When                     
                     not set the advertisement makes no statement about on-link or off-link properties of the prefix.
                     
      A              1-bit autonomous address-configuration flag.  When set indicates that this prefix can be used for                     
                     stateless address configuration as specified in [ADDRCONF].
      Reserved1      6-bit unused field.

      Valid Lifetime
                     32-bit unsigned integer.  The length of time in seconds (relative to the time the packet is sent)                     
                     that the prefix is valid for the purpose of on-link determination.  A value of all one bits                     
                     (0xffffffff) represents infinity.
                     
      Preferred Lifetime
                     32-bit unsigned integer.  The length of time in seconds (relative to the time the packet is sent)                     
                     that addresses generated from the prefix via stateless address autoconfiguration remain preferred [ADDRCONF].                    
                     A value of all one bits (0xffffffff) represents infinity.
     Reserved2      This field is unused. 
     
     Prefix         An IP address or a prefix of an IP address.  The Prefix Length field contains the number of valid                     
                     leading bits in the prefix.  The bits in the prefix after the prefix length are reserved and MUST be                     
                     initialized to zero by the sender and ignored by the receiver.
     Description
                     The Prefix Information option provide hosts with on-link prefixes and prefixes for Address Autoconfiguration.                    
                     The Prefix Information option appears in Router Advertisement packets and MUST be silently ignored for other
                     messages.
```

# 4.6.3.  Redirected Header
```
       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |     Type      |    Length     |            Reserved           |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                           Reserved                            |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                                                               |
      ~                       IP header + data                        ~
      |                                                               |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

   Fields:

      Type           4
      Length         The length of the option in units of 8 octets.
      Reserved       These fields are unused.  They MUST be initialized to zero by the sender and MUST be ignored by the                     
                     receiver.
     IP header + data
                     The original packet truncated to ensure that the size of the redirect message does not exceed the                     
                     minimum MTU required to support IPv6 as specified in[IPv6].                     

     Description
                     The Redirected Header option is used in Redirect messages and contains all or part of the packet                     
                     that is being redirected.                     
```
# 4.6.4.  MTU
```
       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |     Type      |    Length     |           Reserved            |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                              MTU                              |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

   Fields:

      Type           5

      Length         1

      Reserved       This field is unused.  It MUST be initialized to zero by the sender and MUST be ignored by the receiver.

      MTU            32-bit unsigned integer.  The recommended MTU for the link.

   Description
                     The MTU option is used in Router Advertisement messages to ensure that all nodes on a link use the                     
                     same MTU value in those cases where the link MTU is not well known.
                     
```
# 6.  Router and Prefix Discovery
This section describes router and host behavior related to the Router Discovery portion of Neighbor Discovery.
Router Discovery is used to locate neighboring routers as well as learn prefixes and configuration parameters related to stateless address autoconfiguration.

Prefix Discovery is the process through which hosts learn the ranges of IP addresses that reside on-link and can be reached directly without going through a router.  
Routers send Router Advertisements that indicate whether the sender is willing to be a default router.  Router Advertisements also contain Prefix Information options that list the set of prefixes that identify on-link IP addresses.

Stateless Address Autoconfiguration must also obtain subnet prefixes as part of configuring addresses.  Although the prefixes used for address autoconfiguration are logically distinct from those used for on-link determination, autoconfiguration information is piggybacked on Router Discovery messages to reduce network traffic.  
bIndeed, the same prefixes can be advertised for on-link determination and address  autoconfiguration by specifying the appropriate flags in the Prefix Information options.  See [ADDRCONF] for details on how  autoconfiguration information is processed.

# 6.1.  Message Validation
# 6.1.1.  Validation of Router Solicitation Messages
# 6.1.2.  Validation of Router Advertisement Messages

# 6.2.  Router Specification
# 6.2.1.  Router Configuration Variables
# 6.2.2.  Becoming an Advertising Interface
# 6.2.3.  Router Advertisement Message Content
# 6.2.4.  Sending Unsolicited Router Advertisements
# 6.2.5.  Ceasing To Be an Advertising Interface
# 6.2.6.  Processing Router Solicitations
# 6.2.7.  Router Advertisement Consistency
# 6.2.8.  Link-local Address Change

# 6.3.  Host Specification
# 6.3.1.  Host Configuration Variables
None.
# 6.3.2.  Host Variables
# 6.3.3.  Interface Initialization
# 6.3.4.  Processing Received Router Advertisements
# 6.3.5.  Timing out Prefixes and Default Routers
# 6.3.6.  Default Router Selection
# 6.3.7.  Sending Router Solicitations

# 7.  Address Resolution and Neighbor Unreachability Detection
# 7.1.  Message Validation
# 7.1.1.  Validation of Neighbor Solicitations
# 7.1.2.  Validation of Neighbor Advertisements

# 7.2.  Address Resolution
It is possible that a host may receive a solicitation, a router advertisement, or a Redirect message without a link-layer address option included.
# 7.2.1.  Interface Initialization
# 7.2.2.  Sending Neighbor Solicitations
# 7.2.3.  Receipt of Neighbor Solicitations
# 7.2.4.  Sending Solicited Neighbor Advertisements
# 7.2.5.  Receipt of Neighbor Advertisements
# 7.2.6.  Sending Unsolicited Neighbor Advertisements
# 7.2.7.  Anycast Neighbor Advertisements
# 7.2.8.  Proxy Neighbor Advertisements

# 7.3.  Neighbor Unreachability Detection
Neighbor Unreachability Detection is used for all paths between hosts and neighboring nodes, including host-to-host, host-to-router, and router-to-host communication.
# 7.3.1.  Reachability Confirmation
# 7.3.2.  Neighbor Cache Entry States
# 7.3.3.  Node Behavior

# 8.  Redirect Function
# 8.1.  Validation of Redirect Messages
# 8.2.  Router Specification
# 8.3.  Host Specification

# 9.  Extensibility - Option Processing

Reference
==============================
* [Neighbor Discovery for IP version 6 (IPv6),RFC4861, September 2007](https://tools.ietf.org/html/rfc4861)
* [[ADDR-ARCH] "IP Version 6 Addressing Architecture", RFC 4291, February 2006.](https://tools.ietf.org/html/rfc4291)
* [[ADDRCONF] "IPv6 Stateless Address Autoconfiguration", RFC 4862, September 2007.](https://tools.ietf.org/html/rfc4862)

* []()
![alt tag]()
