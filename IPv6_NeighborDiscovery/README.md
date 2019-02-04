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

# 2.3.  Addresses

Reference
==============================
* [Neighbor Discovery for IP version 6 (IPv6),RFC4861, September 2007](https://tools.ietf.org/html/rfc4861)

* []()
![alt tag]()
