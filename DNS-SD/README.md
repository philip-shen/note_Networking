# Abstract  
This document specifies how DNS resource records are named and structured to facilitate service discovery.  
Given a type of service that a client is looking for, and a domain in which the client is
looking for that service, this mechanism allows clients to discover a list of named instances of 
that desired service, using standard DNS queries.  This mechanism is referred to as DNS-based Service
Discovery, or DNS-SD.  

# Table of Content  
[1.  Introduction](#1--introduction)  
[3.  Design Goals](#3--design-goals)  
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

When used with Multicast DNS, DNS-SD can provide zero-configuration operation -- just connect 
a DNS-SD/mDNS device, and its services are advertised on the local link with no further user interaction [ZC].

While many people think of "DNS" exclusively in the context of mapping host names to IP addresses, 
in fact, "the DNS is a general (if somewhat limited) hierarchical database, and can store almost any kind of data, 
for almost any purpose" [RFC2181].  By delegating the "_tcp" and "_udp" subdomains, all the workload related 
to DNS-SD can be offloaded to a different machine.  This flexibility, to handle DNS-SD on the main DNS server 
or not, at the network administrator's discretion, is one of the benefits of using DNS.

This document is written for two audiences: 
for developers creating application software that offers or accesses services on the network, 
and for developers creating DNS-SD libraries to implement the advertising and discovery mechanisms.  

# 3.  Design Goals  
Of the many properties a good service discovery protocol needs to have, three of particular importance are:

(i) The ability to query for services of a certain type in a certain logical domain, 
    and receive in response a list of named instances 
    (network browsing or "Service Instance Enumeration").

(ii) Given a particular named instance, the ability to efficiently resolve that
     instance name to the required information a client needs to actually 
     use the service, i.e., IP address and port number, at the very least
     (Service Instance Resolution).

(iii) Instance names should be relatively persistent.  If a user selects their 
      default printer from a list of available choices today, 
      then tomorrow they should still be able to print on that printer 
      -- even if the IP address and/or port number where the service resides
      have changed -- without the user (or their software) having to 
      repeat the step (i) (the initial network browsing) a second time.

These goals are discussed in more detail in the remainder of this document.  
A more thorough treatment of service discovery requirements may be found in 
"Requirements for a Protocol to Replace the AppleTalk Name Binding Protocol (NBP)" [RFC6760].
  
# 4.  Service Instance Enumeration (Browsing)  
Traditional DNS SRV records [RFC2782] are useful for locating instances of a particular type 
of service when all the instances are effectively indistinguishable and provide the same service to the
client.

For example, SRV records with the (hypothetical) name "_http._tcp.example.com." would allow a client 
to discover servers implementing the "_http._tcp" service (i.e., web servers) for the "example.com." domain.

## 4.1.  Structured Service Instance Names  
This document borrows the logical service-naming syntax and semantics from DNS SRV records, 
but adds one level of indirection.  Instead of  requesting records of type "SRV" with name 
"_ipp._tcp.example.com.", the client requests records of type "PTR" (pointer from one name to
 another in the DNS namespace) [RFC1035].   

In effect, if one thinks of the domain name "_ipp._tcp.example.com." as being analogous to 
an absolute path to a directory in a file system, then DNS-SD's PTR lookup is akin to performing 
a listing of that directory to find all the entries it contains.  

The result of this PTR lookup for the name "<Service>.<Domain>" is a set of zero or more 
PTR records giving Service Instance Names of the form:
      Service Instance Name = <Instance> . <Service> . <Domain>

### 4.1.1.  Instance Names  
The <Instance> portion of the Service Instance Name is a user-friendly name consisting of 
arbitrary Net-Unicode text [RFC5198].

The <Instance> portion of the name of a service being offered on the network SHOULD be 
configurable by the user setting up the service, so that he or she may give it an informative name.

This <Instance> portion of the Service Instance Name is stored directly in the DNS as 
a single DNS label of canonical precomposed UTF-8 [RFC3629] "Net-Unicode" 
(Unicode Normalization Form C) [RFC5198] text.

DNS labels are currently limited to 63 octets in length.  

### 4.1.2.  Service Names   
The <Service> portion of the Service Instance Name consists of a pair of DNS labels, 
following the convention already established for SRV records [RFC2782].  
The first label of the pair is an underscore character followed by the Service Name [RFC6335].  
The Service Name identifies what the service does and what application protocol it uses to do it.  
The second label is either "_tcp" (for application protocols that run over TCP) or 
"_udp" (for all others).  For more details, see Section 7, "Service Names".
   
### 4.1.3.  Domain Names  
The <Domain> portion of the Service Instance Name specifies the DNS subdomain within which 
those names are registered.  It may be "local.", meaning "link-local Multicast DNS" [RFC6762], 
or it may be a conventional Unicast DNS domain name, such as "ietf.org.", "cs.stanford.edu.", 
or "eng.us.ibm.com."

## 4.2.  User Interface Presentation   

## 4.3.  Internal Handling of Names  
If client software takes the <Instance>, <Service>, and <Domain> portions of a Service Instance Name 
and internally concatenates them together into a single string, then because the <Instance> portion is
allowed to contain any characters, including dots, appropriate precautions MUST be taken to ensure that 
DNS label boundaries are properly preserved.  Client software can do this in a variety of ways, 
such as character escaping.

# 5.  Service Instance Resolution
When a client needs to contact a particular service, identified by a Service Instance Name, 
previously discovered via Service Instance Enumeration (browsing), 
it queries for the SRV and TXT records of that name.  
*The SRV record for a service gives the port number and target host name where the service may be found.*  
*The TXT record  gives additional information about the service,* 
as described in Section 6, "Data Syntax for DNS-SD TXT Records".  

SRV records are extremely useful because they remove the need for preassigned port numbers.  
There are only 65535 TCP port numbers available.  
These port numbers are traditionally allocated one per application protocol [RFC6335].  
Some protocols like the X Window System have a block of 64 TCP ports allocated (6000-6063).

# 6.  Data Syntax for DNS-SD TXT Records  
Some services discovered via Service Instance Enumeration may  more than just an IP address 
and port number to completely identify the service instance.  For example, printing via the old Unix LPR
   (port 515) protocol [RFC1179] often specifies a queue name [BJP]. This queue name is typically 
short and cryptic, and need not be shown to the user.  

Every DNS-SD service MUST have a TXT record in addition to its SRV record, with the same name, 
even if the service has no additional data to store and the TXT record contains no more than 
a single zero byte.

Note that this requirement for a mandatory TXT record applies exclusively to DNS-SD service advertising, 
i.e., services advertised using the PTR+SRV+TXT convention specified in this document.  

## 6.1.  General Format Rules for DNS TXT Records  
## 6.2.  DNS-SD TXT Record Size  
The total size of a typical DNS-SD TXT record is intended to be small -- 200 bytes or less.

## 6.3.  DNS TXT Record Format Rules for Use in DNS-SD  
DNS-SD uses DNS TXT records to store arbitrary key/value pairs conveying additional information 
about the named service.  Each key/value pair is encoded as its own constituent string within the
DNS TXT record, in the form "key=value" (without the quotation marks).  
Everything up to the first '=' character is the key (Section 6.4).  
Everything after the first '=' character to the end of the string (including subsequent
'=' characters, if any) is the value (Section 6.5).

## 6.4.  Rules for Keys in DNS-SD Key/Value Pairs  
The key MUST be at least one character.  DNS-SD TXT record strings beginning with an '=' character 
(i.e., the key is missing) MUST be silently ignored.

## 6.5.  Rules for Values in DNS-SD Key/Value Pairs  
If there is an '=' in a DNS-SD TXT record string, then everything after the first '=' to the end 
of the string is the value.  The value can contain any eight-bit values including '='.  
The value MUST NOT be enclosed in additional quotation marks or any similar punctuation; any quotation marks, 
or leading or trailing spaces, are part of the value.

## 6.6.  Example TXT Record  
## 6.7.  Version Tag  
## 6.8.  Service Instances with Multiple TXT Records  

# 7.  Service Names  
The <Service> portion of a Service Instance Name consists of a pair of DNS labels, 
following the convention already established for SRV records [RFC2782].

The first label of the pair is an underscore character followed by the Service Name [RFC6335].  
The Service Name identifies what the service does and what application protocol it uses to do it.

For applications using TCP, the second label is "_tcp". 

For applications using any transport protocol other than TCP, the second label is "_udp".  
This applies to all other transport  protocols, including User Datagram Protocol (UDP), 
Stream Control Transmission Protocol (SCTP) [RFC4960], Datagram Congestion Control Protocol (DCCP) [RFC4340], 
Adobe's Real Time Media Flow Protocol (RTMFP), etc.  

## 7.1.  Selective Instance Enumeration (Subtypes)   
## 7.2.  Service Name Length Limits  

# 8.  Flagship Naming  
# 9.  Service Type Enumeration  
# 10.  Populating the DNS with Information  
# 11.  Discovery of Browsing and Registration Domains (Domain Enumeration)  
# 12.  DNS Additional Record Generation  
## 12.1.  PTR Records  
## 12.2.  SRV Records  
## 12.3.  TXT Records  

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
