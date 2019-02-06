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

# 9.  Extensibility - Option Processing
# 9.  Extensibility - Option Processing
# 9.  Extensibility - Option Processing

Reference
==============================
* [IP Version 6 Addressing Architecture, RFC4291, February 2006](https://tools.ietf.org/html/rfc4291)

* []()
![alt tag]()
