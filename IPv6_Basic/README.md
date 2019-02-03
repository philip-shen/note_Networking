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

Be used by a source to label sequences of packets to be treated in the network as a single flow.
The current definition of the IPv6 Flow Label can be found in [RFC6437](https://tools.ietf.org/html/rfc6437).

Payload Length- 16-bit length of the packet payload excluding the standard header. If Extension headers are present, they are included in the payload length.

Next Header- 8-bit selector identifying the type of header following the IPv6 header

Hop Limit- 8-bit unsigned integer decremented by 1 by each node that forwards the packet. If the Hop Limit reaches 0, the packet is discarded.

Source and Destination Addresses- 128-bit addresses of the sender and the receiver.

IPv6 Extension Headers
==============================
Extension headers are numbered from IANA IP Protocol Numbers [IANA-PN](https://tools.ietf.org/html/rfc8200#ref-IANA-PN), the same values used for IPv4 and IPv6.  When processing a sequence of Next Header values in a packet, the first one that is not an extension header [IANA-EH](https://tools.ietf.org/html/rfc8200#ref-IANA-EH) indicates that the next item in the packet is the corresponding upper-layer header.  A special "No Next Header" value is used if there is no upper-layer header.

![alt tag](https://sites.google.com/site/amitsciscozone/home/important-tips/ipv6/ipv6-specifications/IPv6%20Extension%20Headers.JPG?attredirects=0)

A full implementation of IPv6 includes implementation of the following extension headers:
```
Hop-by-Hop Options
Fragment
Destination Options
Routing
Authentication
Encapsulating Security Payload
```

  # Extension Header Order
  When more than one extension header is used in the same packet, it is recommended that those headers appear in the following order:
  ```
  IPv6 header
  Hop-by-Hop Options header
  Destination Options header (note 1)
  Routing header
  Fragment header
  Authentication header (note 2)
  Encapsulating Security Payload header (note 2)
  Destination Options header (note 3)
  Upper-Layer header
  ```
  Each Extension header can appear AT THE MOST once, except Destination Options header which can appear at the most twice(once before
  the Routing header and once after the Routing header.)
  
  # Options
  ![alt tag](http://www.firewall.cx/images/stories/ipv6-analysis-3.gif)
  
  Option Type
  ```
  8-bit identifier of the type of option.
  
  The Option Type identifiers are internally encoded such that their highest-order 2 bits specify the action that must be taken if the
  processing IPv6 node does not recognize the Option Type:
    00 - skip over this option and continue processing the header.
    01 - discard the packet.
    10 - discard the packet and, regardless of whether or not the packet's Destination Address was a multicast address, send an ICMP
         Parameter Problem, Code 2, message to the packet's Source Address, pointing to the unrecognized Option Type.
    11 - discard the packet and, only if the packet's Destination Address was not a multicast address, send an ICMP Parameter Problem,
         Code 2, message to the packet's Source Address, pointing to the unrecognized Option Type.
  
  The third-highest-order bit of the Option Type specifies whether or not the Option Data of that option can change en route to the
  packet's final destination.
  ```
  
  #Hop-by-Hop Options Header:
  ![alt tag](http://www.masterraghu.com/subjects/np/introduction/unix_network_programming_v1.3/files/27fig07.gif)
    The Hop-by-Hop Options header is used to carry optional information that may be examined and processed by every node along a
    packet's delivery path.  The Hop-by-Hop Options header is identified by a Next Header value of 0 in the IPv6 header.
  
  #Routing Header:
  ![alt tag](http://www.firewall.cx/images/stories/ipv6-analysis-4.gif)
    
    ```
    Next Header
    Hdr Ext Len
    Routing Type
    Segments Left
    type-specific data  Variable-length field, of format determined by the Routing Type, and of length such that the complete Routing
                        header is an integer multiple of 8 octets long.
    ```
    
  #Fragment Header:
    ![alt tag](http://www.firewall.cx/images/stories/ipv6-analysis-6.gif)
  
  #Destination Options Header:
  
  #No Next Header:
    The value 59 in the Next Header field of an IPv6 header or any extension header indicates that there is nothing following that
    header. 
  
Reference 
==============================
* [Internet Protocol, Version 6 (IPv6) Specification RFC2460 December 1998](https://tools.ietf.org/html/rfc2460)
* [Internet Protocol, Version 6 (IPv6) Specification RFC8200 July 2017](https://tools.ietf.org/html/rfc8200)
* [IPv6 - Analysing the IPv6 Protocol Structure and IPv6 Header](http://www.firewall.cx/networking-topics/protocols/874-ipv6-analysis.html)

* []()
![alt tag]()
