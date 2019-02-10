# What is Software Defined Networking (SDN)? Definition
The goal of Software-Defined Networking (SDN) is to enable cloud computing and network engineers and administrators to respond quickly to changing business requirements via a centralized control console. 
SDN encompasses multiple kinds of network technologies designed to make the network more flexible and agile to support the virtualized server and storage infrastructure of the modern data center. 
Software-defined networking originally defined an approach to designing, building, and managing networks that separates the network’s control or SDN network policy (brains) and forwarding (muscle) planes thus enabling the network control to become directly programmable and the underlying infrastructure to be abstracted for applications and network services for applications as SDN cloud computing or mobile networks.

How Does Software-Defined Networking Work?
-------------------------------------------------
![alt tag](https://www.sdxcentral.com/wp-content/uploads/2013/08/SDN-Framework1.jpg)

All software-defined network solutions have some version of an SDN Controller, as well as southbound APIs and northbound APIs:
```
    Controllers: The “brains” of the network, SDN Controllers offer a centralized view of the overall network, and enable network
                  administrators to dictate to the underlying systems (like switches and routers) how the forwarding plane should handle
                  network traffic.
                  
    Southbound APIs: Software-defined networking uses southbound APIs to relay information to the switches and routers “below.” 
                    OpenFlow, considered the first standard in SDN, was the original southbound API and remains as one of the most common
                    protocols. Despite some considering OpenFlow and SDN to be one in the same, OpenFlow is merely one piece of the bigger
                    landscape.
                    
    Northbound APIs: Software-Defined Networking uses northbound APIs to communicates with the applications and business logic “above.” 
                    These help network administrators to programmatically shape traffic and deploy services.
```

Software-Defined Networking is Not OpenFlow
-------------------------------------------------
Often people point to OpenFlow as being synonymous with software-defined networking, but it is only a single element in the overall SDN architecture. 
OpenFlow is an open standard for a communications protocol that enables the control plane to interact with the forwarding plane. It must be noted that OpenFlow is not the only protocol available or in development for SDN.

# What are SDN Controllers (or SDN Controllers Platforms)?
SDN Controllers (aka SDN Controller Platforms) in a software-defined network (SDN) is the “brains” of the network. It is the application that acts as a strategic control point in the SDN network, manage flow control to the switches/routers ‘below’ (via southbound APIs) and the applications and business logic ‘above’ (via northbound APIs) to deploy intelligent networks.  
Recently, as organizations deploy more SDN networks, the Controllers have been tasked with federating between SDN Controller domains, using common application interfaces, such as OpenFlow and open virtual switch database [OVSDB](http://docs.openvswitch.org/en/latest/).

Two of the most well-known protocols used by SDN Controllers to communicate with the switches/routers is [OpenFlow](https://www.opennetworking.org/wp-content/uploads/2014/10/openflow-spec-v1.3.0.pdf) and OVSDB. 
Other protocols that could be used by an SDN Controller is YANG or NetConf. 
Other SDN Controller protocols are being developed, while more established networking protocols are finding ways to run in an SDN environment. For example, the Internet Engineering Task Force (IETF) working group – the Interface to the Routing System [i2rs](https://datatracker.ietf.org/wg/i2rs/documents/) – developed an SDN standard that enables an SDN Controller to leverage proven, traditional protocols, such as OSPF, MPLS, BGP, and IS-IS.

![alt tag](https://www.ixiacom.com/sites/default/files/inline-images/NETCONF-YANG.png)
```
        Network diagram of a NETCONF management system
```
```
The motivation behind NETCONF and YANG was, instead of individual devices with functionalities, to have a network management system that manages the network at the service level that includes: 

    Standardized data model (YANG)
    Network-wide configuration transactions
    Validation and roll-back of configuration
    Centralized backup and restore configuration

Businesses have used SNMP for a long time, but it was being used more for reading device states than for configuring devices. NETCONF and YANG address the shortcomings of SNMP and add more functionalities in network management
```

# What is SDN Orchestration (SDN Policy Orchestration)?
Software-defined networking (SDN) orchestration (or SDN orchestration or SDN policy orchestration) is the ability to program automated behaviors in a network to coordinate the required networking hardware and software elements to support applications and services.

Got SDN Policy Orchestration
-------------------------------------------------
SDN orchestration often involves coordinating software actions with an SDN Controller, which can be built using open source technology such as OpenDaylight.

# What are SDN Northbound APIs (and SDN Rest APIs)?

![alt tag](https://www.sdxcentral.com/wp-content/uploads/2013/08/sdn-framework.jpg)
In a software-defined network (SDN) architecture, the northbound application program interfaces (APIs) are usually SDN Rest APIs used to communicate between the SDN Controller and the services and applications running over the network.

How Do Northbound APIs Work?
-------------------------------------------------
Because they are so critical, northbound APIs must support a wide variety of applications, so one size will likely not fit all. This is possibly why SDN northbound APIs are currently the most nebulous component in an SDN environment — a variety of possible interfaces exist in different places up the stack to control different types of applications via an SDN Controller.

SDN Northbound APIs (or SDN Rest APIs) are also used to integrate the SDN Controller with automation stacks, such as Puppet, Chef, SaltStack, Ansible and CFEngine, as well as orchestration platforms, such as [OpenStack](https://www.openstack.org/), VMware’s vCloudDirector or the open source CloudStack(https://cloudstack.apache.org/).

Recently, the Open Networking Foundation (ONF) turned its focus to the SDN northbound API.

# What are SDN Southbound APIs?
In a software-defined network (SDN) architecture, southbound application program interfaces (APIs) (or SDN southbound APIs) are used to communicate between the SDN Controller and the switches and routers of the network. They can be open or proprietary.

How Do SDN Southbound APIs Work?
-------------------------------------------------
Southbound APIs facilitate efficient control over the network and enable the SDN Controller to dynamically make changes according to real-time demands and needs.

![alt tag](https://www.opendaylight.org/wp-content/uploads/sites/14/2018/09/Screen-Shot-2018-09-13-at-3.15.43-PM.png)

# What is Ryu Controller?
In general, the SDN Controller is the brains of the SDN environment, communicating information down to the switches and routers with southbound APIs, and up to the applications and business logic with northbound APIs. The Ryu Controller is supported by NTT and is deployed in NTT cloud data centers as well.

Written entirely in Python, all of Ryu’s code is available under the Apache 2.0 license and open for anyone to use. The Ryu Controller supports NETCONF and OF-config network management protocols, as well as OpenFlow, which is one of the first and most widely deployed SDN communications standards.  It also supports Nicira extensions.

Reference
==============================
* [5分でわかる、これまでのSDN動向](https://qiita.com/ttsubo/items/9062addd7c24d5adfcf3)
* [SDN 温故知新](https://qiita.com/hichihara/items/d6ede5ec8ad0ae35b9e1)
* [What is Software Defined Networking (SDN)? Definition](https://www.sdxcentral.com/sdn/definitions/what-the-definition-of-software-defined-networking-sdn/)
* [What are SDN Controllers (or SDN Controllers Platforms)?](https://www.sdxcentral.com/sdn/definitions/sdn-controllers/)
* [What is SDN Orchestration (SDN Policy Orchestration)?](https://www.sdxcentral.com/sdn/definitions/what-is-sdn-orchestration/)
* [What is Ryu Controller?](https://www.sdxcentral.com/sdn/definitions/sdn-controllers/open-source-sdn-controllers/what-is-ryu-controller/)
* [Ryu, Home](https://github.com/osrg/ryu/wiki)

* [Network Configuration Protocol (NETCONF), RFC6241, June 2011](https://tools.ietf.org/html/rfc6241)
* [YANG - A Data Modeling Language for the Network Configuration Protocol (NETCONF), RFC6020, October 2010](https://tools.ietf.org/html/rfc6020)
* [SDN and Orchestration, NETCONF and YANG, OPENFLOW and NFV 2016/2/3](https://www.linkedin.com/pulse/sdn-orchestration-netconf-yang-openflow-nfv-harinder-bakhshi)
* [Open vSwitch Database(OVSDB)](http://docs.openvswitch.org/en/latest/ref/ovsdb.5/)
* [The Open vSwitch Database Management Protocol, RFC7047, December 2013](https://tools.ietf.org/html/rfc7047)


* []()
![alt tag]()
