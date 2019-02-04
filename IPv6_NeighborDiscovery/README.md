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
                 
```
# 1.  Introduction
# 1.  Introduction

Reference
==============================
* [Neighbor Discovery for IP version 6 (IPv6),RFC4861, September 2007](https://tools.ietf.org/html/rfc4861)

* []()
![alt tag]()
