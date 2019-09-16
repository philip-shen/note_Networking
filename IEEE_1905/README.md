# Purpose

# Table of Contens
[Topology](#topology)  

# Topology  
[IEEE 1905](https://en.wikipedia.org/wiki/IEEE_1905)  
```
1905.1 provides a tool to get a global view of the network topology regardless of the technologies running in the home/office network.

The Abstraction Layer generates different topology messages to build this protocol's topology:

    Discovery (Message Type 0x0000) to detect direct 1905.1 neighbors
    Notification (Message Type 0x0001) to inform network devices about a topology change
    Query/Response (Message Type 0x0002 and 0x0003) to get the topology database of another 1905.1 device

The Group Address used for Discovery and Notification messages is 01:80:c2:00:00:13.[6]

To detect a non-1905.1 bridge connected between two 1905.1 devices, the Abstraction Layer also generates a LLDP message with the nearest bridge address (01:80:c2:00:00:0e) that is not propagated by 802.1D bridges.

Topology information collected by a 1905.1 device are stored in a data model accessible remotely via TR-069 protocol. 
```

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
