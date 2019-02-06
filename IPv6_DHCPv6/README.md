# 1.  Introduction
This document describes DHCP for IPv6 (DHCPv6), a client/server protocol that provides managed configuration of devices.
The basic operation of DHCPv6 provides configuration for clients connected to the same link as the server.

DHCPv6 can provide a device with addresses assigned by a DHCPv6 server and other configuration information; this data is carried in  options.

DHCPv6 also provides a mechanism for automated delegation of IPv6 prefixes using DHCPv6, as originally specified in [RFC3633].  Through  this mechanism, a delegating router can delegate prefixes to requesting routers.

DHCP can also be used just to provide other configuration options (i.e., no addresses or prefixes).  That implies that the server does not have to track any state; thus, this mode is called "stateless DHCPv6".

# 1.1.  Relationship to Previous DHCPv6 Standards
The initial specification of DHCPv6 was defined in [RFC3315], and a number of follow-up documents were published over the years:
   -  [RFC3633] ("IPv6 Prefix Options for Dynamic Host Configuration Protocol (DHCP) version 6")

   -  [RFC3736] ("Stateless Dynamic Host Configuration Protocol (DHCP) Service for IPv6")

   -  [RFC4242] ("Information Refresh Time Option for Dynamic Host Configuration Protocol for IPv6 (DHCPv6)")

   -  [RFC7083] ("Modification to Default Values of SOL_MAX_RT and INF_MAX_RT")

   -  [RFC7283] ("Handling Unknown DHCPv6 Messages")

   -  [RFC7550] ("Issues and Recommendations with Multiple Stateful DHCPv6 Options")
   
# 1.2.  Relationship to DHCPv4
The operational models and relevant configuration information for DHCPv4 [RFC2131] [RFC2132] and DHCPv6 are sufficiently different that integration between the two services is not included in this document.
   
# 3.  Background
[RFC8200] ("Internet Protocol, Version 6 (IPv6) Specification") provides the base architecture and design of IPv6.  In addition to [RFC8200], related work in IPv6 that an implementer would be best served to study includes

   -  [RFC4291] ("IP Version 6 Addressing Architecture")

   -  [RFC4862] ("IPv6 Stateless Address Autoconfiguration")

   -  [RFC4861] ("Neighbor Discovery for IP version 6 (IPv6)")

These specifications enable DHCP to build upon the IPv6 work to provide robust stateful autoconfiguration.

[RFC4291] defines the address scope that can be used in an IPv6 implementation and also provides various configuration architecture guidelines for network designers of the IPv6 address space.
Two advantages of IPv6 are that support for multicast is required and nodes can create link-local addresses during initialization.  The availability of these features means that a client can use its link-local address and a well-known multicast address to discover and communicate with DHCP servers or relay agents on its link.

[RFC4862] specifies procedures by which a node may autoconfigure addresses based on Router Advertisements [RFC4861] and the use of a valid lifetime to support renumbering of addresses on the Internet.  Compatibility with stateless address autoconfiguration is a design requirement of DHCP.

IPv6 Neighbor Discovery [RFC4861] is the node discovery protocol in IPv6 that replaces and enhances functions of ARP [RFC826].  To understand IPv6 and stateless address autoconfiguration, it is strongly recommended that implementers understand IPv6 Neighbor  Discovery.
   
# 9.  Extensibility - Option Processing

Reference
==============================
* [Dynamic Host Configuration Protocol for IPv6 (DHCPv6), RFC8415, November 2018](https://tools.ietf.org/html/rfc8415)

* []()
![alt tag]()
