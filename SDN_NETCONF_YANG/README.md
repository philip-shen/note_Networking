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

# REST API HTTP Method
![alt tag](https://image.slidesharecdn.com/pragmaticrestapis-140926223102-phpapp01/95/pragmatic-rest-apis-16-638.jpg?cb=1411771376)

```
7.1.  <get-config>
```
Description:  Retrieve all or part of a specified configuration datastore.

Parameters:

      source:  Name of the configuration datastore being queried, such as 
```   
      <running/>.
```
Example:  To retrieve the entire <users> subtree:

```
     <rpc message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <get-config>
         <source>
           <running/>
         </source>
         <filter type="subtree">
           <top xmlns="http://example.com/schema/1.2/config">
             <users/>
           </top>
         </filter>
       </get-config>
     </rpc>

     <rpc-reply message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <data>
         <top xmlns="http://example.com/schema/1.2/config">
           <users>
             <user>
               <name>root</name>
               <type>superuser</type>
               <full-name>Charlie Root</full-name>
               <company-info>
                 <dept>1</dept>
                 <id>1</id>
               </company-info>
             </user>
             <!-- additional <user> elements appear here... -->
           </users>
         </top>
       </data>
     </rpc-reply>   
```

```
7.2.  <edit-config>
```
Description:
      The operation loads all or part of a specified configuration to the specified target configuration datastore.
      This operation allows the new configuration to be expressed in several ways, such as using a local file, a remote file, or
      inline.  If the target configuration datastore does not exist, it will be created.

Attributes:
      operation:"operation" attribute, which belongs to the NETCONF namespace defined in Section 3.1.
      The "operation" attribute has one of the following values:
      
      merge:  The configuration data identified by the element containing this attribute is merged with the configuration
            at the corresponding level in the configuration datastore identified by the <target> parameter.  This is the default            
            behavior.

      replace:  The configuration data identified by the element containing this attribute replaces any related configuration            
            in the configuration datastore identified by the <target> parameter.  If no such configuration data exists in the            
            configuration datastore, it is created.  Unlike a <copy-config> operation, which replaces the entire target            
            configuration, only the configuration actually present in the <config> parameter is affected.            

      create:  The configuration data identified by the element containing this attribute is added to the configuration if            
            and only if the configuration data does not already exist in the configuration datastore.  If the configuration data
            exists, an <rpc-error> element is returned with an<error-tag> value of "data-exists".

      delete:  The configuration data identified by the element containing this attribute is deleted from the configuration            
            if and only if the configuration data currently exists in the configuration datastore.  If the configuration data does            
            not exist, an <rpc-error> element is returned with an <error-tag> value of "data-missing".

      remove:  The configuration data identified by the element containing this attribute is deleted from the configuration
            if the configuration data currently exists in the configuration datastore.  If the configuration data does not
            exist, the "remove" operation is silently ignored by the server.

Parameters:

    target:   
    default-operation:
    The <default-operation> parameter is optional, but if provided, it has one of the following values:
    merge:  
    replace:  
    none:  

Example:  The <edit-config> examples in this section utilize a simple data model, in which multiple instances of the <interface> element      
      can be present, and an instance is distinguished by the <name> element within each <interface> element.

      Set the MTU to 1500 on an interface named "Ethernet0/0" in the running configuration:
```
     <rpc message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <edit-config>
         <target>
           <running/>
         </target>
         <config>
           <top xmlns="http://example.com/schema/1.2/config">
             <interface>
               <name>Ethernet0/0</name>
               <mtu>1500</mtu>
             </interface>
           </top>
         </config>
       </edit-config>
     </rpc>

     <rpc-reply message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <ok/>
     </rpc-reply>
```

```
7.3.  <copy-config>
```
Description:  Create or replace an entire configuration datastore with the contents of another complete configuration datastore.  If
      the target datastore exists, it is overwritten.  Otherwise, a new one is created, if allowed.
      
```
7.4.  <delete-config>
```
Description:  Delete a configuration datastore.  The <running> configuration datastore cannot be deleted.

```
7.5.  <lock>
```
Description:  The <lock> operation allows the client to lock the entire configuration datastore system of a device.  Such locks are
      intended to be short-lived and allow a client to make a change without fear of interaction with other NETCONF clients, non-
      NETCONF clients (e.g., SNMP and command line interface (CLI) scripts), and human users.

Example:  The following example shows a successful acquisition of a lock.
```
     <rpc message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <lock>
         <target>
           <running/>
         </target>
       </lock>
     </rpc>

     <rpc-reply message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <ok/> <!-- lock succeeded -->
     </rpc-reply>
```

Example:  The following example shows a failed attempt to acquire a lock when the lock is already in use.
```
     <rpc message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <lock>
         <target>
           <running/>
         </target>
       </lock>
     </rpc>

     <rpc-reply message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <rpc-error> <!-- lock failed -->
         <error-type>protocol</error-type>
         <error-tag>lock-denied</error-tag>
         <error-severity>error</error-severity>
         <error-message>
           Lock failed, lock is already held
         </error-message>
         <error-info>
           <session-id>454</session-id>
           <!-- lock is held by NETCONF session 454 -->
         </error-info>
       </rpc-error>
     </rpc-reply>
```

```
7.6.  <unlock>
```
Description:  The <unlock> operation is used to release a configuration lock, previously obtained with the <lock> operation.
   
Example:
```
     <rpc message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <unlock>
         <target>
          <running/>
         </target>
       </unlock>
     </rpc>

     <rpc-reply message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <ok/>
     </rpc-reply>
```

```
7.7.  <get>
```
Description:  Retrieve running configuration and device state information.

Example:
```
     <rpc message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <get>
         <filter type="subtree">
           <top xmlns="http://example.com/schema/1.2/stats">
             <interfaces>
               <interface>
                 <ifName>eth0</ifName>
               </interface>
             </interfaces>
           </top>
         </filter>
       </get>
     </rpc>

     <rpc-reply message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <data>
         <top xmlns="http://example.com/schema/1.2/stats">
           <interfaces>
             <interface>
               <ifName>eth0</ifName>
               <ifInOctets>45621</ifInOctets>
               <ifOutOctets>774344</ifOutOctets>
             </interface>
           </interfaces>
         </top>
       </data>
     </rpc-reply>
```

```
7.8.  <close-session>
```
Description:  Request graceful termination of a NETCONF session.

When a NETCONF server receives a <close-session> request, it will gracefully close the session.
Example:

```
     <rpc message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <close-session/>
     </rpc>

     <rpc-reply message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <ok/>
     </rpc-reply>
```
 
```
7.9.  <kill-session>
```
Description:  Force the termination of a NETCONF session.

      When a NETCONF entity receives a <kill-session> request for an open session, it will abort any operations currently in process,
      release any locks and resources associated with the session, and close any associated connections.

      If a NETCONF server receives a <kill-session> request while processing a confirmed commit (Section 8.4), it MUST restore the
      configuration to its state before the confirmed commit was issued.

Example:

     <rpc message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <kill-session>
         <session-id>4</session-id>
       </kill-session>
     </rpc>

     <rpc-reply message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <ok/>
     </rpc-reply>
     
# 8.  Capabilities
This section defines a set of capabilities that a client or a server MAY implement.  Each peer advertises its capabilities by sending them
   during an initial capabilities exchange.

A NETCONF capability is identified with a URI.  The base capabilities are defined using URNs following the method described in RFC 3553 [RFC3553].
format:

      urn:ietf:params:netconf:capability:{name}:1.x
# 8.1.  Capabilities Exchange
Capabilities are advertised in messages sent by each peer during session establishment.  When the NETCONF session is opened, each peer (both client and server) MUST send a <hello> element containing a list of that peer's capabilities.
   
# 8.2.  Writable-Running Capability
# 8.2.1.  Description
         The :writable-running capability indicates that the device supports direct writes to the <running> configuration datastore.  In
         other words, the device supports <edit-config> and <copy-config> operations where the <running> configuration is the target.
# 8.2.5.  Modifications to Existing Operations
         8.2.5.1.  <edit-config>
         The :writable-running capability modifies the <edit-config> operation to accept the <running> element as a <target>.
         
         8.2.5.2.  <copy-config>
         The :writable-running capability modifies the <copy-config> operation to accept the <running> element as a <target>.

# 8.3.  Candidate Configuration Capability
# 8.3.1.  Description
The candidate configuration capability, :candidate, indicates that the device supports a candidate configuration datastore, which is used to hold configuration data that can be manipulated without impacting the device's current configuration.

A <commit> operation MAY be performed at any time that causes the device's running configuration to be set to the value of the candidate configuration.
   
The <commit> operation effectively sets the running configuration to the current contents of the candidate configuration.   

# 8.3.4.  New Operations

      8.3.4.1.  <commit>

      Description:

         When the candidate configuration's content is complete, the configuration data can be committed, publishing the data set to         
         the rest of the device and requesting the device to conform to the behavior described in the new configuration.

      8.3.4.2.  <discard-changes>
   
      If the client decides that the candidate configuration is not to be committed, the <discard-changes> operation can be used to 
      revert the candidate configuration to the current running configuration.

# 8.3.5.  Modifications to Existing Operations
   
      8.3.5.1.  <get-config>, <edit-config>, <copy-config>, and <validate>
   
      The candidate configuration can be used as a source or target of any <get-config>, <edit-config>, <copy-config>, or 
      <validate> operation as a <source> or <target> parameter.  The <candidate> element is used to indicate the candidate configuration:

     <rpc message-id="101"
          xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <get-config>
         <source>
           <candidate/>
         </source>
       </get-config>
     </rpc>
   
      8.3.5.2.  <lock> and <unlock>
   
# 8.4.  Confirmed Commit Capability
# 8.4.1.  Description
      The :confirmed-commit:1.1 capability indicates that the server will support the <cancel-commit> operation and the <confirmed>,
      <confirm-timeout>, <persist>, and <persist-id> parameters for the <commit> operation.  See Section 8.3 for further details on the
      <commit> operation.

# 8.4.4.  New Operations
      8.4.4.1.  <cancel-commit>

      Description:
         Cancels an ongoing confirmed commit.  If the <persist-id>
         parameter is not given, the <cancel-commit> operation MUST be
         issued on the same session that issued the confirmed commit.

# 8.4.5.  Modifications to Existing Operations
      8.4.5.1.  <commit>

# 8.5.  Rollback-on-Error Capability 
# 8.5.1.  Description
      This capability indicates that the server will support the "rollback-on-error" value in the <error-option> parameter to the
      <edit-config> operation.
# 8.5.5.  Modifications to Existing Operations
      8.5.5.1.  <edit-config>
# 8.6.  Validate Capability
# 8.6.1.  Description
Validation consists of checking a complete configuration for syntactical and semantic errors before applying the configuration to the device.
If this capability is advertised, the device supports the <validate> protocol operation and checks at least for syntax errors.  In addition, this capability supports the <test-option> parameter to the <edit-config> operation and, when it is provided, checks at least for syntax errors.

# 8.6.4.  New Operations
      8.6.4.1.  <validate>

      Description:
         This protocol operation validates the contents of the specified
         configuration.

# 8.6.5.  Modifications to Existing Operations
      8.6.5.1.  <edit-config>

# 8.7.  Distinct Startup Capability
# 8.7.1.  Description
      The device supports separate running and startup configuration datastores.  The startup configuration is loaded by the device when
      it boots.  Operations that affect the running configuration will not be automatically copied to the startup configuration.  
      An explicit <copy-config> operation from the <running> to the <startup> is used to update the startup configuration to the current
      contents of the running configuration.
# 8.7.5.  Modifications to Existing Operations
# 8.7.5.1.  General   
```
   The :startup capability adds the <startup/> configuration datastore
   to arguments of several NETCONF operations.  The server MUST support
   the following additional values:

   +--------------------+--------------------------+-------------------+
   | Operation          | Parameters               | Notes             |
   +--------------------+--------------------------+-------------------+
   | <get-config>       | <source>                 |                   |
   |                    |                          |                   |
   | <copy-config>      | <source> <target>        |                   |
   |                    |                          |                   |
   | <lock>             | <target>                 |                   |
   |                    |                          |                   |
   | <unlock>           | <target>                 |                   |
   |                    |                          |                   |
   | <validate>         | <source>                 | If :validate:1.1  |
   |                    |                          | is advertised     |
   |                    |                          |                   |
   | <delete-config>    | <target>                 | Resets the device |
   |                    |                          | to its factory    |
   |                    |                          | defaults          |
   +--------------------+--------------------------+-------------------+

   To save the startup configuration, use the <copy-config> operation to
   copy the <running> configuration datastore to the <startup>
   configuration datastore.
```

# 8.8.  URL Capability
# 8.8.1.  Description
      The NETCONF peer has the ability to accept the <url> element in <source> and <target> parameters.  The capability is further
      identified by URL arguments indicating the URL schemes supported.

# 8.8.5.  Modifications to Existing Operations      
      8.8.5.1.  <edit-config>      
      8.8.5.2.  <copy-config>      
      8.8.5.3.  <delete-config>
      8.8.5.4.  <validate>

# 8.9.  XPath Capability
# 8.9.1.  Description
The XPath capability indicates that the NETCONF peer supports the use of XPath expressions in the <filter> element.  XPath is described in [W3C.REC-xpath-19991116].

# 8.9.5.  Modifications to Existing Operations

      8.9.5.1.  <get-config> and <get>
      

Reference
==============================
* [Network Configuration Protocol (NETCONF), RFC6241, June 2011](https://tools.ietf.org/html/rfc6241)
* [YANG - A Data Modeling Language for the Network Configuration Protocol (NETCONF), RFC6020, October 2010](https://tools.ietf.org/html/rfc6020)
* [An Introduction to NETCONF/YANG ](https://www.fir3net.com/Networking/Protocols/an-introduction-to-netconf-yang.html)
* [Python - How to Obtain the Configuration of a Networking Device using NETCONF](https://www.fir3net.com/Networking/Protocols/how-to-operate-a-device-using-netconf-and-python.html)
* [RESTful APIs HTTP Methods](https://restfulapi.net/http-methods/)

* []()
![alt tag]()
