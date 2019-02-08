# 1.  Introduction
This document specifies the steps a host takes in deciding how to autoconfigure its interfaces in IP version 6 (IPv6).
The autoconfiguration process includes:
```
generating a link-local address,
generating global addresses via stateless address autoconfiguration,
and the Duplicate Address Detection procedure to verify the uniqueness of the addresses on a link.
```
The IPv6 stateless autoconfiguration mechanism requires no manual configuration of hosts, minimal (if any) configuration of routers, and no additional servers.
The stateless mechanism allows a host to generate its own addresses using a combination of locally available information and information advertised by routers.  
Routers advertise prefixes that identify the subnet(s) associated with a link, while hosts generate an "interface identifier" that uniquely identifies an interface on a subnet.  An address is formed by combining the two.
In the absence of routers, a host can only generate link-local addresses.  However, link-local addresses are sufficient for allowing  communication among nodes attached to the same link.
The stateless approach is used when a site is not particularly concerned with the exact addresses hosts use, so long as they are unique and properly routable.  On the other hand, Dynamic Host Configuration Protocol for IPv6 (DHCPv6) [RFC3315] is used when a site requires tighter control over exact address assignments.  Both stateless address autoconfiguration and DHCPv6 may be used simultaneously.

IPv6 addresses are leased to an interface for a fixed (possibly infinite) length of time.  Each address has an associated lifetime that indicates how long the address is bound to an interface.
When a lifetime expires, the binding (and address) become invalid and the address may be reassigned to another interface elsewhere in the Internet.
To handle the expiration of address bindings gracefully, an address goes through two distinct phases while assigned to an interface.
Initially, an address is "preferred", meaning that its use in arbitrary communication is unrestricted.  Later, an address becomes "deprecated" in anticipation that its current interface binding will become invalid.  While an address is in a deprecated  state, its use is discouraged, but not strictly forbidden.

To ensure that all configured addresses are likely to be unique on a given link, nodes run a "duplicate address detection" algorithm on  addresses before assigning them to an interface.  The Duplicate Address Detection algorithm is performed on all addresses, independently of whether they are obtained via stateless autoconfiguration or DHCPv6.

The autoconfiguration process specified in this document applies only to hosts and not routers.
Since host autoconfiguration uses information advertised by routers, routers will need to be configured by some other means.  However, it is expected that routers will generate link-local addresses using the mechanism described in this document.

# 2.  Terminology
```
IP
node
router
host
upper layer -  a protocol layer immediately above IP.
link -  a communication facility or medium over which nodes can communicate at the link layer, i.e., the layer immediately below IP.
interface
packet
address
unicast address
multicast address
anycast address
solicited-node multicast address
link-layer address -  a link-layer identifier for an interface. Examples include IEEE 802 addresses for Ethernet links
link-local address -  an address having link-only scope that can be used to reach neighboring nodes attached to the same link.
global address -  an address with unlimited scope.
communication -  Examples are a TCP connection or a UDP request-response.
tentative address -  an address whose uniqueness on a link is being verified, prior to its assignment to an interface.
preferred address -  an address assigned to an interface whose use by upper-layer protocols is unrestricted.
deprecated address -  An address assigned to an interface whose use is discouraged, but not forbidden.
valid address -  a preferred or deprecated address.  A valid address may appear as the source or destination address of a packet,
invalid address -  an address that is not assigned to any interface. A valid address becomes invalid when its valid lifetime expires.
preferred lifetime -  the length of time that a valid address is preferred (i.e., the time until deprecation).
valid lifetime -  the length of time an address remains in the valid state (i.e., the time until invalidation).
interface identifier -  a link-dependent identifier for an interface that is (at least) unique per link [RFC4291].  Stateless address
      autoconfiguration combines an interface identifier with a prefix to form an address.  From address autoconfiguration's
      perspective, an interface identifier is a bit string of known length.
```
# 3.  Design Goals
```
o  Manual configuration of individual machines before connecting them to the network should not be required.
   Consequently, a mechanism is needed that allows a host to obtain or create unique addresses for each of its interfaces.     
   Address autoconfiguration assumes that each interface can provide a unique identifier for that
   interface (i.e., an "interface identifier").

o  Small sites consisting of a set of machines attached to a single link should not require the presence of a DHCPv6 server or router
   as a prerequisite for communicating.  Plug-and-play communication is achieved through the use of link-local addresses.
   Link-local addresses have a well-known prefix that identifies the (single) shared link to which a set of nodes attach.     
   A host forms a link-local address by appending an interface identifier to the link-local prefix.
      
o  A large site with multiple networks and routers should not require the presence of a DHCPv6 server for address configuration.
   In order to generate global addresses, hosts must determine the prefixes that identify the subnets to which they attach.  
   Routers generate periodic Router Advertisements that include options listing the set of active prefixes on a link.

o  Address configuration should facilitate the graceful renumbering of a site's machines.  Renumbering is achieved through the
   leasing ofaddresses to interfaces and the assignment of multiple addresses to the same interface.  Lease lifetimes provide the
   mechanism through which a site phases out old prefixes.  The assignment of multiple addresses to an interface provides for a
   transition period during which both a new address and the one being phased out work simultaneously.
```
# 4.  Protocol Overview
multicast-capable interface is enabled, e.g., during system startup. Nodes (both hosts and routers) begin the autoconfiguration process by generating a link-local address for the interface.  A link-local address is formed by appending an identifier of the interface to the well-known link-local prefix [RFC4291].

Before the link-local address can be assigned to an interface and used, however, a node must attempt to verify that this "tentative" address is not already in use by another node on the link.

If a node determines that its tentative link-local address is not unique, autoconfiguration stops and manual configuration of the interface is required.

Once a node ascertains that its tentative link-local address is unique, it assigns the address to the interface.  At this point, the node has IP-level connectivity with neighboring nodes.

The next phase of autoconfiguration involves obtaining a Router Advertisement or determining that no routers are present.  If routers are present, they will send Router Advertisements that specify what sort of autoconfiguration a host can do.

Routers send Router Advertisements periodically, but the delay between successive advertisements will generally be longer than a host performing autoconfiguration will want to wait [RFC4861].  To obtain an advertisement quickly, a host sends one or more Router Solicitations to the all-routers multicast group.

Router Advertisements also contain zero or more Prefix Information options that contain information used by stateless address autoconfiguration to generate global addresses.

By default, all addresses should be tested for uniqueness prior to their assignment to an interface for safety.  The test should individually be performed on all addresses obtained manually, via stateless address autoconfiguration, or via DHCPv6.

To speed the autoconfiguration process, a host may generate its link- local address (and verify its uniqueness) in parallel with waiting for a Router Advertisement.

# 4.1.  Site Renumbering
Address leasing facilitates site renumbering by providing a mechanism to time-out addresses assigned to interfaces in hosts.  At present, upper-layer protocols such as TCP provide no support for changing end-point addresses while a connection is open.

# 1.  Introduction
# 1.  Introduction
# 1.  Introduction
# 1.  Introduction

Reference
==============================
* [IPv6 Stateless Address Autoconfiguration, RFC4862, September 2007](https://tools.ietf.org/html/rfc4862)
* [slaac-wan.tcl  Autoconf / SLAAC client tests for the WAN side of the router](https://support.qacafe.com/test-summary/ipv6-test-summary/#slaac-wan.tcl)

* []()
![alt tag]()
