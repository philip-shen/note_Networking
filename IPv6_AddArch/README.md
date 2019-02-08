# 1.  Introduction
This specification defines the addressing architecture of the IP Version 6 protocol.  It includes the basic formats for the various types of IPv6 addresses (unicast, anycast, and multicast).

# 2.  IPv6 Addressing
There are three types of addresses:

  Unicast:   An identifier for a single interface.  A packet sent to a unicast address is delivered to the interface identified by that
            address.
 
  Anycast:   An identifier for a set of interfaces (typically belonging to different nodes).  A packet sent to an anycast address is
            delivered to one of the interfaces identified by that address (the "nearest" one, according to the routing protocols' measure
            of distance).

  Multicast: An identifier for a set of interfaces (typically belonging to different nodes).  A packet sent to a multicast address is
              delivered to all interfaces identified by that address.
               
There are no broadcast addresses in IPv6, their function being superseded by multicast addresses.

# 2.1.  Addressing Model
IPv6 addresses of all types are assigned to interfaces, not nodes.  An IPv6 unicast address refers to a single interface.

All interfaces are required to have at least one Link-Local unicast address (see Section 2.8 for additional required addresses).
A single interface may also have multiple IPv6 addresses of any type (unicast, anycast, and multicast) or scope.

# 2.2.  Text Representation of Addresses
   1. The preferred form is x:x:x:x:x:x:x:x, where the 'x's are one to
      four hexadecimal digits of the eight 16-bit pieces of the address.
      Examples:

         ABCD:EF01:2345:6789:ABCD:EF01:2345:6789

         2001:DB8:0:0:8:800:200C:417A

   2. Due to some methods of allocating certain styles of IPv6 addresses, it will be common for addresses to contain long strings      
      of zero bits.  In order to make writing addresses containing zero bits easier, a special syntax is available to compress the
      zeros.
      The use of "::" indicates one or more groups of 16 bits of zeros.
      The "::" can only appear once in an address.  
      The "::" can also be used to compress leading or trailing zeros in an address.
      
  3. An alternative form that is sometimes more convenient when dealing with a mixed environment of IPv4 and IPv6 nodes is      
      x:x:x:x:x:x:d.d.d.d, where the 'x's are the hexadecimal values of the six high-order 16-bit pieces of the address, and the 'd's
      are the decimal values of the four low-order 8-bit pieces of the address (standard IPv4 representation).
      
# 2.3.  Text Representation of Address Prefixes
The text representation of IPv6 address prefixes is similar to the way IPv4 address prefixes are written in Classless Inter-Domain Routing (CIDR) notation [CIDR].  An IPv6 address prefix is represented by the notation:
      ipv6-address/prefix-length
      
# 2.4.  Address Type Identification
   The type of an IPv6 address is identified by the high-order bits of the address, as follows:   

      Address type         Binary prefix        IPv6 notation   Section
      ------------         -------------        -------------   -------
      Unspecified          00...0  (128 bits)   ::/128          2.5.2
      Loopback             00...1  (128 bits)   ::1/128         2.5.3
      Multicast            11111111             FF00::/8        2.7
      Link-Local unicast   1111111010           FE80::/10       2.5.6
      Global Unicast       (everything else)

   Anycast addresses are taken from the unicast address spaces (of any scope) and are not syntactically distinguishable from unicast  addresses.

# 2.5.  Unicast Addresses
There are several types of unicast addresses in IPv6, in particular, Global Unicast, site-local unicast (deprecated, see Section 2.5.7), and Link-Local unicast.  There are also some special-purpose subtypes of Global Unicast, such as IPv6 addresses with embedded IPv4 addresses.
A slightly sophisticated host (but still rather simple) may additionally be aware of subnet prefix(es) for the link(s) it is attached to, where different addresses may have different values for n:
```
   |          n bits               |           128-n bits            |
   +-------------------------------+---------------------------------+
   |       subnet prefix           |           interface ID          |
   +-------------------------------+---------------------------------+
```
# 2.5.1.  Interface Identifiers
Interface identifiers in IPv6 unicast addresses are used to identify interfaces on a link.  They are required to be unique within a subnet prefix.  It is recommended that the same interface identifier not be assigned to different nodes on a link.

Modified EUI-64 format-based interface identifiers may have universal scope when derived from a universal token (e.g., IEEE 802 48-bit MAC or IEEE EUI-64 identifiers [EUI64]) or may have local scope where a global token is not available (e.g., serial links, tunnel end-points)

In the resulting Modified EUI-64 format, the "u" bit is set to one (1) to indicate universal scope, and it is set to zero (0) to indicate local scope.  The first three octets in binary of an IEEE EUI-64 identifier are as follows:
```
          0       0 0       1 1       2
         |0       7 8       5 6       3|
         +----+----+----+----+----+----+
         |cccc|ccug|cccc|cccc|cccc|cccc|
         +----+----+----+----+----+----+
```
written in Internet standard bit-order, where "u" is the universal/local bit, "g" is the individual/group bit, and "c" is the bits of the company_id.

# Converting a 48-bit MAC address to a 64-bit Interface Identifier in EUI-64 format:
To create a EUI-64 interface identifier from a 48-bit MAC address, two octets of values 0xFF and 0xFE are inserted in the middle of 48-bit MAC address (between vendor ID (OUI) and vendor supplied ID). Also, the universal/local bit is set to 1 indicating global scope.

For example, the MAC address 00-05-9A-3C-78-00 is converted to EUI-64 format interface identifier as follows-

00-05-9A-3C-78-00 can be written in binary as 00000000 00000101 10011010 00111100 01111000 00000000.
                                                                              ^=U/L bit
Now, we insert 0xFF and 0xFE between 9A and 3C, and also set the U/L bit to 1. This converts to-

00000010 00000101 10010101 11111111 11111110 00111100 01111000 00000000 which in hexadecimal form is 02-05-9A-FF-FE-3C-78-00.

# 2.5.2.  The Unspecified Address
The address 0:0:0:0:0:0:0:0 is called the unspecified address.  It must never be assigned to any node.  It indicates the absence of an address.

# 2.5.3.  The Loopback Address
The unicast address 0:0:0:0:0:0:0:1 is called the loopback address.  It may be used by a node to send an IPv6 packet to itself.  It must not be assigned to any physical interface.

# 2.5.4.  Global Unicast Addresses
```

   |         n bits         |   m bits  |       128-n-m bits         |
   +------------------------+-----------+----------------------------+
   | global routing prefix  | subnet ID |       interface ID         |
   +------------------------+-----------+----------------------------+
```
where the global routing prefix is a (typically hierarchically-structured) value assigned to a site (a cluster of subnets/links), the subnet ID is an identifier of a link within the site, and the interface ID is as defined in Section 2.5.1.

All Global Unicast addresses other than those that start with binary 000 have a 64-bit interface ID field (i.e., n + m = 64), formatted as described in Section 2.5.1.  Global Unicast addresses that start with binary 000 have no such constraint on the size or structure of the interface ID field.
 
# 2.5.5.1.  IPv4-Compatible IPv6 Address
The format of the "IPv4-Compatible IPv6 address" is as follows:
```
   |                80 bits               | 16 |      32 bits        |
   +--------------------------------------+--------------------------+
   |0000..............................0000|0000|    IPv4 address     |
   +--------------------------------------+----+---------------------+
```
Note: The IPv4 address used in the "IPv4-Compatible IPv6 address" must be a globally-unique IPv4 unicast address.

The "IPv4-Compatible IPv6 address" is now deprecated because the current IPv6 transition mechanisms no longer use these addresses.

# 2.5.5.2.  IPv4-Mapped IPv6 Address
This address type is used to represent the addresses of IPv4 nodes as IPv6 addresses.
```
   |                80 bits               | 16 |      32 bits        |
   +--------------------------------------+--------------------------+
   |0000..............................0000|FFFF|    IPv4 address     |
   +--------------------------------------+----+----------------
```
# 2.5.6.  Link-Local IPv6 Unicast Addresses
```
   |   10     |
   |  bits    |         54 bits         |          64 bits           |
   +----------+-------------------------+----------------------------+
   |1111111010|           0             |       interface ID         |
   +----------+-------------------------+----------------------------+
```
Link-Local addresses are designed to be used for addressing on a single link for purposes such as automatic address configuration, neighbor discovery, or when no routers are present.
Routers must not forward any packets with Link-Local source or destination addresses to other links.

# 2.5.7.  Site-Local IPv6 Unicast Addresses
Site-Local addresses were originally designed to be used for addressing inside of a site without the need for a global prefix.  Site-local addresses are now deprecated as defined in [SLDEP].
```
   |   10     |
   |  bits    |         54 bits         |         64 bits            |
   +----------+-------------------------+----------------------------+
   |1111111011|        subnet ID        |       interface ID         |
   +----------+-------------------------+----------------------------+
```
The special behavior of this prefix defined in [RFC3513] must no longer be supported in new implementations (i.e., new implementations must treat this prefix as Global Unicast).

# 2.6.  Anycast Addresses
An IPv6 anycast address is an address that is assigned to more than one interface (typically belonging to different nodes), with the property that a packet sent to an anycast address is routed to the "nearest" interface having that address, according to the routing protocols' measure of distance.

Anycast addresses are allocated from the unicast address space, using any of the defined unicast address formats.  Thus, anycast addresses are syntactically indistinguishable from unicast addresses.
When a unicast address is assigned to more than one interface, thus turning it into an anycast address, the nodes to which the address is assigned must be explicitly configured to know that it is an anycast address.

For any assigned anycast address, there is a longest prefix P of that address that identifies the topological region in which all interfaces belonging to that anycast address reside.  
Within the region identified by P, the anycast address must be maintained as a separate entry in the routing system (commonly referred to as a "host route"); outside the region identified by P, the anycast address may be aggregated into the routing entry for prefix P.

Note that in the worst case, the prefix P of an anycast set may be the null prefix, i.e., the members of the set may have no topological locality.  
In that case, the anycast address must be maintained as a separate routing entry throughout the entire Internet, which presents a severe scaling limit on how many such "global" anycast sets may be supported.

One expected use of anycast addresses is to identify the set of routers belonging to an organization providing Internet service.
Such addresses could be used as intermediate addresses in an IPv6 Routing header, to cause a packet to be delivered via a particular service provider or sequence of service providers.

Some other possible uses are to identify the set of routers attached to a particular subnet, or the set of routers providing entry into a  particular routing domain.

# 2.6.1.  Required Anycast Address
The Subnet-Router anycast address is predefined.  Its format is as follows:
```
   |                         n bits                 |   128-n bits   |
   +------------------------------------------------+----------------+
   |                   subnet prefix                | 00000000000000 |
   +------------------------------------------------+----------------+
```
The "subnet prefix" in an anycast address is the prefix that identifies a specific link.  This anycast address is syntactically the same as a unicast address for an interface on the link with the interface identifier set to zero.

Packets sent to the Subnet-Router anycast address will be delivered to one router on the subnet.  All routers are required to support the Subnet-Router anycast addresses for the subnets to which they have interfaces.

The Subnet-Router anycast address is intended to be used for applications where a node needs to communicate with any one of the set of routers.

# 2.7.  Multicast Addresses
An interface may belong to any number of multicast groups.  Multicast addresses have the following format:
```
   |   8    |  4 |  4 |                  112 bits                   |
   +------ -+----+----+---------------------------------------------+
   |11111111|flgs|scop|                  group ID                   |
   +--------+----+----+---------------------------------------------+
```
binary 11111111 at the start of the address identifies the address as being a multicast address.
                                    +-+-+-+-+
      flgs is a set of 4 flags:     |0|R|P|T|
                                    +-+-+-+-+

The high-order flag is reserved, and must be initialized to 0.

T = 0 indicates a permanently-assigned ("well-known") multicast address, assigned by the Internet Assigned Numbers Authority (IANA).
T = 1 indicates a non-permanently-assigned ("transient" or "dynamically" assigned) multicast address.
The P flag's definition and usage can be found in [RFC3306].
The R flag's definition and usage can be found in [RFC3956].

scop is a 4-bit multicast scope value used to limit the scope of the multicast group.  The values are as follows:
```
         0  reserved
         1  Interface-Local scope
         2  Link-Local scope
         3  reserved
         4  Admin-Local scope
         5  Site-Local scope
         6  (unassigned)
         7  (unassigned)
         8  Organization-Local scope
         9  (unassigned)
         A  (unassigned)
         B  (unassigned)
         C  (unassigned)
         D  (unassigned)
         E  Global scope
         F  reserved
```
Interface-Local scope spans only a single interface on a node and is useful only for loopback transmission of multicast.
Link-Local multicast scope spans the same topological region as the corresponding unicast scope.
Admin-Local scope is the smallest scope that must be administratively configured, i.e., not automatically derived from physical connectivity or other, non-multicast-related configuration.
Site-Local scope is intended to span a single site.
Organization-Local scope is intended to span multiple sites belonging to a single organization.
scopes labeled "(unassigned)" are available for administrators to define additional multicast regions.

# 2.7.1.  Pre-Defined Multicast Addresses
```
      Reserved Multicast Addresses:   FF00:0:0:0:0:0:0:0
                                      FF01:0:0:0:0:0:0:0
                                      FF02:0:0:0:0:0:0:0
                                      FF03:0:0:0:0:0:0:0
                                      FF04:0:0:0:0:0:0:0
                                      FF05:0:0:0:0:0:0:0
                                      FF06:0:0:0:0:0:0:0
                                      FF07:0:0:0:0:0:0:0
                                      FF08:0:0:0:0:0:0:0
                                      FF09:0:0:0:0:0:0:0
                                      FF0A:0:0:0:0:0:0:0
                                      FF0B:0:0:0:0:0:0:0
                                      FF0C:0:0:0:0:0:0:0
                                      FF0D:0:0:0:0:0:0:0
                                      FF0E:0:0:0:0:0:0:0
                                      FF0F:0:0:0:0:0:0:0
```
The above multicast addresses are reserved and shall never be assigned to any multicast group.
```
      All Nodes Addresses:    FF01:0:0:0:0:0:0:1
                              FF02:0:0:0:0:0:0:1
```
The above multicast addresses identify the group of all IPv6 nodes, within scope 1 (interface-local) or 2 (link-local).
```
      All Routers Addresses:   FF01:0:0:0:0:0:0:2
                               FF02:0:0:0:0:0:0:2
                               FF05:0:0:0:0:0:0:2
```
The above multicast addresses identify the group of all IPv6 routers, within scope 1 (interface-local), 2 (link-local), or 5 (site-local).
```
      Solicited-Node Address:  FF02:0:0:0:0:1:FFXX:XXXX
```
Solicited-Node multicast address are computed as a function of a node's unicast and anycast addresses.  A Solicited-Node multicast address is formed by taking the low-order 24 bits of an address(unicast or anycast) and appending those bits to the prefix FF02:0:0:0:0:1:FF00::/104 resulting in a multicast address in the range
```
         FF02:0:0:0:0:1:FF00:0000
   to
         FF02:0:0:0:0:1:FFFF:FFFF
```
For example, the Solicited-Node multicast address corresponding to the IPv6 address 4037::01:800:200E:8C6C is FF02::1:FF0E:8C6C.  IPv6  addresses that differ only in the high-order bits (e.g., due to multiple high-order prefixes associated with different aggregations)

# 2.8.  A Node's Required Addresses
A host is required to recognize the following addresses as identifying itself:
```
      o Its required Link-Local address for each interface.

      o Any additional Unicast and Anycast addresses that have been
        configured for the node's interfaces (manually or
        automatically).

      o The loopback address.

      o The All-Nodes multicast addresses defined in Section 2.7.1.

      o The Solicited-Node multicast address for each of its unicast and
        anycast addresses.

      o Multicast addresses of all other groups to which the node
        belongs.
```
A router is required to recognize all addresses that a host is required to recognize, plus the following addresses as identifying itself:
```
      o The Subnet-Router Anycast addresses for all interfaces for which
        it is configured to act as a router.

      o All other Anycast addresses with which the router has been
        configured.

      o The All-Routers multicast addresses defined in Section 2.7.1.
```

Reference
==============================
* [Internet Protocol Version 6 (IPv6) Addressing Architecture, RFC3531, April 2003](https://tools.ietf.org/html/rfc3513)
* [IP Version 6 Addressing Architecture, RFC4291, February 2006](https://tools.ietf.org/html/rfc4291)
* [[GLOBAL] "IPv6 Global Unicast Address Format", RFC 3587, August 2003](https://tools.ietf.org/html/rfc3587)

* []()
![alt tag]()
