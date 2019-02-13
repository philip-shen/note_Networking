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
   
# 4.  Terminology
# 4.1.  IPv6 Terminology
```
   address                   An IP-layer identifier for an interface or a set of interfaces.

   GUA                       Global unicast address (see [RFC4291]).

   host                      Any node that is not a router.

   IP                        Internet Protocol Version 6 (IPv6).
   
   interface                 A node's attachment to a link.

   link                      A communication facility or medium over which nodes can communicate at the link layer, 
                             i.e., the layer immediately below IP.  Examples are Ethernet

   link-layer identifier     A link-layer identifier for an interface -- for example, IEEE 802 addresses for Ethernet
                              or Token Ring network interfaces.

   link-local address        An IPv6 address having a link-only scope, indicated by having the prefix (fe80::/10),
                             that can be used to reach neighboring nodes attached to the same link.
                             
   multicast address         An identifier for a set of interfaces (typically belonging to different nodes).
   
   neighbor                  A node attached to the same link.
   node                      A device that implements IP.
   packet
   
   prefix                    The initial bits of an address, or a set of IP addresses that share the same initial bits.

   prefix length             The number of bits in a prefix.

   router                    A node that forwards IP packets not explicitly addressed to itself.

   ULA                       Unique local address (see [RFC4193]).

   unicast address           An identifier for a single interface.
```
# 4.2.  DHCP Terminology
```
   appropriate to the link   An address is "appropriate to the link" when the address is consistent with the
                             DHCP server's knowledge of the network topology, prefix assignment, and address assignment policies.

   binding                   A binding (or client binding) is a group of server data records containing the
                             information the server has about the addresses or delegated prefixes in an Identity Association (IA)
                              or configurationinformation explicitly assigned to the client.
                             Configuration information that has been returned to a client through a policy,
                             such as the information returned to all clients on the same link, does not require a binding.
                             A binding containing information about an IA is indexed by the tuple <DUID, IA-type, IAID>                             
                             (where IA-type is the type of lease in the IA -- for example, temporary).  
                             A binding containing  configuration information for a client is indexed by <DUID>.  See below for
                             definitions of DUID, IA, and IAID.

   configuration parameter   An element of the configuration information set on the server and delivered to the                             
                             client using DHCP.  Such parameters may be used to carry information to be used by a                             
                             node to configure its network subsystem and enable communication on a link or internetwork, for example.

   container option          An option that encapsulates other options (for example, the IA_NA option (see Section 21.4) 
                             may contain IA Address options (see Section 21.6)).

   delegating router         The router that acts as a DHCP server and responds to requests for delegated
                             prefixes.  This document primarily uses the term "DHCP server" or "server" when
                             discussing the "delegating router" functionality of prefix delegation (see Section 1).

   DHCP                      Dynamic Host Configuration Protocol for IPv6.
   DHCP client                  
   
   DHCP domain               A set of links managed by DHCP and operated by a single administrative entity.                             

   DHCP relay agent          Also referred to as "relay agent".  A node that acts as an intermediary to deliver                             
                             DHCP messages between clients and servers.
                             In certain configurations, there may be more than one relay agent between clients
                             and servers, so a relay agent may send DHCP messages to another relay agent.

   DHCP server               Also referred to as "server".  A node that responds to requests from clients.
                             
   DUID                      A DHCP Unique Identifier for a DHCP participant.  
                             Each DHCP client and server has exactly one DUID.  See Section 11 for details of the ways 
                             in which a DUID may be constructed.

   encapsulated option       A DHCP option that is usually only contained in another option.  
                             For example, the IA Address option is contained in IA_NA or IA_TA options (see Section 21.5).  See
                             Section 9 of [RFC7227] for a more complete definition.

   IA                        Identity Association: a collection of leases assigned to a client.
                             Each IA has an associated IAID (see below).
                             A client may have more than one IA assigned to it --                             
                             for example, one for each of its interfaces.  Each IA holds one type of lease;                             
                             for example, an identity association for temporary addresses (IA_TA) holds temporary addresses, 
                             and an identity association for prefix delegation (IA_PD) holds delegated prefixes.  
                             Throughout this document, "IA" is used to refer to an
                             identity association without identifyingthe type of a lease in the IA.  
                             At the time of writing this document, there are three
                             IA types defined: IA_NA, IA_TA, and IA_PD. New IA types may be defined in the future.

   IA option(s)              At the time of writing this document, one or more IA_NA, IA_TA, and/or IA_PD options.                             
                             New IA types may be defined in the future.

   IAID                      Identity Association Identifier: an identifier for an IA, chosen by the client.
                             Each IA has an IAID, which is chosen to be unique among IAIDs for IAs of a specific type 
                             that belong to that client.
                             
   IA_NA                     Identity Association for Non-temporary Addresses: 
                             an IA that carries assigned addresses that are not temporary addresses (see "IA_TA").  
                             See Section 21.4 for details on the IA_NA option.
                             
   IA_PD                     Identity Association for Prefix Delegation:
                             an IA that carries delegated prefixes.  See Section 21.21 for details on the IA_PD option.                             
                             
   IA_TA                     Identity Association for Temporary Addresses: an IA that carries temporary addresses (see [RFC4941]).
                             See Section 21.5 for details on the IA_TA option.
                             
   lease                     A contract by which the server grants the use of an address or delegated prefix to                             
                             the client for a specified period of time.

   message                   A unit of data carried as the payload of a UDP datagram, exchanged among DHCP servers,                             
                             relay agents, and clients.

   Reconfigure key           A key supplied to a client by a server.  Used to provide security for Reconfigure                             
                             messages (see Section 7.3 for the list of available message types).

   relaying                  A DHCP relay agent relays DHCP messages between DHCP participants.

   requesting router         The router that acts as a DHCP client and is requesting prefix(es) to be assigned.
   
   retransmission            Another attempt to send the same DHCP message by a client or server, as a result                             
                             of not receiving a valid response to the previously sent messages.
                             The retransmitted message is typically modified prior to sending, as required by the DHCP specifications.                            
                             
   RKAP                      The Reconfiguration Key Authentication Protocol (see Section 20.4).
                                                          
   singleton option          An option that is allowed to appear only once as a top-level option or at any encapsulation level. 
                             Most options are singletons.
                             
   T1                        The time interval after which the client is expected to contact the server that did the                             
                             assignment to extend (renew) the lifetimes of the addresses assigned (via IA_NA option(s))                             
                             and/or prefixes delegated (via IA_PD option(s)) to the client.
                             T1 is expressed as an absolute value in messages (in seconds), is conveyed within IA                             
                             containers (currently the IA_NA and IA_PD options), and is interpreted as a time                             
                             interval since the packet's reception.  The value stored in the T1 field in IA options                             
                             is referred to as the T1 value.  The actual time when the timer expires is referred to as the T1 time.                          
                             
   T2                        The time interval after which the client is expected to contact any available server to                             
                             extend (rebind) the lifetimes of the addresses assigned (via IA_NA option(s))
                             and/or prefixes delegated (via IA_PD option(s)) to the client.  
                             T2 is expressed as an absolute value in messages (in seconds), is conveyed within IA containers
                             (currently the IA_NA and IA_PD options), and is interpreted as a time interval since                             
                             the packet's reception.  The value stored in the T2 field in IA options is referred
                             to as the T2 value.  The actual time when the timer expires is referred to as the T2 time.
                             
   top-level option          An option conveyed in a DHCP message directly, i.e., not encapsulated in any                             
                             other option, as described in Section 9 of [RFC7227].

   transaction ID            An opaque value used to match responses with replies initiated by either a client or a server.
```
# 5.  Client/Server Exchanges
Clients and servers exchange DHCP messages using UDP (see [RFC768] and BCP 145 [RFC8085]).  The client uses a link-local address or addresses determined through other mechanisms for transmitting and receiving DHCP messages.

A DHCP client sends most messages using a reserved, link-scoped multicast destination address so that the client need not be configured with the address or addresses of DHCP servers.

To allow a DHCP client to send a message to a DHCP server that is not attached to the same link, a DHCP relay agent on the client's link will relay messages between the client and server.  The operation of the relay agent is transparent to the client.

# 5.1.  Client/Server Exchanges Involving Two Messages
When a DHCP client does not need to have a DHCP server assign IP addresses or delegated prefixes to it, the client can obtain other configuration information such as a list of available DNS servers [RFC3646] or NTP servers [RFC5908] through a single message and reply exchange with a DHCP server.

A client may also request the server to expedite address assignment and/or prefix delegation by using a two-message exchange instead of  the normal four-message exchange as discussed in the next section.
Expedited assignment can be requested by the client, and servers may or may not honor the request (see Sections 18.3.1 and 21.14 for more details and why servers may not honor this request).
Clients may request this expedited service in environments where it is likely that there is only one server available on a link and no expectation that a second server would become available, or when completing the configuration process as quickly as possible is a priority.

To request the expedited two-message exchange, the client sends a Solicit message to the All_DHCP_Relay_Agents_and_Servers multicast address requesting the assignment of addresses and/or delegated prefixes and other configuration information.
This message includes an indication (the Rapid Commit option; see Section 21.14) that the client is willing to accept an immediate Reply message from the server.
The server that is willing to commit the assignment of addresses and/or delegated prefixes to the client immediately responds with a Reply message.  
The configuration information and the addresses and/or delegated prefixes in the Reply message are then immediately available for use by the client.

Each address or delegated prefix assigned to the client has associated preferred and valid lifetimes specified by the server.  To request an extension of the lifetimes assigned to an address or delegated prefix, the client sends a Renew message to the server.

See Section 18 for descriptions of additional two-message exchanges between the client and server.

# 5.2.  Client/Server Exchanges Involving Four Messages
To request the assignment of one or more addresses and/or delegated prefixes, a client first locates a DHCP server and then requests the assignment of addresses and/or delegated prefixes and other configuration information from the server.  
The client sends a  Solicit message to the All_DHCP_Relay_Agents_and_Servers multicast address to find available DHCP servers.
Any server that can meet the client's requirements responds with an Advertise message.  The client then chooses one of the servers and sends a Request message to the server asking for confirmed assignment of addresses and/or delegated prefixes and other configuration information.
The server responds with a Reply message that contains the confirmed addresses, delegated prefixes, and configuration.

As described in the previous section, the client can request an extension of the lifetimes assigned to addresses or delegated prefixes (this is a two-message exchange).

# 5.3.  Server/Client Exchanges 
A server that has previously communicated with a client and negotiated for the client to listen for Reconfigure messages may send the client a Reconfigure message to initiate the client to update its configuration by sending an Information-request, Renew, or Rebind message.  The client then performs the two-message exchange as described earlier.
This can be used to expedite configuration changes to a client, such as the need to renumber a network (see [RFC6879]).

# 6.  Operational Models 
The described models are not mutually exclusive and are sometimes used together.  For example, a device may start in stateful mode to obtain an address and, at a later time when an application is started, request additional parameters using stateless mode.

DHCP may be extended to support additional stateful services that may interact with one or more of the models described below.

# 6.1.  Stateless DHCP
Stateless DHCP [RFC3736] is used when DHCP is not used for obtaining a lease but a node (DHCP client) desires one or more DHCP "other configuration" parameters, such as a list of DNS recursive name servers or DNS domain search lists [RFC3646].  
Stateless DHCP may be used when a node initially boots or at any time the software on the node requires some missing or expired configuration information that is available via DHCP.

This is the simplest and most basic operation for DHCP and requires a client (and a server) to support only two messages --
 Information-request and Reply.
 
# 6.2.  DHCP for Non-temporary Address Assignment
This model of operation was the original motivation for DHCP.  
It is appropriate for situations where stateless address autoconfiguration alone is insufficient or impractical, e.g., because of network policy, additional requirements such as dynamic updates to the DNS, or client-specific requirements.

The model of operation for non-temporary address assignment is as follows.  
The server is provided with prefixes from which it may allocate addresses to clients, as well as any related network topology information as to which prefixes are present on which links.
A client requests a non-temporary address to be assigned by the server.  
The server allocates an address or addresses appropriate for the link on which the client is connected.  
The server returns the allocated address or addresses to the client.

Each address has associated preferred and valid lifetimes, which constitute an agreement about the length of time over which the client is allowed to use the address.  
A client can request an extension of the lifetimes on an address and is required to terminate the use of an address if the valid lifetime of the address expires.

Clients can also request more than one address or set of addresses (see Sections 6.6 and 12).

# 6.3.  DHCP for Prefix Delegation
It is appropriate for situations in which the delegating router 
(1) does not have knowledge about the topology of the networks to which the requesting router is attached and 
(2) does not require other information aside from theidentity of the requesting router to choose a prefix for delegation.
This mechanism is appropriate for use by an ISP to delegate a prefix to a subscriber, where the delegated prefix would possibly be subnetted and assigned to the links within the subscriber's network. [RFC7084] and [RFC7368] describe such use in detail.

The design of this prefix delegation mechanism meets the requirements for prefix delegation in [RFC3769](https://tools.ietf.org/html/rfc3769).

While [RFC3633] assumes that the DHCP client is a router (hence the use of "requesting router") and that the DHCP server is a router(hence the use of "delegating router"), DHCP prefix delegation itself does not require that the client forward IP packets not addressed to itself and thus does not require that the client (or server) be a router as defined in [RFC8200].

The model of operation for prefix delegation is as follows.  
A server is provisioned with prefixes to be delegated to clients.  
A client requests prefix(es) from the server, as described in Section 18.  
The server chooses prefix(es) for delegation and responds with prefix(es) to the client.  
The client is then responsible for the delegated prefix(es).  
For example, the client might assign a subnet from a delegated prefix to one of its interfaces and begin sending Router Advertisements for the prefix on that link.

Each prefix has an associated preferred lifetime and valid lifetime, which constitute an agreement about the length of time over which the client is allowed to use the prefix.  
A client can request an extension of the lifetimes on a delegated prefix and is required to terminate the use of a delegated prefix if the valid lifetime of the prefix expires.

Figure 1 illustrates a network architecture in which prefix delegation could be used.
```

                      ______________________         \
                     /                      \         \
                    |    ISP core network    |         \
                     \__________ ___________/           |
                                |                       |
                        +-------+-------+               |
                        |  Aggregation  |               | ISP
                        |    device     |               | network
                        |  (delegating  |               |
                        |    router)    |               |
                        +-------+-------+               |
                                |                      /
                                |Network link to      /
                                |subscriber premises /
                                |
                         +------+------+             \
                         |     CPE     |              \
                         | (requesting |               \
                         |   router)   |                |
                         +----+---+----+                |
                              |   |                     | Subscriber
       ---+-------------+-----+   +-----+------         | network
          |             |               |               |
     +----+-----+ +-----+----+     +----+-----+         |
     |Subscriber| |Subscriber|     |Subscriber|        /
     |    PC    | |    PC    |     |    PC    |       /
     +----------+ +----------+     +----------+      /

                    Figure 1: Prefix Delegation Network
```
In this example, the server (delegating router) is configured with a set of prefixes to be used for assignment to customers at the time of each customer's first connection to the ISP service.  
The prefix delegation process begins when the client (requesting router) requests configuration information through DHCP.  The DHCP messages from the client are received by the server in the aggregation device.
When the server receives the request, it selects an available prefix or prefixes for delegation to the client.  The server then returns the prefix or prefixes to the client.

The client subnets the delegated prefix and assigns the longer prefixes to links in the subscriber's network.  
In a typical scenario based on the network shown in Figure 1, the client subnets a single delegated /48 prefix into /64 prefixes and assigns one /64 prefix to  each of the links in the subscriber network.

The client may, in turn, provide DHCP service to nodes attached to the internal network.  For example, the client may obtain the addresses of DNS and NTP servers from the ISP server and then pass that configuration information on to the subscriber hosts through a DHCP server in the client (requesting router).

If the client uses a delegated prefix to configure addresses on interfaces on itself or other nodes behind it, the preferred and valid lifetimes of those addresses MUST be no longer than the remaining preferred and valid lifetimes, respectively, for the delegated prefix at any time.
   
# 6.4.  DHCP for Customer Edge Routers
The DHCP requirements and network architecture for Customer Edge Routers are described in [RFC7084].(https://tools.ietf.org/html/rfc7084)
This model of operation combines address assignment (see Section 6.2) and prefix delegation (see Section 6.3).

# 6.5.  DHCP for Temporary Addresses
Temporary addresses were originally introduced to avoid privacy concerns with stateless address autoconfiguration, which based 64 bits of the address on the EUI-64 (see [RFC4941].  They were added to DHCP to provide complementary support when stateful address assignment is used.

Temporary address assignment works mostly like non-temporary address assignment (see Section 6.2); however, these addresses are generally intended to be used for a short period of time and not to have their lifetimes extended, though they can be if required.

# 6.6.  Multiple Addresses and Prefixes
DHCP allows a client to receive multiple addresses.  During typical operation, a client sends one instance of an IA_NA option and the server assigns at most one address from each prefix assigned to the link to which the client is attached.
In particular, the server can be configured to serve addresses out of multiple prefixes for a given link.  This is useful in cases such as when a network renumbering event is in progress.  
In a typical deployment, the server will grant one address for each IA_NA option (see Section 21.4).

A client can explicitly request multiple addresses by sending multiple IA_NA options (and/or IA_TA options; see Section 21.5).  
A client can send multiple IA_NA (and/or IA_TA) options in its initial transmissions.  
lternatively, it can send an extra Request message with additional new IA_NA (and/or IA_TA) options (or include them in a Renew message).

The same principle also applies to prefix delegation.  In principle, DHCP allows a client to request new prefixes to be delegated by sending additional IA_PD options (see Section 21.21).

For more information on how the server distinguishes between IA  option instances, see Section 12.

# 7.  DHCP Constants
# 7.1.  Multicast Addresses
DHCP makes use of the following multicast addresses:

   All_DHCP_Relay_Agents_and_Servers (ff02::1:2)
      A link-scoped multicast address used by a client to communicate
      with neighboring (i.e., on-link) relay agents and servers.  All
      servers and relay agents are members of this multicast group.

   All_DHCP_Servers (ff05::1:3)
      A site-scoped multicast address used by a relay agent to
      communicate with servers, either because the relay agent wants to
      send messages to all servers or because it does not know the
      unicast addresses of the servers.  Note that in order for a relay
      agent to use this address, it must have an address of sufficient
      scope to be reachable by the servers. 

# 7.2.  UDP Ports
Clients listen for DHCP messages on UDP port 546.  Servers and relay agents listen for DHCP messages on UDP port 547.

# 7.3.  DHCP Message Types
The formats of these messages are provided in Sections 8 and 9.  Additional message types have been defined and may be defined in the future; see <https://www.iana.org/assignments/dhcpv6-parameters>.

```
   SOLICIT (1)               A client sends a Solicit message to locate servers.                             

   ADVERTISE (2)             A server sends an Advertise message to indicate that it is available for DHCP                             
                             service, in response to a Solicit message received from a client.                             

   REQUEST (3)               A client sends a Request message to request configuration parameters, including                             
                             addresses and/or delegated prefixes, from a specific server.                             

   CONFIRM (4)               A client sends a Confirm message to any available server to determine whether the                             
                             addresses it was assigned are still appropriate to the link to which the client is connected.                            
                             
   RENEW (5)                 A client sends a Renew message to the server that originally provided the client's leases and                             
                             configuration parameters to extend the lifetimes on the                             
                             leases assigned to the client and to update other configuration parameters.                             
                             
   REBIND (6)                A client sends a Rebind message to any available server to extend the lifetimes on                             
                             the leases assigned to the client and to update other configuration parameters; this                             
                             message is sent after a client receives no response to a Renew message.                             

   REPLY (7)                 A server sends a Reply message containing assigned leases and configuration                             
                             parameters in response to a Solicit, Request, Renew, or Rebind message received from a client.                             
                             A server sends a Reply message containing configuration parameters in response to an Information-request                        
                             message.  A server sends a Reply message in response to a Confirm message confirming or
                             denying that the addresses assigned to the client are appropriate to the link to which the client is connected.
                             A server sends a Reply message to acknowledge receipt of a Release or Decline message.                             

   RELEASE (8)               A client sends a Release message to the server that assigned leases to the client                             
                             to indicate that the client will no longer use one or more of the assigned leases.                             

   DECLINE (9)               A client sends a Decline message to a server to indicate that the client has                             
                             determined that one or more addresses assigned by the server are already in use                             
                             on the link to which the client is connected.                             

   RECONFIGURE (10)          A server sends a Reconfigure message to a client to inform the client that the server                             
                             has new or updated configuration parameters and that the client is to initiate a                             
                             Renew/Reply, Rebind/Reply, or Information-request/Reply transaction with                             
                             the server in order to receive the updated information.                             

   INFORMATION-REQUEST (11)  A client sends an Information-request message to a server to request                             
                             configuration parameters without the assignment of any leases to the client.
                             
   RELAY-FORW (12)           A relay agent sends a Relay-forward message to relay messages to servers, either                             
                             directly or through another relay agent.
                             The received message -- either a client message or a Relay-forward message from                             
                             another relay agent -- is encapsulated in an option in the Relay-forward message.                             

   RELAY-REPL (13)           A server sends a Relay-reply message to a relay agent containing a message that the                             
                             relay agent delivers to a client.  The Relay-reply message may be relayed by other                             
                             relay agents for delivery to the destination relay agent.                             

                             The server encapsulates the client message as an option in the Relay-reply message,                             
                             which the relay agent extracts and relays to the client.                             
```
![alt tag](https://www.cisco.com/c/dam/en/us/products/collateral/ios-nx-os-software/enterprise-ipv6-solution/whitepaper_c11-689821.doc/_jcr_content/renditions/whitepaper_c11-689821-12.jpg)

#







#


Reference
==============================
* [Dynamic Host Configuration Protocol for IPv6 (DHCPv6), RFC8415, November 2018](https://tools.ietf.org/html/rfc8415)
* [Requirements for IPv6 Prefix Delegation, RFC 3769, June 2004](https://tools.ietf.org/html/rfc3769)
* [Basic Requirements for IPv6 Customer Edge Routers, RFC 7084, November 2013](https://tools.ietf.org/html/rfc7084)

* []()
![alt tag]()
