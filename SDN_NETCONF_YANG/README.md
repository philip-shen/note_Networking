![alt tag](https://www.ixiacom.com/sites/default/files/inline-images/NETCONF-YANG.png)

# 1.  Introduction
The NETCONF protocol defines a simple mechanism through which a network device can be managed, configuration data information can be retrieved, and new configuration data can be uploaded and manipulated.  The protocol allows the device to expose a full, formal application programming interface (API).
The NETCONF protocol uses a remote procedure call (RPC) paradigm.  A client encodes an RPC in XML [W3C.REC-xml-20001006] and sends it to a server using a secure, connection-oriented session.  The server responds with a reply encoded in XML.
NETCONF allows a client to discover the set of protocol extensions supported by a server.  These "capabilities" permit the client to  adjust its behavior to take advantage of the features exposed by the device.  Standard and non-standard capabilities can be defined with semantic and syntactic rigor.  Capabilities are discussed in Section 8.
The NETCONF protocol is a building block in a system of automated configuration.  XML is the lingua franca of interchange, providing a  flexible but fully specified encoding mechanism for hierarchical content.  NETCONF can be used in concert with XML-based transformation technologies, such as XSLT [W3C.REC-xslt-19991116], to provide a system for automated generation of full and partial configurations.

# 1.1.  Terminology 
```
   o  candidate configuration datastore: A configuration datastore that can be manipulated without impacting the device's current
                                          configuration and that can be committed to the running configuration datastore.

   o  capability: A functionality that supplements the base NETCONF specification.

   o  client: Invokes protocol operations on a server.  In addition, a client can subscribe to receive notifications from a server.

   o  configuration data: The set of writable data that is required to transform a system from its initial default state into its current
                           state.

   o  datastore: A conceptual place to store and access information.  A datastore might be implemented, for example, using files, a
                  database, flash memory locations, or combinations thereof.

   o  configuration datastore: The datastore holding the complete set of configuration data that is required to get a device from its
                              initial default state into a desired operational state.

   o  message: A protocol element sent over a session.  Messages are well-formed XML documents.

   o  notification: A server-initiated message indicating that a certain event has been recognized by the server.

   o  protocol operation: A specific remote procedure call, as used within the NETCONF protocol.

   o  remote procedure call (RPC): Realized by exchanging <rpc> and <rpc-reply> messages.

   o  running configuration datastore: A configuration datastore holding the complete configuration currently active on the device.  The
                                       running configuration datastore always exists.

   o  server: Executes protocol operations invoked by a client.  In addition, a server can send notifications to a client.
   
   o  session: Client and server exchange messages using a secure, connection-oriented session.

   o  startup configuration datastore: The configuration datastore holding the configuration loaded by the device when it boots.
                                       Only present on devices that separate the startup configuration datastore from the running
                                       configuration datastore.

   o  state data: The additional data on a system that is not configuration data such as read-only status information and
                  collected statistics.

   o  user: The authenticated identity of the client.    
```
# 1.2.  Protocol Overview
A NETCONF session is the logical connection between a network administrator or network configuration application and a network device.

NETCONF can be conceptually partitioned into four layers as shown in Figure 1.
```

            Layer                 Example
       +-------------+      +-----------------+      +----------------+
   (4) |   Content   |      |  Configuration  |      |  Notification  |
       |             |      |      data       |      |      data      |
       +-------------+      +-----------------+      +----------------+
              |                       |                      |
       +-------------+      +-----------------+              |
   (3) | Operations  |      |  <edit-config>  |              |
       |             |      |                 |              |
       +-------------+      +-----------------+              |
              |                       |                      |
       +-------------+      +-----------------+      +----------------+
   (2) |  Messages   |      |     <rpc>,      |      | <notification> |
       |             |      |   <rpc-reply>   |      |                |
       +-------------+      +-----------------+      +----------------+
              |                       |                      |
       +-------------+      +-----------------------------------------+
   (1) |   Secure    |      |  SSH, TLS, BEEP/TLS, SOAP/HTTP/TLS, ... |
       |  Transport  |      |                                         |
       +-------------+      +-----------------------------------------+

                     Figure 1: NETCONF Protocol Layers
```

(1)  NETCONF can be layered over any transport protocol that provides a set of basic requirements.  Section 2 discusses these requirements.

(2)  The Messages layer provides a simple, transport-independent framing mechanism for encoding RPCs and notifications.  Section 4 documents the RPC messages, and [RFC5717] documents notifications.

(3)  The Operations layer defines a set of base protocol operations invoked as RPC methods with XML-encoded parameters.  Section 7 details the list of base protocol operations.
        
(4)  The Content layer is outside the scope of this document.  It is expected that separate efforts to standardize NETCONF data models will be undertaken.
The YANG data modeling language [RFC6020](https://tools.ietf.org/html/rfc6020) has been developed for specifying NETCONF data models and protocol operations, covering the Operations and the Content layers of Figure 1.

# 1.3.  Capabilities
A NETCONF capability is a set of functionality that supplements the base NETCONF specification.  The capability is identified by a uniform resource identifier (URI) [RFC3986](https://tools.ietf.org/html/rfc3896).
Section 8 defines the capabilities exchange that allows the client to discover the server's capabilities.  Section 8 also lists the set of capabilities defined in this document.

# 1.4.  Separation of Configuration and State Data
The information that can be retrieved from a running system is separated into two classes, configuration data and state data.   Configuration data is the set of writable data that is required to transform a system from its initial default state into its current state.  State data is the additional data on a system that is not configuration data such as read-only status information and collected statistics.

To account for these issues, the NETCONF protocol recognizes the difference between configuration data and state data and provides operations for each.  The <get-config> operation retrieves configuration data only, while the <get> operation retrieves configuration and state data.
   
# 2.  Transport Protocol Requirements
NETCONF uses an RPC-based communication paradigm.  A client sends a series of one or more RPC request messages, which cause the server to respond with a corresponding series of RPC reply messages.

# 2.1.  Connection-Oriented Operation
NETCONF is connection-oriented, requiring a persistent connection between peers.  This connection MUST provide reliable, sequenced data delivery.

# 2.2.  Authentication, Integrity, and Confidentiality
A NETCONF peer assumes that appropriate levels of security and confidentiality are provided independently of this document.  For example, connections could be encrypted using Transport Layer Security (TLS) [RFC5246] or Secure Shell (SSH) [RFC4251], depending on the underlying protocol.
Therefore, it is expected that the underlying protocol uses existing authentication mechanisms available on the device.  For example, a NETCONF server on a device that supports RADIUS [RFC2865] might allow the use of RADIUS to authenticate NETCONF sessions.

# 2.3.  Mandatory Transport Protocol
A NETCONF implementation MUST support the SSH transport protocol mapping [RFC6242].

# 3.  XML Considerations
XML serves as the encoding format for NETCONF, allowing complex hierarchical data to be expressed in a text format that can be read, saved, and manipulated with both traditional text tools and tools specific to XML.
All NETCONF messages MUST be well-formed XML, encoded in UTF-8 [RFC3629].

# 3.1.  Namespace
All NETCONF protocol elements are defined in the following namespace:

      urn:ietf:params:xml:ns:netconf:base:1.0

NETCONF capability names MUST be URIs [RFC3986].  NETCONF capabilities are discussed in Section 8.
   
# 3.2.  Document Type Declarations 
Document type declarations (see Section 2.8 of [W3C.REC-xml-20001006]) MUST NOT appear in NETCONF content.

# 4.  RPC Model 
The NETCONF protocol uses an RPC-based communication model.  NETCONF peers use <rpc> and <rpc-reply> elements to provide transport- protocol-independent framing of NETCONF requests and responses.

# 4.  RPC Model 
```
 4.1.  <rpc> Element 
```
The <rpc> element is used to enclose a NETCONF request sent from the client to the server.
The following example invokes the NETCONF <get> method with no parameters:
```
     <rpc message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <get/>
     </rpc>   
```
```   
4.2.  <rpc-reply> Element
```
The <rpc-reply> message is sent in response to an <rpc> message.

The <rpc-reply> element has a mandatory attribute "message-id", which is equal to the "message-id" attribute of the <rpc> for which this is a response.
   
For example:

   The following <rpc> element invokes the NETCONF <get> method and includes an additional attribute called "user-id".  Note that the
   "user-id" attribute is not in the NETCONF namespace.  The returned <rpc-reply> element returns the "user-id" attribute, as well as the
   requested content.

```
     <rpc message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0"
          xmlns:ex="http://example.net/content/1.0"
          ex:user-id="fred">
       <get/>
     </rpc>

     <rpc-reply message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0"
          xmlns:ex="http://example.net/content/1.0"
          ex:user-id="fred">
       <data>
         <!-- contents here... -->
       </data>
     </rpc-reply>   
```   
```
4.3.  <rpc-error> Element
```
The <rpc-error> element is sent in <rpc-reply> messages if an error occurs during the processing of an <rpc> request.

The <rpc-error> element includes the following information:
error-type:  Defines the conceptual layer that the error occurred.
      Enumeration.  One of: 
   
```
      *  transport (layer: Secure Transport)
      *  rpc (layer: Messages)
      *  protocol (layer: Operations)
      *  application (layer: Content)
```

error-tag:  Contains a string identifying the error condition.  See
      Appendix A for allowed values.
error-severity:  Contains a string identifying the error severity, as determined by the device.  One of:
```
     *  error
     *  warning
```
error-app-tag:
error-path:
error-message:
error-info:

Example:  An error is returned if an <rpc> element is received without a "message-id" attribute.  Note that only in this case is it acceptable for the NETCONF peer to omit the "message-id" attribute in the <rpc-reply> element.

```
     <rpc xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <get-config>
         <source>
           <running/>
         </source>
       </get-config>
     </rpc>

     <rpc-reply xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <rpc-error>
         <error-type>rpc</error-type>
         <error-tag>missing-attribute</error-tag>
         <error-severity>error</error-severity>
         <error-info>
           <bad-attribute>message-id</bad-attribute>
           <bad-element>rpc</bad-element>
         </error-info>
       </rpc-error>
     </rpc-reply>
```

Note that the data models used in the examples in this section use the <name> element to distinguish between multiple instances of the <interface> element.

```
     <rpc-reply message-id="101"
       xmlns="urn:ietf:params:xml:ns:netconf:base:1.0"
       xmlns:xc="urn:ietf:params:xml:ns:netconf:base:1.0">
       <rpc-error>
         <error-type>application</error-type>
         <error-tag>invalid-value</error-tag>
         <error-severity>error</error-severity>
         <error-path xmlns:t="http://example.com/schema/1.2/config">
           /t:top/t:interface[t:name="Ethernet0/0"]/t:mtu
         </error-path>
         <error-message xml:lang="en">
           MTU value 25000 is not within range 256..9192
         </error-message>
       </rpc-error>
       <rpc-error>
         <error-type>application</error-type>
         <error-tag>invalid-value</error-tag>
         <error-severity>error</error-severity>
         <error-path xmlns:t="http://example.com/schema/1.2/config">
           /t:top/t:interface[t:name="Ethernet1/0"]/t:address/t:name
         </error-path>
         <error-message xml:lang="en">
           Invalid IP address for interface Ethernet1/0
         </error-message>
       </rpc-error>
     </rpc-reply>   
```
```
4.4.  <ok> Element
```
The <ok> element is sent in <rpc-reply> messages if no errors or warnings occurred during the processing of an <rpc> request, and no data was returned from the operation.  For example:

```
     <rpc-reply message-id="101"
                xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <ok/>
     </rpc-reply>
```
   
4.5.  Pipelining
NETCONF <rpc> requests MUST be processed serially by the managed device.  Additional <rpc> requests MAY be sent before previous ones have been completed.
   
# 5.  Configuration Model

# 5.1.  Configuration Datastores

# 5.2.  Data Modeling
NETCONF peers exchange device capabilities when the session is initiated as described in Section 8.1.

# 5.1.  Configuration Datastores
NETCONF defines the existence of one or more configuration datastores and allows configuration operations on them.  A configuration datastore is defined as the complete set of configuration data that is required to get a device from its initial default state into a desired operational state.

NETCONF protocol operations refer to this datastore using the <running> element.
Only the <running> configuration datastore is present in the base model.  Additional configuration datastores MAY be defined by capabilities.

The capabilities in Sections 8.3 and 8.7 define the <candidate> and <startup> configuration datastores, respectively.
   
# 5.2.  Data Modeling
Data modeling and content issues are outside the scope of the NETCONF  protocol.

# 6.  Subtree Filtering
# 6.1.  Overview
XML subtree filtering is a mechanism that allows an application to select particular XML subtrees to include in the <rpc-reply> for a <get> or <get-config> operation.

# 6.4.7.  Multiple Subtrees
This filter contains three subtrees (name=root, fred, barney).

# 6.4.8.  Elements with Attribute Naming
In this example, the filter contains one containment node (<interfaces>), one attribute match expression ("ifName"), and one selection node (<interface>).
   
# 7.  Protocol Operations
The NETCONF protocol provides a small set of low-level operations to manage device configurations and retrieve device state information.
The base protocol includes the following protocol operations:
```
   o  get

   o  get-config

   o  edit-config

   o  copy-config

   o  delete-config

   o  lock

   o  unlock

   o  close-session

   o  kill-session
```
The syntax and XML encoding of the protocol operations are formally defined in the YANG module in Appendix C.  The following sections describe the semantics of each protocol operation.

# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 


Reference
==============================
* [Network Configuration Protocol (NETCONF), RFC6241, June 2011](https://tools.ietf.org/html/rfc6241)
* [YANG - A Data Modeling Language for the Network Configuration Protocol (NETCONF), RFC6020, October 2010](https://tools.ietf.org/html/rfc6020)
* [An Introduction to NETCONF/YANG ](https://www.fir3net.com/Networking/Protocols/an-introduction-to-netconf-yang.html)
* [Python - How to Obtain the Configuration of a Networking Device using NETCONF](https://www.fir3net.com/Networking/Protocols/how-to-operate-a-device-using-netconf-and-python.html)

* []()
![alt tag]()
