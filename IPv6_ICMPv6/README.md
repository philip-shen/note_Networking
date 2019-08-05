# 1. Introduction
This document describes the format of a set of control messages used in ICMPv6.  It does not describe the procedures for using these messages to achieve functions like Path MTU discovery; these procedures are described in other documents (e.g., [PMTU](https://tools.ietf.org/html/rfc8201)).  Other documents may also introduce additional ICMPv6 message types, such as Neighbor Discovery messages [IPv6-DISC](https://tools.ietf.org/html/rfc4861), subject to the general rules for ICMPv6 messages given in Section 2 of this document.

# 2. ICMPv6 (ICMP for IPv6)
# 2.1.  Message General Format
```
       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |     Type      |     Code      |          Checksum             |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                                                               |
      +                         Message Body                          +
      |                                                               |
```
The ICMPv6 header is identified by a Next Header value of 58 in the immediately preceding header.

# 3. ICMPv6 Error Messages
# 3.1.  Destination Unreachable Message
```
       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |     Type      |     Code      |          Checksum             |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                             Unused                            |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                    As much of invoking packet                 |
      +                as possible without the ICMPv6 packet          +
      |                exceeding the minimum IPv6 MTU [IPv6]          |

   IPv6 Fields:

   Destination Address

                  Copied from the Source Address field of the invoking
                  packet.

   ICMPv6 Fields:

   Type           1

   Code           0 - No route to destination
                  1 - Communication with destination
                        administratively prohibited
                  2 - Beyond scope of source address
                  3 - Address unreachable
                  4 - Port unreachable
                  5 - Source address failed ingress/egress policy
                  6 - Reject route to destination

   Unused         This field is unused for all code values.
                  It must be initialized to zero by the originator
                  and ignored by the receiver.
```
If the reason for the failure to deliver is lack of a matching entry in the forwarding node's routing table, the Code field is set to 0.

If the reason for the failure to deliver is administrative prohibition (e.g., a "firewall filter"), the Code field is set to 1.

If the reason for the failure to deliver is that the destination is beyond the scope of the source address, the Code field is set to 2.
This condition can occur only when the scope of the source address is smaller than the scope of the destination address (e.g., when a packet has a link-local source address and a global-scope destination address) and the packet cannot be delivered to the destination without leaving the scope of the source address.

If the reason for the failure to deliver cannot be mapped to any of other codes, the Code field is set to 3.

A destination node SHOULD originate a Destination Unreachable message with Code 4 in response to a packet for which the transport protocol (e.g., UDP) has no listener, if that transport protocol has no alternative means to inform the sender.

If the reason for the failure to deliver is that the packet with this source address is not allowed due to ingress or egress filtering policies, the Code field is set to 5.

If the reason for the failure to deliver is that the route to the destination is a reject route, the Code field is set to 6.  This may occur if the router has been configured to reject all the traffic for a specific prefix.

# 3.2.  Packet Too Big Message
```
       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |     Type      |     Code      |          Checksum             |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                             MTU                               |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                    As much of invoking packet                 |
      +               as possible without the ICMPv6 packet           +
      |               exceeding the minimum IPv6 MTU [IPv6]           |

   IPv6 Fields:

   Destination Address

                  Copied from the Source Address field of the invoking
                  packet.

   ICMPv6 Fields:

   Type           2

   Code           Set to 0 (zero) by the originator and ignored by the
                  receiver.

   MTU            The Maximum Transmission Unit of the next-hop link.

```
# 3.3.  Time Exceeded Message
```
       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |     Type      |     Code      |          Checksum             |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                             Unused                            |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                    As much of invoking packet                 |
      +               as possible without the ICMPv6 packet           +
      |               exceeding the minimum IPv6 MTU [IPv6]           |

   IPv6 Fields:

   Destination Address
                  Copied from the Source Address field of the invoking
                  packet.

   ICMPv6 Fields:

   Type           3

   Code           0 - Hop limit exceeded in transit
                  1 - Fragment reassembly time exceeded

   Unused         This field is unused for all code values.
                  It must be initialized to zero by the originator
                  and ignored by the receiver.
```
# 3.4.  Parameter Problem Message
```
       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |     Type      |     Code      |          Checksum             |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                            Pointer                            |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                    As much of invoking packet                 |
      +               as possible without the ICMPv6 packet           +
      |               exceeding the minimum IPv6 MTU [IPv6]           |

   IPv6 Fields:

   Destination Address

                  Copied from the Source Address field of the invoking
                  packet.

   ICMPv6 Fields:

   Type           4

   Code           0 - Erroneous header field encountered
                  1 - Unrecognized Next Header type encountered
                  2 - Unrecognized IPv6 option encountered

   Pointer        Identifies the octet offset within the
                  invoking packet where the error was detected.

                  The pointer will point beyond the end of the ICMPv6
                  packet if the field in error is beyond what can fit
                  in the maximum size of an ICMPv6 error message.
```

# 4. ICMPv6 Informational Messages
# 4.1.  Echo Request Message
```
       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |     Type      |     Code      |          Checksum             |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |           Identifier          |        Sequence Number        |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |     Data ...
      +-+-+-+-+-

   IPv6 Fields:

   Destination Address

                  Any legal IPv6 address.

   ICMPv6 Fields:

   Type           128

   Code           0

   Identifier     An identifier to aid in matching Echo Replies
                  to this Echo Request.  May be zero.
   Sequence Number

                  A sequence number to aid in matching Echo Replies
                  to this Echo Request.  May be zero.

   Data           Zero or more octets of arbitrary data.
```
# 4.1.  Echo Reply Message
```
       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |     Type      |     Code      |          Checksum             |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |           Identifier          |        Sequence Number        |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |     Data ...
      +-+-+-+-+-

   IPv6 Fields:

   Destination Address

                  Copied from the Source Address field of the invoking
                  Echo Request packet.

   ICMPv6 Fields:

   Type           129

   Code           0

   Identifier     The identifier from the invoking Echo Request message.
   
   Sequence Number

                  The sequence number from the invoking Echo Request
                  message.

   Data           The data from the invoking Echo Request message.   
```
# 5. Security Considerations
# 5.1.  Authentication and Confidentiality of ICMP Messages

# 5.2.  ICMP Attacks
ICMP messages may be subject to various attacks.  A complete discussion can be found in the IP Security Architecture [IPv6-SA](https://tools.ietf.org/html/rfc2401).  A brief discussion of these attacks and their prevention follows:

   1. ICMP messages may be subject to actions intended to cause the
      receiver to believe the message came from a different source from
      that of the message originator.  
   2. ICMP messages may be subject to actions intended to cause the
      message or the reply to it to go to a destination different from
      that of the message originator's intention.
   3. ICMP messages may be subject to changes in the message fields, or
      payload.        
   4. ICMP messages may be used to attempt denial-of-service attacks by
      sending back to back erroneous IP packets.       
   5. The exception number 2 of rule e.3 in Section 2.4 gives a
      malicious node the opportunity to cause a denial-of-service attack
      to a multicast source.  
   6. As the ICMP messages are passed to the upper-layer processes, it
      is possible to perform attacks on the upper layer protocols (e.g.,
      TCP) with ICMP [TCP-attack].  

Reference 
==============================
* [Internet Control Message Protocol (ICMPv6) for IPv6, RFC4443](https://tools.ietf.org/html/rfc4443)
* [[PMTU] "Path MTU Discovery for IP version 6", RFC 8201, July 2017](https://tools.ietf.org/html/rfc8201)
* [[IPv6-DISC]  "Neighbor Discovery for IP Version 6 (IPv6)", RFC 4861, September 2007.](https://tools.ietf.org/html/rfc4861)

* [ICMPv6 Message Types](https://www.ipv6.com/general/icmpv6-tech-details-advantages/)  
![alt tag](https://www.ipv6.com/wp-content/uploads/2017/06/ICMPv6_2.gif)

* []()
![alt tag]()
```

```	
