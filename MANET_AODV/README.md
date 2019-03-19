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
