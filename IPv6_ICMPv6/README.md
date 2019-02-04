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

Reference 
==============================
* [Internet Control Message Protocol (ICMPv6) for IPv6, RFC4443](https://tools.ietf.org/html/rfc4443)
* [[PMTU] "Path MTU Discovery for IP version 6", RFC 8201, July 2017](https://tools.ietf.org/html/rfc8201)
* [[IPv6-DISC]  "Neighbor Discovery for IP Version 6 (IPv6)", RFC 4861, September 2007.](https://tools.ietf.org/html/rfc4861)

* []()
![alt tag]()
```

```	
