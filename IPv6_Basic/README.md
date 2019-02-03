# Abstract
Version 6 of the Internet Protocol (IPv6) specification Introduction.  It obsoletes RFC 2460.

Introduction
==============================
o  Expanded Addressing Capabilities
``` 
  IPv6 increases the IP address size from 32 bits to 128 bits, 
  to support more levels of addressing hierarchy, 
  a much greater number of addressable nodes, 
  and simpler autoconfiguration of addresses.  
  The scalability of multicast routing is improved by adding a "scope" field to multicast addresses.  
  And a new type of address called an "anycast address" is defined; it is used to send a packet to any one of a group of nodes.

``` 

o  Header Format Simplification

``` 
Some IPv4 header fields have been dropped or made optional, to reduce the common-case processing cost of packet handling and
to limit the bandwidth cost of the IPv6 header.
```

o  Improved Support for Extensions and Options

``` 
IP header options are encoded allows for more efficient forwarding, less stringent limits on the length of options,
and greater flexibility for introducing new options in the future.
 ```
 
o  Flow Labeling Capability
``` 
To enable the labeling of sequences of packets that the sender requests to be treated in the network as a single flow.
```

o  Authentication and Privacy Capabilities
``` 
Extensions to support authentication, data integrity, and (optional) data confidentiality are specified for IPv6.
``` 

The format and semantics of IPv6 addresses are specified separately in [RFC4291](https://tools.ietf.org/html/rfc4291).

The IPv6 version of ICMP, which all IPv6 implementations are required to include, is specified in [RFC4443](https://tools.ietf.org/html/rfc4443).

Terminology
==============================
node
```
a device that implements IPv6.
```
router
```
a node that forwards IPv6 packets not explicitly addressed to itself.
```
host
```
any node that is not a router.
```
upper layer
```
a protocol layer immediately above IPv6.
transport protocols such as TCP and UDP,
control protocols such as ICMP,
routing protocols such as OSPF,
internet-layer or lower-layer protocols being "tunneled" over (i.e., encapsulated in) IPv6 such as IPX, AppleTalk.
```
link
```
a communication facility or medium over which nodes can communicate at the link layer, i.e., the layer immediately below IPv6.
Examples are Ethernets PPP links; X.25, Frame Relay, or ATM networks;
and internet-layer or higher-layer "tunnels", such as tunnels over IPv4 or IPv6 itself.
```
neighbors
```
nodes attached to the same link.
```
interface
```
a node's attachment to a link.
```
address
```
an IPv6-layer identifier for an interface or a set of interfaces.
```
packet
```
an IPv6 header plus payload.
```
link MTU
```
the maximum transmission unit, i.e., maximum packet size in octets, that can be conveyed over a link.
```
path MTU
```
the minimum link MTU of all the links in a path between a source node and a destination node.
```
IPv6 Header Format 
==============================
![alt tag](https://sites.google.com/site/amitsciscozone/_/rsrc/1468881649334/home/important-tips/ipv6/ipv6-specifications/IPv6%20packet%20format.JPG)

Version- 4-bit IPv6 version 6

Traffic class- 8-bit traffic class field

The current use of the Traffic Class field for Differentiated Services and Explicit Congestion Notification is specified in
[RFC2474](https://tools.ietf.org/html/rfc2474) and [RFC3168](https://tools.ietf.org/html/rfc3168).

Flow Label- 20-bit flow label field

Payload Length- 16-bit length of the packet payload excluding the standard header. If Extension headers are present, they are included in the payload length.

Next Header- 8-bit selector identifying the type of header following the IPv6 header

Hop Limit- 8-bit unsigned integer decremented by 1 by each node that forwards the packet. If the Hop Limit reaches 0, the packet is discarded.

Source and Destination Addresses- 128-bit addresses of the sender and the receiver.

Reference 
==============================
* [Internet Protocol, Version 6 (IPv6) Specification RFC2460 December 1998](https://tools.ietf.org/html/rfc2460)
* [Internet Protocol, Version 6 (IPv6) Specification RFC8200 July 2017](https://tools.ietf.org/html/rfc8200)

* []()
