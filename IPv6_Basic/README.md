# Abstract
Version 6 of the Internet Protocol (IPv6) specification Introduction.  It obsoletes RFC 2460.

Introduction
==============================
o  Expanded Addressing Capabilities
  IPv6 increases the IP address size from 32 bits to 128 bits, 
  to support more levels of addressing hierarchy, 
  a much greater number of addressable nodes, 
  and simpler autoconfiguration of addresses.  
  The scalability of multicast routing is improved by adding a "scope" field to multicast addresses.  
  And a new type of address called an "anycast address" is defined; it is used to send a packet to any one of a group of nodes.
  
o  Header Format Simplification
  Some IPv4 header fields have been dropped or made optional, to reduce the common-case processing cost of packet handling and
  to limit the bandwidth cost of the IPv6 header.
  
o  Improved Support for Extensions and Options
  IP header options are encoded allows for more efficient forwarding, less stringent limits on the length
  of options, and greater flexibility for introducing new options in the future.
  
o  Flow Labeling Capability
  To enable the labeling of sequences of packets that the sender requests to be treated in the network as a single flow.
  
o  Authentication and Privacy Capabilities
  Extensions to support authentication, data integrity, and (optional) data confidentiality are specified for IPv6.
  
The format and semantics of IPv6 addresses are specified separately in [RFC4291](https://tools.ietf.org/html/rfc4291).
The IPv6 version of ICMP, which all IPv6 implementations are required to include, is specified in [RFC4443](https://tools.ietf.org/html/rfc4443).

Terminology
==============================


Reference 
==============================
* [Internet Protocol, Version 6 (IPv6) Specification RFC2460 December 1998](https://tools.ietf.org/html/rfc2460)
* [Internet Protocol, Version 6 (IPv6) Specification RFC8200 July 2017](https://tools.ietf.org/html/rfc8200)

* []()
