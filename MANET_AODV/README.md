# Purpose
Review Ad-Hoc On-Demand Distance Vector Routing of Mobile Ad-Hoc Network(MANET).

# 1 Introduction
AODV allows mobile nodes to respond to link breakages and changes in network topology in a timely manner.
The operation of AODV is loop-free, and by avoiding the Bellman-Ford "counting to infinity" problem offers quick convergence when the ad
hoc network topology changes (typically, when a node moves in the network).

One distinguishing feature of AODV is its use of a destination sequence number for each route entry.  The destination sequence
number is created by the destination to be included along with any route information it sends to requesting nodes.  Using destination
sequence numbers ensures loop freedom and is simple to program.
Given the choice between two routes to a destination, a requesting node is required to select the one with the greatest sequence number.

# 2 Overview
Route Requests (RREQs), Route Replies (RREPs), and Route Errors (RERRs) are the message types defined by AODV.
These message types are received via UDP, and normal IP header processing applies.
For broadcast messages, the IP limited broadcast address (255.255.255.255) is used.
This means that such messages are not blindly forwarded.  However, AODV operation does require certain messages (e.g., RREQ) to be
disseminated widely, perhaps throughout the ad hoc network.  
The range of dissemination of such RREQs is indicated by the TTL in the IP header.  Fragmentation is typically not required.

As long as the endpoints of a communication connection have valid routes to each other, AODV does not play any role.
When a route to a new destination is needed, the node broadcasts a RREQ to find a route to the destination.
A route can be determined when the RREQ reaches either the destination itself, or an intermediate node with a 'fresh enough' route to the destination.
A **'fresh enough'** route is a valid route entry for the destination whose associated sequence number is at least as great as that contained in the RREQ.
The route is made available by unicasting a RREP back to the origination of the RREQ.
Each node receiving the request caches a route back to the originator of the request, so that the RREP can be unicast from the destination along a path to that originator, or likewise from any intermediate node that is able to satisfy the request.

Nodes monitor the link status of next hops in active routes.  
When a link break in an active route is detected, a RERR message is used to notify other nodes that the loss of that link has occurred.
The RERR message indicates those destinations (possibly subnets) which are no longer reachable by way of the broken link.
In order to enable this reporting mechanism, each node keeps a **"precursor list"**, containing the IP address for each its neighbors that are likely to use it as a next hop towards each destination.
The information in the precursor lists is most easily acquired during the processing for generation of a RREP message, which by definition has to be sent to a node in a **precursor list (see section 6.6)**. 
If the RREP has a nonzero prefix length, then the originator of the RREQ which solicited the RREP information is included among the precursors for the subnet route (not specifically for the particular destination).

A RREQ may also be received for a multicast IP address.  In this document, full processing for such messages is not specified.

AODV is a routing protocol, and it deals with route table management.  Route table information must be kept even for short-lived routes,
such as are created to temporarily store reverse paths towards nodes originating RREQs.
AODV uses the following fields with each route table entry:
```
   -  Destination IP Address
   -  Destination Sequence Number
   -  Valid Destination Sequence Number flag
   -  Other state and routing flags (e.g., valid, invalid, repairable, being repaired)
   -  Network Interface
   -  Hop Count (number of hops needed to reach destination)
   -  Next Hop
   -  List of Precursors (described in Section 6.2)
   -  Lifetime (expiration or deletion time of the route)
```

Managing **the sequence number** is crucial to avoiding routing loops, even when links break and a node is no longer reachable to supply its own information about its sequence number.
When these conditions occur, the route is invalidated by operations involving the sequence number and marking the route table entry state as invalid.  See section 6.1 for details.

# 3. AODV Terminology
## active route
A route towards a destination that has a routing table entry that is marked as valid.  Only active routes can be used to forward data packets.

## broadcast
Broadcasting means transmitting to the IP Limited Broadcast address, 255.255.255.255.

## destination
An IP address to which data packets are to be transmitted. Same as "destination node".

## forwarding node
A node that agrees to forward packets destined for another node, by retransmitting them to a next hop that is closer to the unicast destination along a path that has been set up using routing control messages.

## forward route
A route set up to send data packets from a node originating a Route Discovery operation towards its desired destination.

## invalid route
A route that has expired, denoted by a state of invalid in the routing table entry.
An invalid route is used to store previously valid route information for an extended period of time.
An invalid route cannot be used to forward data packets, but it can provide information useful for route repairs, and also for future RREQ messages.

## originating node
A node that initiates an AODV route discovery message to be processed and possibly retransmitted by other nodes in the ad hoc network.

## reverse route
A route set up to forward a reply (RREP) packet back to the originator from the destination or from an intermediate node having a route to the destination.

## sequence number
A monotonically increasing number maintained by each originating node.  
In AODV routing protocol messages, it is used by other nodes to determine the freshness of the information contained from the originating node.

## valid route
See active route.

# 4. Applicability Statement
The AODV routing protocol is designed for mobile ad hoc networks with populations of tens to thousands of mobile nodes.  
AODV can handle low, moderate, and relatively high mobility rates, as well as a variety of data traffic levels.
AODV is designed for use in networks where the nodes can all trust each other, either by use of preconfigured keys, or because it is known that there are no malicious intruder nodes.  
AODV has been designed to reduce the dissemination of control traffic and eliminate overhead on data traffic, in order to improve scalability and performance.

# 5. Message Formats

## 5.1. Route Request (RREQ) Message Format
```
    0                   1                   2                   3
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |     Type      |J|R|G|D|U|   Reserved          |   Hop Count   |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                            RREQ ID                            |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                    Destination IP Address                     |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                  Destination Sequence Number                  |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                    Originator IP Address                      |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                  Originator Sequence Number                   |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

The format of the Route Request message is illustrated above, and contains the following fields:
```
      Type           1

      J              Join flag; reserved for multicast.

      R              Repair flag; reserved for multicast.

      G              Gratuitous RREP flag; indicates whether a gratuitous RREP should be unicast to the node                     
                     specified in the Destination IP Address field (see sections 6.3, 6.6.3).                     

      D              Destination only flag; indicates only the destination may respond to this RREQ (see                     
                     section 6.5).

      U              Unknown sequence number; indicates the destination sequence number is unknown (see section 6.3).                     

      Reserved       Sent as 0; ignored on reception.

      Hop Count      The number of hops from the Originator IP Address to the node handling the request.                     

      RREQ ID        A sequence number uniquely identifying the particular RREQ when taken in conjunction with the
                     originating node's IP address.

      Destination IP Address
      Destination Sequence Number
      Originator IP Address
      Originator Sequence Number                  
```

## 5.2. Route Reply (RREP) Message Format
```
    0                   1                   2                   3
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |     Type      |R|A|    Reserved     |Prefix Sz|   Hop Count   |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                     Destination IP address                    |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                  Destination Sequence Number                  |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                    Originator IP address                      |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                           Lifetime                            |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

The format of the Route Reply message is illustrated above, and contains the following fields:
```
      Type          2

      R             Repair flag; used for multicast.

      A             Acknowledgment required; see sections 5.4 and 6.7.

      Reserved      Sent as 0; ignored on reception.

      Prefix Size   If nonzero, the 5-bit Prefix Size specifies that the indicated next hop may be used for any nodes with                    
                    the same routing prefix (as defined by the Prefix Size) as the requested destination.                    

      Hop Count     The number of hops from the Originator IP Address to the Destination IP Address.  
                    For multicast route requests this indicates the number of hops to the                    
                    multicast tree member sending the RREP.

      Destination IP Address
      Destination Sequence Number
      Originator IP Address

      Lifetime      The time in milliseconds for which nodes receiving the RREP consider the route to be valid.
```

## 5.3. Route Error (RERR) Message Format
```
    0                   1                   2                   3
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |     Type      |N|          Reserved           |   DestCount   |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |            Unreachable Destination IP Address (1)             |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |         Unreachable Destination Sequence Number (1)           |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-|
   |  Additional Unreachable Destination IP Addresses (if needed)  |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |Additional Unreachable Destination Sequence Numbers (if needed)|
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

The format of the Route Error message is illustrated above, and contains the following fields:
```
      Type        3

      N           No delete flag; set when a node has performed a local repair of a link, and upstream nodes should not delete                  
                  the route.

      Reserved    Sent as 0; ignored on reception.

      DestCount   The number of unreachable destinations included in the message; MUST be at least 1.                  

      Unreachable Destination IP Address
                  The IP address of the destination that has become unreachable due to a link break.                  

      Unreachable Destination Sequence Number
                  The sequence number in the route table entry for
                  the destination listed in the previous Unreachable Destination IP Address field.                  
```
The RERR message is sent whenever a link break causes one or more destinations to become unreachable from some of the node's neighbors.
See section 6.2 for information about how to maintain the appropriate records for this determination, and 
section 6.11 for specification about how to create the list of destinations.

# 6. AODV Operation
This section describes the scenarios under which nodes generate Route Request (RREQ), Route Reply (RREP) and Route Error (RERR) messages for unicast communication towards a destination, and how the message data are handled.  
In order to process the messages correctly, certain state information has to be maintained in the route table entries for the destinations of interest.

All AODV messages are sent to port 654 using UDP.

## 6.1. Maintaining Sequence Numbers
Every route table entry at every node MUST include the latest information available about the sequence number for the IP address of the destination node for which the route table entry is maintained.
This sequence number is called the **"destination sequence number"**.  It is updated whenever a node receives new (i.e., not stale) information about the sequence number from **RREQ, RREP, or RERR** messages that may be received related to that destination.
AODV depends on each node  in the network to own and maintain its destination sequence number to guarantee the loop-freedom of all routes towards that node.
A destination node increments its own sequence number in two circumstances:
```
   -  Immediately before a node originates a route discovery, it MUST increment its own sequence number.
      This prevents conflicts with previously established reverse routes towards the originator of a
      RREQ.

   -  Immediately before a destination node originates a RREP in response to a RREQ,
      it MUST update its own sequence number to the maximum of its current sequence number and the destination      
      sequence number in the RREQ packet.
```

When the destination increments its sequence number, it MUST do so by treating the sequence number value as if it were an unsigned number.

In order to ascertain that information about a destination is not stale, the node compares its current numerical value for the sequence number with that obtained from the incoming AODV message.
If **the result of subtracting the currently stored sequence number from the value of the incoming sequence number is less than zero**, then the information related to **that destination in the AODV message MUST be discarded**, since that information is stale compared to the node's currently stored information.

The only other circumstance in which a node may change the destination sequence number in one of its route table entries is in response to **a lost or expired link to the next hop towards that destination**.

The node determines which destinations use a particular next hop by consulting its routing table.  In this case, for each destination that uses the next hop, **the node increments the sequence number and marks the route as invalid (see also sections 6.11, 6.12)**.

A node may change the sequence number in the routing table entry of a destination only if:
```
   -  it is itself the destination node, and offers a new route to itself, or      

   -  it receives an AODV message with new information about the sequence number for a destination node, or      

   -  the path towards the destination node expires or breaks.
```

## 6.2. Route Table Entries and Precursor Lists
When a node receives an AODV control packet from a neighbor, or creates or updates a route for a particular destination or subnet, it checks its route table for an entry for the destination.
In the event that there is no corresponding entry for that destination, an entry is created.
The sequence number is either determined from the information contained in the control packet, or else the valid sequence number field is set to false. 

The route is only updated if the new sequence number is either
```
   (i)       higher than the destination sequence number in the route table, or             

   (ii)      the sequence numbers are equal, but the hop count (of the new information) plus one, is smaller than the existing hop             
             count in the routing table, or

   (iii)     the sequence number is unknown.
```

The Lifetime field of the routing table entry is either determined from the control packet, or **it is initialized to ACTIVE_ROUTE_TIMEOUT**.

Each time a route is used to forward a data packet, its Active Route Lifetime field of the source, destination and the next hop on the path to the destination is updated to be no less than the current time plus ACTIVE_ROUTE_TIMEOUT.

Since the route between each originator and destination pair is expected to be symmetric, the Active Route Lifetime for the previous hop, along the reverse path back to the IP source, is **also updated to be no less than the current time plus ACTIVE_ROUTE_TIMEOUT**.  
The lifetime for an Active Route is updated each time the route is used regardless of whether the destination is a single node or a subnet.

For each valid route maintained by a node as a routing table entry, **the node also maintains a list of precursors that may be forwarding packets on this route**.
These precursors will receive notifications from the node in the event of detection of the loss of the next hop link.  
The list of precursors in a routing table entry contains those neighboring nodes to which a route reply was generated or forwarded.

## 6.3. Generating Route Requests
A node disseminates a RREQ when it determines that it needs a route to a destination and does not have one available.
This can happen if the destination is previously unknown to the node, or if a previously valid route to the destination expires or is marked as invalid.
The Destination Sequence Number field in the RREQ message is the last known destination sequence number for this destination and is copied from the Destination Sequence Number field in the routing table.
**If no sequence number is known, the unknown sequence number flag MUST be set**.

The Originator Sequence Number in the RREQ message is the node's own sequence number, which is incremented prior to insertion in a RREQ.  
The RREQ ID field is incremented by one from the last RREQ ID used by the current node.  Each node maintains only one RREQ ID.  
The Hop Count field is set to zero.

Before broadcasting the RREQ, the originating node buffers the **RREQ ID and the Originator IP address (its own address) of the RREQ for PATH_DISCOVERY_TIME**.  
In this way, when the node receives the packet again from its neighbors, it will not reprocess and re-forward the packet.

An originating node often expects to have bidirectional communications with a destination node.
In order for this to happen as efficiently as possible, any generation of **a RREP by an intermediate node (as in section 6.6) for delivery to the originating node** SHOULD be accompanied by some action that **notifies the destination about a route back to the originating node**.
The originating node selects this mode of operation in **the intermediate nodes by setting the 'G' flag**.  **See section 6.6.3** for details about actions taken by the intermediate node in response to a RREQ with the 'G' flag set.   

A node **SHOULD NOT** originate more than **RREQ_RATELIMIT RREQ messages per second**.
After broadcasting a RREQ, a node waits for a RREP (or other control message with current information regarding a route to the appropriate destination).
If a route is not received **within NET_TRAVERSAL_TIME milliseconds**, the node MAY try again to discover a route by broadcasting another RREQ, **up to a maximum of RREQ_RETRIES times at the maximum TTL value**.  
Each new attempt **MUST increment and update the RREQ ID**.  For each attempt, the TTL field of the IP header is set according to the mechanism specified in section 6.4, in order to enable control over how far the RREQ is disseminated for the each retry.

Data packets **waiting for a route** (i.e., waiting for a RREP after a RREQ has been sent) **SHOULD be buffered**.  The buffering SHOULD be "first-in, first-out" (FIFO).
If a route discovery has been attempted RREQ_RETRIES times **at the maximum TTL without receiving any RREP**, all data packets destined for the corresponding destination **SHOULD be dropped from the buffer** and **a Destination Unreachable message SHOULD be delivered to the application**.

To reduce congestion in a network, repeated attempts by a source node at route discovery for a single destination **MUST utilize a binary exponential backoff**.  
The first time a source node broadcasts a RREQ, **it waits NET_TRAVERSAL_TIME milliseconds** for the reception of a RREP.  
If a RREP is not received within that time, the source node sends a new RREQ.  
When calculating the time to wait for the RREP after sending the second RREQ, the source node MUST use a binary exponential backoff.  
Hence, the waiting time for the RREP corresponding to the **second RREQ** is **2 * NET_TRAVERSAL_TIME milliseconds**.  
If a RREP is not received within this time period, another RREQ may be sent, up to RREQ_RETRIES additional attempts after the first RREQ.  
**For each additional attempt, the waiting time for the RREP is multiplied by 2**, so that the time conforms to a binary exponential backoff.

## 6.4. Controlling Dissemination of Route Request Messages
To prevent unnecessary network-wide dissemination of RREQs, the originating node SHOULD use an **expanding ring search technique**.
In an expanding ring search, the originating node initially uses a TTL =TTL_START in the RREQ packet IP header and sets the timeout for receiving a RREP to RING_TRAVERSAL_TIME milliseconds.  
RING_TRAVERSAL_TIME is calculated as described in section 10.  The TTL_VALUE used in calculating RING_TRAVERSAL_TIME is set equal to the value of the TTL field in the IP header.  
If the RREQ times out without a corresponding RREP, the originator broadcasts the RREQ again with the TTL incremented by TTL_INCREMENT.
This continues **until the TTL set in the RREQ reaches TTL_THRESHOLD, beyond which a TTL = NET_DIAMETER is used for each attempt**.  
Each time, **the timeout for receiving a RREP is RING_TRAVERSAL_TIME.**  **When it is desired to have all retries traverse the entire ad hoc network, this can be achieved by configuring TTL_START and TTL_INCREMENT both to be the same value as NET_DIAMETER**.

The Hop Count stored in an invalid routing table entry indicates the last known hop count to that destination in the routing table.  
When a new route to the same destination is required at a later time (e.g., upon route loss), the TTL in the RREQ IP header is initially set to the Hop Count plus TTL_INCREMENT.
Thereafter, following each timeout the TTL is incremented by TTL_INCREMENT until TTL = TTL_THRESHOLD is reached.  
Beyond this TTL = NET_DIAMETER is used.
Once TTL = NET_DIAMETER, the timeout for waiting for the RREP is set to NET_TRAVERSAL_TIME, as specified in section 6.3.

An expired routing table entry **SHOULD NOT be expunged before (current_time + DELETE_PERIOD) (see section 6.11)**.
Otherwise, the soft state corresponding to the route (e.g., last known hop count) will be lost.  
Furthermore, a longer routing table entry expunge time MAY be configured.  
Any routing table entry **waiting for a RREP SHOULD NOT be expunged before (current_time + 2 * NET_TRAVERSAL_TIME)**.

## 6.5. Processing and Forwarding Route Requests

## 6.6. Generating Route Replies
### 6.6.1. Route Reply Generation by the Destination
### 6.6.2. Route Reply Generation by an Intermediate Node
### 6.6.3. Generating Gratuitous RREPs
## 6.7. Receiving and Forwarding Route Replies
## 6.8. Operation over Unidirectional Links
## 6.9. Hello Messages
## 6.10. Maintaining Local Connectivity 
## 6.11. Route Error (RERR) Messages, Route Expiry and Route Deletion
## 6.12. Local Repair
## 6.13. Actions After Reboot
## 6.14. Interfaces

# 7. AODV and Aggregated Networks 

# 8. Using AODV with Other Networks

# 9. Extensions

# Reference
* [Ad hoc On-Demand Distance Vector (AODV) Routing RFC3561](https://tools.ietf.org/html/rfc3561)
* [600.647 - Advanced Topics in Wireless Networks, Spring 08](https://www.cs.jhu.edu/~cs647/)
* [Mobile ad-hoc networks](http://www.yl.is.s.u-tokyo.ac.jp/~kaneda/misc/resumes/mobile_ad_hoc_networks.ppt)
* [アドホックネットワークの概要と技術動向 千葉大学大学院 阪田 史郎 2005年2月26日](https://slidesplayer.net/slide/11226125/)
* [創発システムに向けて 慶應義塾大学環境情報学部 徳田英幸](https://slidesplayer.net/slide/11499738/)
* [第5回 DSR（Dynamic Source Routing）プロトコル 2003年3月5日](https://internet.watch.impress.co.jp/www/column/wp2p/wp2p05.htm)
* [第6回　OLSR（Optimized Link State Routing）プロトコル 2003年4月15日](https://internet.watch.impress.co.jp/www/column/wp2p/wp2p06.htm)
* [第7回 AODV(Ad hoc On-Demand Distance Vector)プロトコル 2003/5/22](https://internet.watch.impress.co.jp/www/column/wp2p/wp2p07.htm)

* [DSDV VS AODV Published on Sep 19, 2014](https://www.slideshare.net/SenthilKanth/dsdv-dsr-aodvtuto)
* [DSDV VS AODV page28 2/27/06](https://www.slideshare.net/SenthilKanth/dsdv-dsr-aodvtuto)
```
28. AODV --- Optimizations 
• Expanding ring search 
– Prevents flooding of network during route discovery 
– Control Time to Live of RREQ 

• Local repair 
– Repair breaks in active routes locally instead of notifying source 
– Use small TTL because destination probably has not moved far 
– If first repair attempt is unsuccessful, send RERR to source 
```
* [An Engineering Approach to Computer Networking— Routing page98](https://slideplayer.com/slide/12337178/)
```
 Expanding ring search 
 A way to use multicast groups for resource discovery 
 Routers decrement TTL when forwarding 
 Sender sets TTL and multicasts 
    reaches all receivers <= TTL hops away 
 Discovers local resources first 
 Since heavily loaded servers can keep quiet, automatically distributes load 
```

* [Shashank95/AODV-vs-DSDV-vs-DSR-on-NS2.35 - GitHub 8 Apr 2017](https://github.com/Shashank95/AODV-vs-DSDV-vs-DSR-on-NS2.35)
* [joshjdevl/docker-ns3  29 Apr 2014](https://github.com/joshjdevl/docker-ns3)
* [[ns-3] Cloning MANET Routing Protocols in ns-3 November 7, 2015](http://mohittahiliani.blogspot.com/2015/11/ns-3-cloning-manet-routing-protocols-in.html)
```
 This post provides a "python script" to clone AODV, DSDV, OLSR or DSR in ns-3. By cloning, we mean that an identical copy of an existing protocol is created in ns-3, but with a different name. 

Once the clone is created, you can modify it for your research work without affecting the original code of existing protocols in ns-3.

Warning: DSR cloning will work only for ns-3.25 and higher versions of ns-3!

python script
```

```
 Steps to create a clone:

1. Download the python script: clone-manet-routing.py
2. Place it in ns-allinone-3.xx/ns-3.xx/src directory
3. Go to ns-allinone-3.xx/ns-3.xx/src via terminal and give the following command:
chmod 777 clone-manet-routing.py

4. Give the following command to create a clone of AODV:
./clone-manet-routing.py aodv myaodv

5. Go to ns-allinone-3.xx/ns-3.xx/ via terminal and give the following commands:
./waf configure --enable-examples
./waf

You are done with it!
Note: Replace aodv by dsdv, olsr or dsr in Step 4 to clone DSDV, OLSR or DSR respectively.
```

```
Verifying the working of a clone:

1. Copy myaodv.cc from ns-allinone-3.xx/ns-3.xx/src/myaodv/examples
2. Paste it in ns-allinone-3.xx/ns-3.xx/scratch
3. Give the following command from ns-3.xx directory to run it:

./waf --run scratch/myaodv

If the command succeeds, you have successfully cloned AODV to MYAODV.
```

* [NS-3_MANET_Projects 24 Dec 2016](https://github.com/setu4993/NS-3_MANET_Projects)
```
All of the programs written (and edited from examples) for implementation of various Mobile Ad-Hoc Networks in Network Simulator-3 for class projects. 
C++
```

* [ns-3.26で始めるネットワークシミュレーション Feb 06, 2017](https://qiita.com/haltaro/items/b474d924f63692c155c8)
* [ns-3でTCPの輻輳制御を観察する Feb 20, 2017](https://qiita.com/haltaro/items/d479538345357f08c595)
* [ns-3構築を爆速で終わらせるためのシェルスクリプト Jul 29, 2018](https://qiita.com/wawawa/items/02984c882816966c5583)

* [how can i extract delay and throughput from manet-routing-compare.cc in ns3? Apr 29 '17](https://stackoverflow.com/questions/43700595/how-can-i-extract-delay-and-throughput-from-manet-routing-compare-cc-in-ns3)

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
