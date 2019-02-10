# What is Software Defined Networking (SDN)? Definition
The goal of Software-Defined Networking (SDN) is to enable cloud computing and network engineers and administrators to respond quickly to changing business requirements via a centralized control console. 
SDN encompasses multiple kinds of network technologies designed to make the network more flexible and agile to support the virtualized server and storage infrastructure of the modern data center. 
Software-defined networking originally defined an approach to designing, building, and managing networks that separates the network’s control or SDN network policy (brains) and forwarding (muscle) planes thus enabling the network control to become directly programmable and the underlying infrastructure to be abstracted for applications and network services for applications as SDN cloud computing or mobile networks.

#   How Does Software-Defined Networking Work?

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

#   Software-Defined Networking is Not OpenFlow
Often people point to OpenFlow as being synonymous with software-defined networking, but it is only a single element in the overall SDN architecture. 
OpenFlow is an open standard for a communications protocol that enables the control plane to interact with the forwarding plane. It must be noted that OpenFlow is not the only protocol available or in development for SDN.

Reference
==============================
* [5分でわかる、これまでのSDN動向](https://qiita.com/ttsubo/items/9062addd7c24d5adfcf3)
* [SDN 温故知新](https://qiita.com/hichihara/items/d6ede5ec8ad0ae35b9e1)
* [What is Software Defined Networking (SDN)? Definition](https://www.sdxcentral.com/sdn/definitions/what-the-definition-of-software-defined-networking-sdn/)

* []()
![alt tag]()
