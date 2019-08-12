# Table of Contents  
[1. Introduction](#1--introduction)  
[2. Terminology](#2--terminology)  
[3. Design Goals](#3--design-goals)  
[4. Protocol Overview](#4--protocol-overview)  
[4.1. Site Renumbering](#41--site-renumbering)  

[5. Protocol Specification](#5--protocol-specification)  
[5.1. Node Configuration Variables](#51--node-configuration-variables)  
[5.2. Autoconfiguration-Related Structures](#52--autoconfiguration-related-structures)  
[5.3. Creation of Link-Local Addresses](#53--creation-of-link-local-addresses)  

[5.4. Duplicate Address Detection](#54--duplicate-address-detection)  
[5.4.1. Message Validation](#541--message-validation)  
[5.4.2. Sending Neighbor Solicitation Messages](#542--sending-neighbor-solicitation-messages)  
[5.4.3. Receiving Neighbor Solicitation Messages](#543--receiving-neighbor-solicitation-messages)  
[5.4.4. Receiving Neighbor Advertisement Messages](#544--receiving-neighbor-advertisement-messages)  
[5.4.5. When Duplicate Address Detection Fails](#545--when-duplicate-address-detection-fails)  

[5.5. Creation of Global Addresses](#55--creation-of-global-addresses)  
[5.5.1. Soliciting Router Advertisements](#551--soliciting-router-advertisements)  
[5.5.2. Absence of Router Advertisements](#552--absence-of-router-advertisements)  
[5.5.3. Router Advertisement Processing](#553--router-advertisement-processing)  
[5.5.4. Address Lifetime Expiry](#554--address-lifetime-expiry)  

[5.6. Configuration Consistency](#56--configuration-consistency)  
[5.7. Retaining Configured Addresses for Stability](#57--retaining-configured-addresses-for-stability)  

[Reference](#reference)

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
link-layer address 
                  -  a link-layer identifier for an interface. 
                     Examples include IEEE 802 addresses for Ethernet links

link-local address 
                  -  an address having link-only scope that can be used to reach neighboring nodes 
                     attached to the same link.

global address 
                  -  an address with unlimited scope.
communication 
                  -  Examples are a TCP connection or a UDP request-response.
tentative address 
                  -  an address whose uniqueness on a link is being verified, 
                     prior to its assignment to an interface.

preferred address 
                  -  an address assigned to an interface whose use by upper-layer protocols is unrestricted.

deprecated address 
                  -  An address assigned to an interface whose use is discouraged, but not forbidden.

valid address 
                  -  a preferred or deprecated address.  
                     A valid address may appear as the source or destination address of a packet,

invalid address 
                  -  an address that is not assigned to any interface. 
                     A valid address becomes invalid when its valid lifetime expires.

preferred lifetime 
                  -  the length of time that a valid address is preferred 
                     (i.e., the time until deprecation).

valid lifetime 
                  -  the length of time an address remains in the valid state (i.e., the time until invalidation).

interface identifier 
                  -  a link-dependent identifier for an interface that is (at least) unique per link [RFC4291].             Stateless address autoconfiguration combines an interface identifier with a prefix to 
                      form an address.  From address autoconfiguration's perspective, 
                      an interface identifier is a bit string of known length.
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

Dividing valid addresses into preferred and deprecated categories provides a way of indicating to upper layers that a valid address may become invalid shortly and that future communication using the address will fail, should the address's valid lifetime expire before communication ends.
To avoid this scenario, higher layers should use a preferred address (assuming one of sufficient scope exists) to increase the likelihood that an address will remain valid for the duration of the communication.
It is up to system administrators to set appropriate prefix lifetimes in order to minimize the impact of failed communication when renumbering takes place.  The deprecation period should be long enough that most, if not all, communications are using the new address at the time an address becomes invalid.

The IP layer is expected to provide a means for upper layers (including applications) to select the most appropriate source address given a particular destination and possibly other constraints.
An application may choose to select the source address itself before starting a new communication or may leave the address unspecified, in which case, the upper networking layers will use the mechanism provided by the IP layer to choose a suitable address on the application's behalf.

Detailed address selection rules are beyond the scope of this document and are described in [RFC3484](https://tools.ietf.org/html/rfc3484).

# 5.  Protocol Specification
Autoconfiguration is performed on a per-interface basis on multicast-capable interfaces.  For multihomed hosts, autoconfiguration is performed independently on each interface.
Autoconfiguration applies primarily to hosts, with two exceptions.  
Routers are expected to generate a link-local address using the procedure outlined below.  In addition, routers perform Duplicate Address Detection on all addresses prior to assigning them to an interface.

# 5.1.  Node Configuration Variables
A node MUST allow the following autoconfiguration-related variable to be configured by system management for each multicast-capable interface:
   DupAddrDetectTransmits  The number of consecutive Neighbor Solicitation messages sent while performing Duplicate Address
                              Detection on a tentative address.  
                              A value of zero indicates that Duplicate Address Detection is not performed on tentative addresses.  
                              A value of one indicates a single transmission with no follow-up retransmissions.
Default: 1, but may be overridden by a link-type specific value in the document that covers issues related to the transmission of IP
      over a particular link type (e.g., [RFC2464]).

# 5.2.  Autoconfiguration-Related Structures
how routers (auto)configure their interfaces is beyond the scope of this document.

A host maintains a list of addresses together with their corresponding lifetimes.  The address list contains both autoconfigured addresses and those configured manually.

# 5.3.  Creation of Link-Local Addresses
An interface may become enabled after any of the following events:
```
   -  The interface is initialized at system startup time.

   -  The interface is reinitialized after a temporary interface failure or 
      after being temporarily disabled by system management.
      
   -  The interface attaches to a link for the first time.  
      This includes the case where the attached link is dynamically changed      
      due to a change of the access point of wireless networks.
      
   -  The interface becomes enabled by system management after having been administratively disabled.      
```
A link-local address is formed by combining the well-known link-local prefix FE80::0 [RFC4291] (of appropriate length) 
with an interface identifier as follows:
```
   1.  The left-most 'prefix length' bits of the address are those of the link-local prefix.

   2.  The bits in the address to the right of the link-local prefix are set to all zeroes.

   3.  If the length of the interface identifier is N bits, the right-most N bits of the address are replaced by the interface identifier.
```
If the sum of the link-local prefix length and N is larger than 128, autoconfiguration fails and manual configuration is required.

A link-local address has an infinite preferred and valid lifetime; it is never timed out.

# 5.4.  Duplicate Address Detection
Duplicate Address Detection MUST be performed on all unicast addresses prior to assigning them to an interface, regardless of whether they are obtained through stateless autoconfiguration, DHCPv6, or manual configuration, 
with the following exceptions:
```
   -  An interface whose DupAddrDetectTransmits variable is set to zero does not perform Duplicate Address Detection.

   -  Duplicate Address Detection MUST NOT be performed on anycast addresses (note that anycast addresses cannot 
      syntactically be distinguished from unicast addresses).

   -  Each individual unicast address SHOULD be tested for uniqueness.
      Note that there are implementations deployed that only perform Duplicate Address Detection for 
      the link-local address and skip
      the test for the global address that uses the same interface identifier as that of the link-local address.
```
The procedure for detecting duplicate addresses uses Neighbor Solicitation and Advertisement messages as described below.

An address on which the Duplicate Address Detection procedure is applied is said to be tentative 
until the procedure has completed successfully.  A tentative address is not considered "assigned to an interface" in the traditional sense.
That is, the interface must accept Neighbor Solicitation and Advertisement messages containing the tentative address 
in the Target Address field, but processes such packets differently from those whose Target Address matches an address 
assigned to the interface.

It should also be noted that Duplicate Address Detection must be performed prior to assigning an address to an interface 
in order to prevent multiple nodes from using the same address simultaneously.

# 5.4.1.  Message Validation
A node MUST silently discard any Neighbor Solicitation or Advertisement message that does not pass the validity 
checks specified in [RFC4861].  A Neighbor Solicitation or Advertisement message that passes these validity checks 
is called a valid solicitation or valid advertisement, respectively.

# 5.4.2.  Sending Neighbor Solicitation Messages
Before sending a Neighbor Solicitation, an interface MUST join the all-nodes multicast address and the solicited-node 
multicast address of the tentative address.

To check an address, a node sends DupAddrDetectTransmits Neighbor Solicitations, each separated by RetransTimer milliseconds.  
The solicitation's Target Address is set to the address being checked, the IP source is set to the unspecified address, 
and the IP destination is set to the solicited-node multicast address of the target address.

If the Neighbor Solicitation is going to be the first message sent from an interface after interface (re)initialization, 
the node SHOULD delay joining the solicited-node multicast address by a random delay between 0 and MAX_RTR_SOLICITATION_DELAY as specified in [RFC4861].
This serves to alleviate congestion when many nodes start up on the link at the same time, such as after a power failure,

Even if the Neighbor Solicitation is not going to be the first message sent, the node SHOULD delay joining the solicited-node multicast address by a random delay between 0 and MAX_RTR_SOLICITATION_DELAY if the address being checked is configured by a router advertisement message sent to a multicast address.

Note that when a node joins a multicast address, it typically sends a Multicast Listener Discovery (MLD) report message 
[RFC2710] [RFC3810]  for the multicast address.  In the case of Duplicate Address  Detection, the MLD report message 
is required in order to inform MLD-snooping switches, rather than routers, to forward multicast packets.

In order to improve the robustness of the Duplicate Address Detection algorithm, an interface MUST receive and 
process datagrams sent to the all-nodes multicast address or solicited-node multicast address of the tentative address 
during the delay period.  This does not  necessarily conflict with the requirement that joining 
the multicast group be delayed.

# 5.4.3.  Receiving Neighbor Solicitation Messages
On receipt of a valid Neighbor Solicitation message on an interface, node behavior depends on whether or not the target address is tentative.  
If the target address is not tentative (i.e., it is assigned to the receiving interface), the solicitation is processed as described in [RFC4861].  
If the target address is tentative, and the source address is a unicast address, the solicitation's sender is performing address resolution on the target; the solicitation should be silently ignored.

The following tests identify conditions under which a tentative address is not unique:
```
   -  If a Neighbor Solicitation for a tentative address is received before one is sent, the tentative address is a duplicate.  
      This condition occurs when two nodes run Duplicate Address Detection simultaneously, but transmit initial solicitations at different
      times (e.g., by selecting different random delay values before joining the solicited-node multicast address and transmitting an
      initial solicitation).

   -  If the actual number of Neighbor Solicitations received exceeds the number expected based on the loopback semantics (e.g., the
      interface does not loop back the packet, yet one or more solicitations was received), the tentative address is a duplicate.
      This condition occurs when two nodes run Duplicate Address Detection simultaneously and transmit solicitations at roughly the
      same time.
```

# 5.4.4.  Receiving Neighbor Advertisement Messages
On receipt of a valid Neighbor Advertisement message on an interface, node behavior depends on whether the target address is tentative or matches a unicast or anycast address assigned to the interface:
```
   1.  If the target address is tentative, the tentative address is not unique.

   2.  If the target address matches a unicast address assigned to the receiving interface, it would possibly indicate that the address
       is a duplicate but it has not been detected by the Duplicate Address Detection procedure (recall that Duplicate Address Detection is
       not completely reliable).  How to handle such a case is beyond the scope of this document.

   3.  Otherwise, the advertisement is processed as described in [RFC4861].
```

# 5.4.5.  When Duplicate Address Detection Fails
 If the address is a link-local address formed from an interface identifier based on the hardware address, 
 which is supposed to be uniquely assigned (e.g., EUI-64 for an Ethernet interface), IP operation on the interface 
 SHOULD be disabled.  By disabling IP operation, the node will then:
```
   -  not send any IP packets from the interface,

   -  silently drop any IP packets received on the interface, and

   -  not forward any IP packets to the interface (when acting as a
      router or processing a packet with a Routing header).
```
**Multicast Address ff02::1:ff03:3**
[Multicast Address ff02::1:ff03:3](https://books.google.com.tw/books?id=sQevDAAAQBAJ&pg=PA346&dq=ipv6+ff02::1:ff03:3&hl=en&sa=X&ved=0ahUKEwiv7cSX0P3jAhWIwJQKHT23C_AQ6AEIKDAA#v=onepage&q&f=false)
![alt tag](https://i.imgur.com/KbQqfi6.jpg)  
![alt tag](https://i.imgur.com/slAE7tv.gif)

# 5.5.  Creation of Global Addresses
Global addresses are formed by appending an interface identifier to a prefix of appropriate length.  
Prefixes are obtained from Prefix Information options contained in Router Advertisements.  Creation of 
global addresses as described in this section SHOULD be locally configurable.  However, the processing 
described below MUST be enabled by default.

# 5.5.1.  Soliciting Router Advertisements
Router Advertisements are sent periodically to the all-nodes multicast address.

# 5.5.2.  Absence of Router Advertisements
Even if a link has no routers, the DHCPv6 service to obtain addresses may still be available, and hosts may want to use the service.

Note that it is possible that there is no router on the link in this sense, but there is a node that has the ability to forward packets.
In this case, the forwarding node's address must be manually configured in hosts to be able to send packets off-link, since the only mechanism to configure the default router's address automatically is the one using Router Advertisements.

# 5.5.3.  Router Advertisement Processing
For each Prefix-Information option in the Router Advertisement:

```
    a)  If the Autonomous flag is not set, silently ignore the Prefix Information option.

    b)  If the prefix is the link-local prefix, silently ignore the Prefix Information option.

    c)  If the preferred lifetime is greater than the valid lifetime, silently ignore the Prefix Information option.  
      A node MAY wish to log a system management error in this case.

    d)  If the prefix advertised is not equal to the prefix of an address configured by stateless autoconfiguration 
      already in the list of addresses associated with the interface (where "equal" means the two prefix lengths are 
      the same and the first prefix-length bits of the prefixes are identical), and if the Valid Lifetime is not 0, 
      form an address (and add it to the list) by
      combining the advertised prefix with an interface identifier of the link as follows:

      |            128 - N bits               |       N bits           |
      +---------------------------------------+------------------------+
      |            link prefix                |  interface identifier  |
      +----------------------------------------------------------------+

    e)  If the advertised prefix is equal to the prefix of an address configured by stateless autoconfiguration in the list, 
      the preferred lifetime of the address is reset to the Preferred Lifetime in the received advertisement.
      We call the remaining time "RemainingLifetime" in the  following discussion:

      1.  If the received Valid Lifetime is greater than 2 hours or greater than RemainingLifetime, set the valid lifetime 
         of the corresponding address to the advertised Valid Lifetime.

      2.  If RemainingLifetime is less than or equal to 2 hours, ignore the Prefix Information option with regards to 
         the valid lifetime, unless the Router Advertisement from which this option was obtained has been authenticated 
         (e.g., via Secure Neighbor Discovery [RFC3971]).  
         If the Router Advertisement was authenticated, the valid lifetime of the corresponding
          address should be set to the Valid Lifetime in the received option.

      3.  Otherwise, reset the valid lifetime of the corresponding address to 2 hours.      
```

# 5.5.4.  Address Lifetime Expiry
A preferred address becomes deprecated when its preferred lifetime expires. 
An address (and its association with an interface) becomes invalid when its valid lifetime expires.

# 5.6.  Configuration Consistency
It is possible for hosts to obtain address information using both stateless autoconfiguration and DHCPv6 
since both may be enabled at the same time.
An implementation that has stable storage may want to retain addresses in the storage 
when the addresses were acquired using stateless address autoconfiguration.

# 5.7.  Retaining Configured Addresses for Stability
An implementation that has stable storage may want to retain addresses in the storage 
when the addresses were acquired using stateless address autoconfiguration.

Reference
==============================
* [IPv6 Stateless Address Autoconfiguration, RFC4862, September 2007](https://tools.ietf.org/html/rfc4862)
* [slaac-wan.tcl  Autoconf / SLAAC client tests for the WAN side of the router](https://support.qacafe.com/test-summary/ipv6-test-summary/#slaac-wan.tcl)
* [Default Address Selection for Internet Protocol version 6 (IPv6) February 2003](https://tools.ietf.org/html/rfc3484)
* [Default Address Selection for Internet Protocol Version 6 (IPv6) September 2012](https://tools.ietf.org/html/rfc6724)

* [Identifying the preferred IPv6 source address for an adapter](https://stackoverflow.com/questions/7202316/identifying-the-preferred-ipv6-source-address-for-an-adapter)
* [IPv6 Source Address Selection – what, why, how 2012/07/21](http://biplane.com.au/blog/?p=22)

* [dhcpv6 - stateful VS stateless, what is difference between it? Feb 9, 2018](https://networkengineering.stackexchange.com/questions/47829/dhcpv6-stateful-vs-stateless-what-is-difference-between-it)

* [SLAAC (Stateless Address Autoconfiguration) ](https://slideplayer.com/slide/5266411/)
![alt tag](https://images.slideplayer.com/17/5266411/slides/slide_4.jpg)

* [IPv6 學習筆記 001 – 入門筆記  2013-12-19](https://lihan.cc/2013/12/903/)
```
 IPv4 先用 ARP 廣播，然後取得對方 MAC，這樣就搭建好區域網路內的通訊基礎。
 IPv6 採用 SLAAC( Stateless Address Autoconfiguration )，路由器會定期用 multicast發公告，稱為RA (Router Advertisement) ，
 基本上就是Network ID + 閘道器訊息。
 用戶端收到 Network ID，搭配自動產生的 Host ID，形成完整 IPv6，而路由核發出訊息後，就不再管這個位址的實際使用。
```

* []()
![alt tag]()  