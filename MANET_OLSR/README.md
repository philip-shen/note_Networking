# Purpose
Take note of OLSRv1

# Table of Contents
   [1.  Introduction  . . . . . . . . . . . . . . . . . . . . . . . .](#1-introduction)  
       1.1. OLSR Terminology.  . . . . . . . . . . . . . . . . . . .   5
       1.2. Applicability. . . . . . . . . . . . . . . . . . . . . .   7
       1.3. Protocol Overview  . . . . . . . . . . . . . . . . . . .   8
       1.4. Multipoint Relays  . . . . . . . . . . . . . . . . . . .   9
   2.  Protocol Functioning  . . . . . . . . . . . . . . . . . . . .   9
       2.1. Core Functioning   . . . . . . . . . . . . . . . . . . .  10
       2.2. Auxiliary Functioning  . . . . . . . . . . . . . . . . .  12
   3.  Packet Format and Forwarding  . . . . . . . . . . . . . . . .  13
       3.1. Protocol and Port Number.  . . . . . . . . . . . . . . .  13
       3.2. Main Address   . . . . . . . . . . . . . . . . . . . . .  13
       3.3. Packet Format  . . . . . . . . . . . . . . . . . . . . .  14
            3.3.1. Packet Header . . . . . . . . . . . . . . . . . .  14
            3.3.2. Message Header  . . . . . . . . . . . . . . . . .  15
       3.4. Packet Processing and Message Flooding . . . . . . . . .  16
            3.4.1. Default Forwarding Algorithm. . . . . . . . . . .  18
            3.4.2. Considerations on Processing and Forwarding . . .  20
       3.5. Message Emission and Jitter. . . . . . . . . . . . . . .  21
   4.  Information Repositories  . . . . . . . . . . . . . . . . . .  22
       4.1. Multiple Interface Association Information Base  . . . .  22
       4.2. Link sensing: Local Link Information Base. . . . . . . .  22
            4.2.1. Link Set. . . . . . . . . . . . . . . . . . . . .  22
       4.3. Neighbor Detection: Neighborhood Information Base. . . .  23
            4.3.1. Neighbor Set. . . . . . . . . . . . . . . . . . .  23
            4.3.2. 2-hop Neighbor Set. . . . . . . . . . . . . . . .  23
            4.3.3. MPR Set . . . . . . . . . . . . . . . . . . . . .  23
            4.3.4. MPR Selector Set. . . . . . . . . . . . . . . . .  23
       4.4. Topology Information Base  . . . . . . . . . . . . . . .  24
   5.  Main Addresses and Multiple Interfaces  . . . . . . . . . . .  24
       5.1. MID Message Format . . . . . . . . . . . . . . . . . . .  25
       5.2. MID Message Generation . . . . . . . . . . . . . . . . .  25
       5.3. MID Message Forwarding . . . . . . . . . . . . . . . . .  26
       5.4. MID Message Processing . . . . . . . . . . . . . . . . .  26
       5.5. Resolving a Main Address from an Interface Address . . .  27
   6.  HELLO Message Format and Generation . . . . . . . . . . . . .  27
       6.1. HELLO Message Format . . . . . . . . . . . . . . . . . .  27
            6.1.1. Link Code as Link Type and Neighbor Type. . . . .  29
       6.2. HELLO Message Generation . . . . . . . . . . . . . . . .  30
       6.3. HELLO Message Forwarding . . . . . . . . . . . . . . . .  33
       6.4. HELLO Message Processing . . . . . . . . . . . . . . . .  33
   7.  Link Sensing  . . . . . . . . . . . . . . . . . . . . . . . .  33
       7.1. Populating the Link Set  . . . . . . . . . . . . . . . .  33
            7.1.1. HELLO Message Processing  . . . . . . . . . . . .  34
   8.  Neighbor Detection  . . . . . . . . . . . . . . . . . . . . .  35
      8.1. Populating the Neighbor Set . . . . . . . . . . . . . . .  35
            8.1.1. HELLO Message Processing  . . . . . . . . . . . .  37
       8.2. Populating the 2-hop Neighbor Set. . . . . . . . . . . .  37
            8.2.1. HELLO Message Processing. . . . . . . . . . . . .  37
       8.3. Populating the MPR set . . . . . . . . . . . . . . . . .  38
            8.3.1. MPR Computation . . . . . . . . . . . . . . . . .  39
       8.4. Populating the MPR Selector Set. . . . . . . . . . . . .  41
            8.4.1. HELLO Message Processing. . . . . . . . . . . . .  41
       8.5. Neighborhood and 2-hop Neighborhood Changes. . . . . . .  42
   9.  Topology Discovery  . . . . . . . . . . . . . . . . . . . . .  43
       9.1. TC Message Format. . . . . . . . . . . . . . . . . . . .  43
       9.2. Advertised Neighbor Set. . . . . . . . . . . . . . . . .  44
       9.3. TC Message Generation. . . . . . . . . . . . . . . . . .  45
       9.4. TC Message Forwarding. . . . . . . . . . . . . . . . . .  45
       9.5. TC Message Processing. . . . . . . . . . . . . . . . . .  45
   10. Routing Table Calculation . . . . . . . . . . . . . . . . . .  47
   11. Node Configuration. . . . . . . . . . . . . . . . . . . . . .  50
       11.1. Address Assignment. . . . . . . . . . . . . . . . . . .  50
       11.2. Routing Configuration . . . . . . . . . . . . . . . . .  51
       11.3. Data Packet Forwarding. . . . . . . . . . . . . . . . .  51
   12. Non OLSR Interfaces . . . . . . . . . . . . . . . . . . . . .  51
       12.1. HNA Message Format. . . . . . . . . . . . . . . . . . .  52
       12.2. Host and Network Association Information Base . . . . .  52
       12.3. HNA Message Generation. . . . . . . . . . . . . . . . .  53
       12.4. HNA Message Forwarding. . . . . . . . . . . . . . . . .  53
       12.5. HNA Message Processing. . . . . . . . . . . . . . . . .  53
       12.6. Routing Table Calculation . . . . . . . . . . . . . . .  54
       12.7. Interoperability Considerations . . . . . . . . . . . .  55
   13. Link Layer Notification . . . . . . . . . . . . . . . . . . .  55
       13.1. Interoperability Considerations . . . . . . . . . . . .  56
   14. Link Hysteresis . . . . . . . . . . . . . . . . . . . . . . .  56
       14.1. Local Link Set  . . . . . . . . . . . . . . . . . . . .  56
       14.2. Hello Message Generation  . . . . . . . . . . . . . . .  57
       14.3. Hysteresis Strategy . . . . . . . . . . . . . . . . . .  57
       14.4. Interoperability Considerations . . . . . . . . . . . .  59
   15. Redundant Topology Information. . . . . . . . . . . . . . . .  59
       15.1. TC_REDUNDANCY Parameter . . . . . . . . . . . . . . . .  60
       15.2. Interoperability Considerations . . . . . . . . . . . .  60
   16. MPR Redundancy. . . . . . . . . . . . . . . . . . . . . . . .  60
       16.1. MPR_COVERAGE Parameter. . . . . . . . . . . . . . . . .  61
       16.2. MPR Computation . . . . . . . . . . . . . . . . . . . .  61
       16.3. Interoperability Considerations . . . . . . . . . . . .  62
   17. IPv6 Considerations . . . . . . . . . . . . . . . . . . . . .  63
   18. Proposed Values for Constants . . . . . . . . . . . . . . . .  63
       18.1. Setting emission interval and holding times . . . . . .  63
       18.2. Emission Interval . . . . . . . . . . . . . . . . . . .  64
       18.3. Holding time  . . . . . . . . . . . . . . . . . . . . .  64
       18.4. Message Types . . . . . . . . . . . . . . . . . . . . .  65
       18.5. Link Types. . . . . . . . . . . . . . . . . . . . . . .  65
       18.6. Neighbor Types  . . . . . . . . . . . . . . . . . . . .  65            
       18.7. Link Hysteresis . . . . . . . . . . . . . . . . . . . .  66
       18.8. Willingness . . . . . . . . . . . . . . . . . . . . . .  66
       18.9. Misc. Constants . . . . . . . . . . . . . . . . . . . .  67
   19. Sequence Numbers. . . . . . . . . . . . . . . . . . . . . . .  67
   20. Security Considerations . . . . . . . . . . . . . . . . . . .  67
       20.1. Confidentiality . . . . . . . . . . . . . . . . . . . .  67
       20.2. Integrity . . . . . . . . . . . . . . . . . . . . . . .  68
       20.3. Interaction with External Routing Domains . . . . . . .  69
       20.4. Node Identity . . . . . . . . . . . . . . . . . . . . .  70
   21. Flow and congestion control . . . . . . . . . . . . . . . . .  70
   22. IANA Considerations . . . . . . . . . . . . . . . . . . . . .  70

# 1.  Introduction
The Optimized Link State Routing Protocol (OLSR) is developed for mobile ad hoc networks.  
It operates as a table driven, proactive protocol, i.e., exchanges topology information with other nodes of the network regularly.  
Each node selects **a set of its neighbor nodes as "multipoint relays" (MPR)**.  
In OLSR, only nodes, selected as such MPRs, are responsible for forwarding control traffic, intended for diffusion into the entire network.  
MPRs provide an efficient mechanism for flooding control traffic by reducing the number of transmissions required.

Nodes, selected as MPRs, also have a special responsibility when declaring link state information in the network.  
Indeed, the only requirement for OLSR to provide shortest path routes to all destinations is that **MPR nodes declare link-state information for their MPR selectors**.  
Additional available link-state information may be utilized, e.g., for redundancy.

Nodes which have been selected as multipoint relays by some neighbor node(s) announce this information periodically in their control messages.

A node selects MPRs from among its one hop neighbors with "symmetric", i.e., bi-directional, linkages.

OLSR is developed to work independently from other protocols.

OLSR inherits the concept of forwarding and relaying from HIPERLAN (a MAC layer protocol) which is standardized by ETSI [3].  
The protocol is developed in the IPANEMA project (part of the Euclid program) and in the PRIMA project (part of the RNRT program).

## 1.1.  OLSR Terminology
node
> A MANET router which implements the Optimized Link State Routing protocol as specified in this document.

OLSR interface
> A network device participating in a MANET running OLSR.  A node may have several OLSR interfaces, each interface assigned an unique IP address.

non OLSR interface
> A network device, not participating in a MANET running OLSR.

single OLSR interface node
>

multiple OLSR interface node
> A node which has multiple OLSR interfaces, participating in an OLSR routing domain.

main address
> The main address of a node, which will be used in OLSR control traffic as the "originator address" of all messages emitted by this node.  It is the address of one of the OLSR interfaces of the node.
> A single OLSR interface node MUST use the address of its only OLSR interface as the main address.
> A multiple OLSR interface node MUST choose one of its OLSR interface addresses as its "main address" (equivalent of "router ID" or "node identifier").  It is of no importance which address is chosen, however a node SHOULD always use the same address as its main address.

neighbor node
> A node X is a neighbor node of node Y if node Y can hear node X (i.e., a link exists between an OLSR interface on node X and an OLSR interface on Y).

2-hop neighbor
> A node heard by a neighbor.

strict 2-hop neighbor
> a 2-hop neighbor which is not the node itself or a neighbor of the node, and in addition is a neighbor of a neighbor, with willingness different from WILL_NEVER, of the node.


multipoint relay (MPR)
> A node which is selected by its 1-hop neighbor, node X, to "re-transmit" all the broadcast messages that it receives from X, provided that the message is not a duplicate, and that the time to live field of the message is greater than one.

# Reference
* [Optimized Link State Routing Protocol (OLSR) October 2003](https://tools.ietf.org/html/rfc3626)

* [The Optimized Link State Routing Protocol Version 2 April 2014](https://tools.ietf.org/html/rfc7181)

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
