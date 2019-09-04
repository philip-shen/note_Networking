# Abstract  
This document specifies how DNS resource records are named and structured to facilitate service discovery.  
Given a type of service that a client is looking for, and a domain in which the client is
looking for that service, this mechanism allows clients to discover a list of named instances of 
that desired service, using standard DNS queries.  This mechanism is referred to as DNS-based Service
Discovery, or DNS-SD.  

# Table of Content  
[]()  
[]()  
[]()  
[]()  

# 1.  Introduction  
This document specifies how DNS resource records are named and structured to facilitate service discovery.  
Given a type of service that a client is looking for, and a domain in which the client is looking for 
that service, this mechanism allows clients to discover a list of named instances of that desired service, 
using standard DNS queries.  This mechanism is referred to as DNS-based Service Discovery, or DNS-SD.  

This document proposes no change to the structure of DNS messages, and no new operation codes, 
response codes, resource record types, or any other new DNS protocol values.  

his document specifies that a particular service instance can be described using 
a DNS SRV [RFC2782](https://tools.ietf.org/html/rfc2782) and DNS TXT [RFC1035](https://tools.ietf.org/html/rfc1035) record.
The SRV record has a name of the form "<Instance>.<Service>.<Domain>" and gives 
the target host and port where the service instance can be reached.  
The DNS TXT record of the same name gives additional information about this instance, in a structured 
form using key/value  pairs, described in Section 6.
A client discovers the list of available instances of a given service type using a query for a 
DNS PTR [RFC1035](https://tools.ietf.org/html/rfc1035) record with a name of the form "<Service>.<Domain>",  which returns a set of zero or 
more names, which are the names of the aforementioned DNS SRV/TXT record pairs.

# Troubleshooting


# Reference


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
