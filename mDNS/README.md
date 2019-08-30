# Abstract  
Multicast DNS (mDNS) provides the ability to perform DNS-like operations on the local link 
in the absence of any conventional Unicast DNS server.  
In addition, Multicast DNS designates a portion of the DNS namespace to be free for local use, 
without the need to pay any annual fee, and without the need to set up delegations or otherwise 
configure a conventional DNS server to answer for those names.

The primary benefits of Multicast DNS names are that 
(i) they require little or no administration or configuration to set them up, 
(ii) they work when no infrastructure is present, and 
(iii) they work during infrastructure failures.

# Table of Content  
[1.  Introduction](#1--introduction)  
[3.  Multicast DNS Names](#3--multicast-dns-names)  
[4.  Reverse Address Mapping](#4--reverse-address-mapping)  
[5.  Querying](#5--querying)  
[6.  Responding]() 
[7.  Traffic Reduction ]() 
[8.  Probing and Announcing on Startup]() 
[9.  Conflict Resolution]() 

# 1.  Introduction  
Multicast DNS and its companion technology DNS-Based Service Discovery [RFC6763](https://tools.ietf.org/html/rfc6763) 
were created to provide IP networking with the ease-of-use and autoconfiguration for which 
AppleTalk was well-known [RFC6760].  When reading this document, familiarity with the concepts of 
Zero Configuration Networking [Zeroconf] and automatic link-local addressing [RFC3927] [RFC4862] is helpful.

Multicast DNS borrows heavily from the existing DNS protocol [RFC1034] [RFC1035] [RFC6195], using 
**the existing DNS message structure, name syntax, and resource record types.**  
This document specifies no new operation codes or response codes.  
This document describes how clients send DNS-like queries via IP multicast, and 
how a collection of hosts cooperate to collectively answer those queries in a useful manner.

# 3.  Multicast DNS Names  
A host that belongs to an organization or individual who has control over some portion of 
the DNS namespace can be assigned a globally unique name within that portion of the DNS namespace, 
such as, "cheshire.example.com.".
This leaves the majority of home computers effectively anonymous for practical purposes.

To remedy this problem, this document allows any computer user to elect to give their computers link-local Multicast DNS host names of the form: "single-dns-label.local.".

Having named their computer this way, the user has the authority to continue utilizing that name 
until such time as a name conflict occurs on the link that is not resolved in the user's favor.  
If this happens, the computer (or its human user) MUST cease using the name, and SHOULD attempt to 
allocate a new unique name for use on that link.  
These conflicts are expected to be relatively rare for people who choose reasonably imaginative names, 
but it is still important to have a mechanism in place to handle them when they happen.

This document specifies that the DNS top-level domain ".local." is a special domain with special semantics, 
namely that any fully qualified name ending in ".local." is link-local, and names within 
this domain are meaningful only on the link where they originate.

Any DNS query for a name ending with ".local." MUST be sent to the mDNS IPv4 link-local multicast 
address 224.0.0.251 (or its IPv6 equivalent FF02::FB).  
The design rationale for using a fixed multicast address instead of selecting 
from a range of multicast addresses using a hash function is discussed in Appendix B.

DNS queries for names that do not end with ".local." MAY be sent to the mDNS multicast address, 
if no other conventional DNS server is available.  This can allow hosts on the same link to continue
 communicating using each other's globally unique DNS names during network outages that 
 disrupt communication with the greater Internet.
When resolving global names via local multicast, it is even more important to use 
DNS Security Extensions (DNSSEC) [RFC4033] or other security mechanisms to ensure 
that the response is trustworthy.

This document recommends a single flat namespace for dot-local host names, 
(i.e., the names of DNS "A" and "AAAA" records, which map names to IPv4 and IPv6 addresses), 
but other DNS record types (such as those used by DNS-Based Service Discovery [RFC6763]) 
may contain as many labels as appropriate for the desired usage, up to a maximum of 255 bytes, 
plus a terminating zero byte at the end.

Enforcing uniqueness of host names is probably desirable in the common case, 
but this document does not mandate that.  It is permissible for a collection of 
coordinated hosts to agree to maintain multiple DNS address records with the same name, 
possibly for load-balancing or fault-tolerance reasons.  
In summary:
It is required that the protocol have the ability to detect and handle name conflicts, 
but it is not required that this ability be used for every record.  

# 4.  Reverse Address Mapping
Like ".local.", the IPv4 and IPv6 reverse mapping domains are also defined to be link-local:

Any DNS query for a name ending with "254.169.in-addr.arpa." MUST be sent to 
the mDNS IPv4 link-local multicast address 224.0.0.251 or the mDNS IPv6 multicast address FF02::FB.

# 5.  Querying  
There are two kinds of Multicast DNS queries: 
one-shot queries of the kind made by legacy DNS resolvers, and 
continuous, ongoing Multicast DNS queries made by fully compliant Multicast DNS queriers, 
which support asynchronous operations including DNS-Based Service Discovery [RFC6763].

## 5.1.  One-Shot Multicast DNS Queries   
The most basic kind of Multicast DNS client may simply send standard DNS queries blindly 
  the query is instead sent to 224.0.0.251:5353 (or its IPv6 equivalent [FF02::FB]:5353).  
Typically, the timeout would also be shortened to two or three seconds.  
these queries MUST NOT be sent using UDP source port 5353, since using UDP source port 
5353 signals the presence of a fully compliant Multicast DNS querier, as described below.  

A simple DNS resolver like this will typically just take the first response it receives.  It will not listen for additional UDP responses, but in many instances this may not be a serious problem.

## 5.2.  Continuous Multicast DNS Querying  
There is another type of query operation that is more asynchronous, in which having received one
 response is not necessarily an indication that there will be no more relevant responses, 
and the querying operation continues until no further responses are required.  
Determining when no further responses are required depends on the type of operation being
performed.

## 5.3.  Multiple Questions per Query  
## 5.4.  Questions Requesting Unicast Responses  
## 5.5.  Direct Unicast Queries to Port 5353

# 6.  Responding  
## 6.1.  Negative Responses  
## 6.2.  Responding to Address Queries  
## 6.3.  Responding to Multiquestion Queries  
## 6.4.  Response Aggregation  
## 6.5.  Wildcard Queries (qtype "ANY" and qclass "ANY")  
## 6.6.  Cooperating Multicast DNS Responders  
## 6.7.  Legacy Unicast Responses  

# 7.  Traffic Reduction  
## 7.1.  Known-Answer Suppression  
## 7.2.  Multipacket Known-Answer Suppression  
## 7.3.  Duplicate Question Suppression  
## 7.4.  Duplicate Answer Suppression   

# 8.  Probing and Announcing on Startup  
## 8.1.  Probing  
## 8.2.  Simultaneous Probe Tiebreaking  
### 8.2.1.  Simultaneous Probe Tiebreaking for Multiple Records  
## 8.3.  Announcing  
## 8.4.  Updating  

# 9.  Conflict Resolution  

# Troubleshooting


# Reference
* [RFC 6762 - Multicast DNS February 2013](https://tools.ietf.org/html/rfc6762)  


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
