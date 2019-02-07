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
# 9.  Extensibility - Option Processing
# 9.  Extensibility - Option Processing
# 9.  Extensibility - Option Processing
# 9.  Extensibility - Option Processing
# 9.  Extensibility - Option Processing


Reference
==============================
* [IP Version 6 Addressing Architecture, RFC4291, February 2006](https://tools.ietf.org/html/rfc4291)

* []()
![alt tag]()
