# Purpose  
Take notes for Recommended Simple Security Capabilities in Customer Premises Equipment (CPE) for Providing Residential IPv6 Internet Service   

# Table of Contents  

[3. Detailed Recommendations](#3--detailed-recommendations)  
* [3.1.  Stateless Filters](#31--stateless-filters)  
[REC-1:](#rec-1)  
[REC-2:](#rec-2)  
[REC-3:](#rec-3)  
[REC-4:](#rec-4)  
[REC-5:](#rec-5)  
[REC-6:](#rec-6)  
[REC-7:](#rec-7)  
[REC-8:](#rec-8)  
[REC-9:](#rec-9)  

* [3.2. Connection-Free Filters](#32-connection-free-filters)  

[3.2.1. Internet Control and Management](#321-internet-control-and-management)  
[REC-10:](#rec-10)  
[3.2.2. Upper-Layer Transport Protocols](#322-upper-layer-transport-protocols)  
[REC-11:](#rec-11)  
[REC-12:](#rec-12)  
[REC-13:](#rec-13)  
[3.2.3. UDP Filters](#323-udp-filters)  
[REC-14:](#rec-14)  
[REC-15:](#rec-15)  
[REC-16:](#rec-16)  
[REC-17:](#rec-17)  
[REC-18:](#rec-18)  
[REC-19:](#rec-19)  
[REC-20:](#rec-20)  
[3.2.4. IPsec and Internet Key Exchange (IKE)](#324-ipsec-and-internet-key-exchange-ike)  
[REC-21:](#rec-21)  
[REC-22:](#rec-22)  
[REC-23:](#rec-23)  
[REC-24:](#rec-24)  
[REC-25:](#rec-25)  
[REC-26:](#rec-26)  
[3.2.5. Mobility Support in IPv6](#325-mobility-support-in-ipv6)  
[REC-27:](#rec-27)  
[REC-28:](#rec-28)  
[REC-29:](#rec-29)  
[REC-30:](#rec-30)  

* [3.3. Connection-Oriented Filters](#33-connection-oriented-filters)  

[3.3.1. TCP Filters](#331-tcp-filters)  
[REC-31:](#rec-30)  
[REC-32:](#rec-30)  
[REC-33:](#rec-30)  
[REC-34:](#rec-30)  
[REC-35:](#rec-30)  
[REC-36:](#rec-30)  
[REC-37:](#rec-30)  
[3.3.2. SCTP Filters](#332-sctp-filters)  
[3.3.3. DCCP Filters](#333-dccp-filters)  
[3.3.4. Level 3 Multihoming Shim Protocol for IPv6 (Shim6)](#334-level-3-multihoming-shim-protocol-for-ipv6-shim6)  

* [3.4. Passive Listeners](#34-passive-listeners)  
[REC-48:](#rec-48)  
[REC-49:](#rec-49)  

* [3.5. Management Applications](#35-management-applications)  
[REC-50:](#rec-50)  

# 3.  Detailed Recommendations  
## 3.1.  Stateless Filters  
#### REC-1: 
``` 
   Packets bearing multicast source addresses in their outer IPv6 headers 
   MUST NOT be forwarded or transmitted on any interface.
``` 

#### REC-2: 
``` 
   Packets bearing multicast destination addresses in their outer IPv6 headers of equal or narrower scope 
   (see "IPv6 Scoped Address Architecture" [RFC4007]) than the configured scope boundary level of 
   the gateway MUST NOT be forwarded in any direction.  
   The DEFAULT scope boundary level SHOULD be organization-local scope, 
   and it SHOULD be configurable by the network administrator.
``` 

#### REC-3: 
``` 
   Packets bearing source and/or destination addresses forbidden to appear in the outer headers of packets 
   transmitted over the public Internet MUST NOT be forwarded.  
   In particular, site-local addresses are deprecated by [RFC3879], and [RFC5156] 
   explicitly forbids the use of address blocks of types IPv4-Mapped Addresses, 
   IPv4-Compatible Addresses, Documentation Prefix, and 
   Overlay Routable Cryptographic Hash IDentifiers (ORCHID).
``` 

#### REC-4: 
``` 
   Packets bearing deprecated extension headers prior to their first upper-layer-protocol header SHOULD NOT 
   be forwarded or transmitted on any interface.  In particular, all packets with routing extension header 
   type 0 [RFC2460] preceding the first upper-layer-protocol header MUST NOT be forwarded.  
   See [RFC5095] for additional background.
``` 

#### REC-5: 
``` 
   Outbound packets MUST NOT be forwarded if the source address in their outer IPv6 header 
   does not have a unicast prefix configured for use by globally reachable nodes on the interior network.
``` 

#### REC-6: 
``` 
   Inbound packets MUST NOT be forwarded if the source address in their outer IPv6 header 
   has a global unicast prefix assigned for use by globally reachable nodes on the interior network.
``` 

#### REC-7: 
``` 
   By DEFAULT, packets with unique local source and/or destination addresses [RFC4193] 
   SHOULD NOT be forwarded to or from the exterior network.
``` 

#### REC-8: 
``` 
   By DEFAULT, inbound DNS queries received on exterior interfaces MUST NOT be processed by 
   any integrated DNS resolving server.
``` 

#### REC-9: 
``` 
   Inbound DHCPv6 discovery packets [RFC3315] received on exterior interfaces MUST NOT be processed by 
   any integrated DHCPv6 server or relay agent.
``` 

## 3.2. Connection-Free Filters  
### 3.2.1. Internet Control and Management  
``` 
   Recommendations for filtering ICMPv6 messages in firewall devices are described separately in [RFC4890] 
   and apply to residential gateways, with the additional recommendation that incoming 
   "Destination Unreachable" and "Packet Too Big" error messages 
   that don't match any filtering state should be dropped.
``` 

#### REC-10: 
``` 
   IPv6 gateways SHOULD NOT forward ICMPv6 "Destination Unreachable" and 
   "Packet Too Big" messages containing IP headers 
   that do not match generic upper-layer transport state records.
``` 
### 3.2.2. Upper-Layer Transport Protocols  
``` 
   One key aspect of how a packet filter behaves is the way it evaluates the exterior address of 
   an endpoint when applying a filtering rule.
   A gateway is said to have "endpoint-independent filtering" behavior
   when the exterior address is not evaluated when matching a packet with a flow.  
   A gateway is said to have "address-dependent filtering" behavior
   when the exterior address of a packet is required to match the exterior address for its flow.
``` 

#### REC-11:  
``` 
   If application transparency is most important, then a stateful packet filter SHOULD have 
   "endpoint-independent filtering" behavior for generic upper-layer transport protocols.  
   If a more stringent filtering behavior is most important, then a filter SHOULD have 
   "address-dependent filtering" behavior.  
   The filtering behavior MAY be an option configurable by the network administrator, and it
   MAY be independent of the filtering behavior for other protocols.
   Filtering behavior SHOULD be endpoint independent by DEFAULT in gateways intended for provisioning 
   without service-provider management.
``` 

#### REC-12:  
``` 
   Filter state records for generic upper-layer transport protocols MUST NOT 
   be deleted or recycled until an idle timer not less than two minutes has expired 
   without having forwarded a packet matching the state in some configurable amount of time.  
   By DEFAULT, the idle timer for such state records is five minutes.
``` 

#### REC-13:  
``` 
   Residential IPv6 gateways SHOULD provide a convenient means to update their firmware securely, 
   for the installation of security patches and other manufacturer-recommended changes.
``` 

### 3.2.3. UDP Filters  
``` 
   An interior endpoint initiates a UDP flow through a stateful packet filter 
   by sending a packet to an exterior address.  
   The filter allocates (or reuses) a filter state record for the duration of the flow.  
   The state record defines the interior and exterior IP addresses and ports used 
   between all packets in the flow.

   State records for UDP flows remain active while they are in use and are only abandoned 
   after an idle period of some time.
``` 

#### REC-14:  
``` 
   A state record for a UDP flow where both source and destination ports are outside the well-known 
   port range (ports 0-1023) MUST NOT expire in less than two minutes of idle time.
   The value of the UDP state record idle timer MAY be configurable.
   The DEFAULT is five minutes.
``` 

#### REC-15:  
``` 
   A state record for a UDP flow where one or both of the source and destination ports 
   are in the well-known port range (ports 0-1023) MAY expire after a period of idle time 
   shorter than two minutes to facilitate the operation of the IANA-registered service 
   assigned to the port in question.
``` 

#### REC-16: 
``` 
   A state record for a UDP flow MUST be refreshed when a packet
   is forwarded from the interior to the exterior, and it MAY be
   refreshed when a packet is forwarded in the reverse direction.
``` 

#### REC-17:  
``` 
   If application transparency is most important, then a stateful packet filter SHOULD 
   have "endpoint-independent filtering" behavior for UDP.  
   
   If a more stringent filtering behavior is most important, then a filter SHOULD 
   have "address-dependent filtering" behavior.  
   
   The filtering behavior MAY be an option configurable by the network administrator, 
   and it MAY be independent of the filtering behavior for TCP and other protocols.  
   
   Filtering behavior SHOULD be endpoint independent by DEFAULT in gateways intended for provisioning
   without service-provider management.
``` 

#### REC-18:  
``` 
   If a gateway forwards a UDP flow, it MUST also forward ICMPv6 "Destination Unreachable" and 
   "Packet Too Big" messages containing UDP headers that match the flow state record.
``` 

### REC-19: 
``` 
   Receipt of any sort of ICMPv6 message MUST NOT terminate the state record for a UDP flow.
``` 

### REC-20: 
``` 
   UDP-Lite flows [RFC3828] SHOULD be handled in the same way as
   UDP flows, except that the upper-layer transport protocol identifier
   for UDP-Lite is not the same as UDP; therefore, UDP packets MUST NOT
   match UDP-Lite state records, and vice versa.
``` 
### 3.2.4. IPsec and Internet Key Exchange (IKE)
#### REC-21: 
``` 
   In their DEFAULT operating mode, IPv6 gateways MUST NOT
   prohibit the forwarding of packets, to and from legitimate node
   addresses, with destination extension headers of type "Authentication
   Header (AH)" [RFC4302] in their outer IP extension header chain.
``` 
#### REC-22: 
``` 
   In their DEFAULT operating mode, IPv6 gateways MUST NOT
   prohibit the forwarding of packets, to and from legitimate node
   addresses, with an upper-layer protocol of type "Encapsulating
   Security Payload (ESP)" [RFC4303] in their outer IP extension header
   chain.
``` 

#### REC-23:  
``` 
   If a gateway forwards an ESP flow, it MUST also forward (in the reverse direction) ICMPv6 
   "Destination Unreachable" and "Packet Too Big" messages containing ESP headers 
   that match the flow state record.
``` 

#### REC-24: 
``` 
   In their DEFAULT operating mode, IPv6 gateways MUST NOT
   prohibit the forwarding of any UDP packets, to and from legitimate
   node addresses, with a destination port of 500, i.e., the port
   reserved by IANA for the Internet Key Exchange (IKE) protocol
   [RFC5996].
``` 

#### REC-25: 
``` 
   In all operating modes, IPv6 gateways SHOULD use filter state
   records for Encapsulating Security Payload (ESP) [RFC4303] that are
   indexable by a 3-tuple comprising the interior node address, the
   exterior node address, and the ESP protocol identifier.  In
   particular, the IPv4/NAT method of indexing state records also by the
   security parameters index (SPI) SHOULD NOT be used.  Likewise, any
   mechanism that depends on detection of Internet Key Exchange (IKE)
   [RFC5996] initiations SHOULD NOT be used.
``` 

#### REC-26: 
``` 
   In their DEFAULT operating mode, IPv6 gateways MUST NOT
   prohibit the forwarding of packets, to and from legitimate node
   addresses, with destination extension headers of type "Host Identity
   Protocol (HIP)" [RFC5201] in their outer IP extension header chain.   
``` 

### 3.2.5. Mobility Support in IPv6  
#### REC-27: 
``` 
   The state records for flows initiated by outbound packets
   that bear a Home Address destination option [RFC3775] are
   distinguished by the addition of the home address of the flow as well
   as the interior care-of address.  IPv6 gateways MUST NOT prohibit the
   forwarding of any inbound packets bearing type 2 routing headers,
   which otherwise match a flow state record, and where A) the address
   in the destination field of the IPv6 header matches the interior
   care-of address of the flow, and B) the Home Address field in the
   Type 2 Routing Header matches the home address of the flow.
``` 

#### REC-28: 
``` 
   Valid sequences of Mobility Header [RFC3775] packets MUST be
   forwarded for all outbound and explicitly permitted inbound Mobility
   Header flows.
``` 

#### REC-29: 
``` 
   If a gateway forwards a Mobility Header [RFC3775] flow, then
   it MUST also forward, in both directions, the IPv4 and IPv6 packets
   that are encapsulated in IPv6 associated with the tunnel between the
   home agent and the correspondent node.
``` 

#### REC-30: 
``` 
   If a gateway forwards a Mobility Header [RFC3775] flow, then
   it MUST also forward (in the reverse direction) ICMPv6 "Destination
   Unreachable" and "Packet Too Big" messages containing any headers
   that match the associated flow state records.
``` 
## 3.3. Connection-Oriented Filters  
### 3.3.1. TCP Filters  
#### REC-31: 
``` 
   All valid sequences of TCP packets (defined in [RFC0793])
   MUST be forwarded for outbound flows and explicitly permitted inbound
   flows.  In particular, both the normal TCP 3-way handshake mode of
   operation and the simultaneous-open mode of operation MUST be
   supported.

   It is possible to reconstruct enough of the state of a TCP flow to
   allow forwarding between an interior and exterior node, even when the
   filter starts operating after TCP enters the established state.  In
   this case, because the filter has not seen the TCP window-scale
   option, it is not possible for the filter to enforce the TCP window
   invariant by dropping out-of-window segments.
``` 

#### REC-32: 
``` 
   The TCP window invariant MUST NOT be enforced on flows for
   which the filter did not detect whether the window-scale option (see
   [RFC1323]) was sent in the 3-way handshake or simultaneous-open.

   A stateful filter can allow an existing state record to be reused by
   an externally initiated flow if its security policy permits.  Several
   different policies are possible, as described in [RFC4787] and
   extended in [RFC5382].
``` 

#### REC-33: 
``` 
   If application transparency is most important, then a
   stateful packet filter SHOULD have "endpoint-independent filtering"
   behavior for TCP.  If a more stringent filtering behavior is most
   important, then a filter SHOULD have "address-dependent filtering"
``` 

#### REC-34: 
``` 
   By DEFAULT, a gateway MUST respond with an ICMPv6
   "Destination Unreachable" error code 1 (Communication with
   destination administratively prohibited) to any unsolicited inbound
   SYN packet after waiting at least 6 seconds without first forwarding
   the associated outbound SYN or SYN/ACK from the interior peer.
``` 

#### REC-35: 
``` 
   If a gateway cannot determine whether the endpoints of a TCP
   flow are active, then it MAY abandon the state record if it has been
   idle for some time.  In such cases, the value of the "established
   flow idle-timeout" MUST NOT be less than two hours four minutes, as
   discussed in [RFC5382].  The value of the "transitory flow idle-
   timeout" MUST NOT be less than four minutes.  The value of the idle-
   timeouts MAY be configurable by the network administrator.
``` 

#### REC-36: 
``` 
   If a gateway forwards a TCP flow, it MUST also forward ICMPv6
   "Destination Unreachable" and "Packet Too Big" messages containing
   TCP headers that match the flow state record.
``` 

#### REC-37: 
``` 
   Receipt of any sort of ICMPv6 message MUST NOT terminate the
   state record for a TCP flow.
``` 
### 3.3.2. SCTP Filters  
``` 

   REC-38: All valid sequences of SCTP packets (defined in [RFC4960])
   MUST be forwarded for outbound associations and explicitly permitted
   inbound associations.  In particular, both the normal SCTP
   association establishment and the simultaneous-open mode of operation
   MUST be supported.

   REC-39: By DEFAULT, a gateway MUST respond with an ICMPv6
   "Destination Unreachable" error code 1 (Communication with
   destination administratively prohibited), to any unsolicited inbound
   INIT packet after waiting at least 6 seconds without first forwarding
   the associated outbound INIT from the interior peer.

   REC-40: If a gateway cannot determine whether the endpoints of an
   SCTP association are active, then it MAY abandon the state record if
   it has been idle for some time.  In such cases, the value of the
   "established association idle-timeout" MUST NOT be less than
   two hours four minutes.  The value of the "transitory association
   idle-timeout" MUST NOT be less than four minutes.  The value of the
   idle-timeouts MAY be configurable by the network administrator.

   REC-41: If a gateway forwards an SCTP association, it MUST also
   forward ICMPv6 "Destination Unreachable" and "Packet Too Big"
   messages containing SCTP headers that match the association state
   record.

   REC-42: Receipt of any sort of ICMPv6 message MUST NOT terminate the
   state record for an SCTP association.
``` 
### 3.3.3. DCCP Filters  
``` 
   REC-43: All valid sequences of DCCP packets (defined in [RFC4340])
   MUST be forwarded for all flows to exterior servers, and for any
   flows to interior servers that have explicitly permitted service
   codes.

   REC-44: A gateway MAY abandon a DCCP state record if it has been idle
   for some time.  In such cases, the value of the "open flow idle-
   timeout" MUST NOT be less than two hours four minutes.  The value of
   the "transitory flow idle-timeout" MUST NOT be less than eight
   minutes.  The value of the idle-timeouts MAY be configurable by the
   network administrator.

   REC-45: If an Internet gateway forwards a DCCP flow, it MUST also
   forward ICMPv6 "Destination Unreachable" and "Packet Too Big"
   messages containing DCCP headers that match the flow state record.

   REC-46: Receipt of any sort of ICMPv6 message MUST NOT terminate the
   state record for a DCCP flow.
``` 
### 3.3.4. Level 3 Multihoming Shim Protocol for IPv6 (Shim6)  
#### REC-47: 
``` 
   Valid sequences of packets bearing Shim6 payload extension
   headers in their outer IP extension header chains MUST be forwarded
   for all outbound and explicitly permitted flows.  The content of the
   Shim6 payload extension header MAY be ignored for the purpose of
   state tracking.
``` 

### 3.4. Passive Listeners  
#### REC-48: 
``` 
   Internet gateways with IPv6 simple security capabilities SHOULD implement 
   a protocol to permit applications to solicit inbound traffic without 
   advance knowledge of the addresses of exterior nodes with which they expect to communicate.
``` 
#### REC-49: 
``` 
   Internet gateways with IPv6 simple security capabilities MUST provide an easily selected 
   configuration option that permits a "transparent mode" of operation that 
   forwards all unsolicited flows regardless of forwarding direction, i.e., 
   not to use the IPv6 simple security capabilities of the gateway.  
   
   The transparent mode of operation MAY be the default configuration.
``` 
### 3.5. Management Applications  
#### REC-50: 
``` 
   By DEFAULT, subscriber-managed residential gateways MUST NOT
   offer management application services to the exterior network.
``` 

# Troubleshooting


# Reference
* [RFC6092 - IPv6 Simple Security 10 septembre 2013](http://computer-outlines.over-blog.com/article-ipv6-security-7-rfc6092-and-rfc4890-with-full-details-120085093.html)  
![alt tag](http://a52.idata.over-blog.com/500x309/2/45/56/50/SEC/S7/S7b.gif)  

* [RFC6092 - Recommended Simple Security Capabilities in Customer Premises Equipment (CPE) for Providing Residential IPv6 Internet Service](https://tools.ietf.org/html/rfc6092)  
* []()  


* []()  
![alt tag]()  

# h1 size

## h2 size

### h3 size

#### h4 size

##### h5 size

*strong*strong  
**strong**strong  

> quote  
> quote

- [ ] checklist1
- [x] checklist2

* 1
* 2
* 3

- 1
- 2
- 3
