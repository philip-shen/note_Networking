# Purpose

# Table of Contens
[Topology](#topology)  
[AP auto-configuration](#ap-auto-configuration)  

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
# AP auto-configuration   
```
This feature is used to exchange Wi-Fi Simple Configuration messages over an authenticated 1905.1 link. 
Using this protocol a 1905.1 AP Enrollee can retrieve configuration parameters (like SSID) from a 1905.1 AP Registrar.
Thus AP Auto-Configuration is used to simplify the setup of a home network consisting of multiple APs – eliminating the need for the user to manually configure each AP (only a single configuration, of the AP Registrar, is required).

A specific 1905.1 CMDU frame (Message type 0x0009) is used to transport WPS messages. 
If an AP Enrollee is dual-band (2.4 GHz and 5Ghz) capable, the auto-configuration procedure may be executed twice. 
```

# Troubleshooting


# Reference

```
Title: IEEE 1905.1a
Note left of Elecom_dfe3ed: Elecom_dfe3ed(Repeater)\n(bc:5c:4c:df:e3:ed)\n Elecom_dfe3f9(Router)\n(bc:5c:4c:df:e3:f9)\n IEEE-1905.1-Control\n(01:80:c2:00:00:13)
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x032e
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x032f
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x0330
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x0331
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x0332
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x0333
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x0334
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology notification (0x0001)\nMsg id: 0x0335
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x0339
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x033a
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x033b
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x033c
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x033d
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x033e

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: AP Metrics Response (0x800c)\nMsg id: 0x033f
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x0340
```

```
Elecom_dfe3f9->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x0004
Elecom_dfe3f9->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x0005
Elecom_dfe3f9->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x0006

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Topology query (0x0002)\nMsg id: 0x0341
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology notification (0x0001)\nMsg id: 0x0342
Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Topology query (0x0002)\nMsg id: 0x0343
Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Topology query (0x0002)\nMsg id: 0x0344

Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology response (0x0003)\nMsg id: 0x0341
Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology query (0x0002)\nMsg id: 0x0007
Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology query (0x0002)\nMsg id: 0x0008
Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology notification (0x0001)\nMsg id: 0x0009

Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology response (0x0003)\nMsg id: 0x0343\nSupported service: 0x00, Multi-AP Controller

Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology query (0x0002)\nMsg id: 0x000a

Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology response (0x0003)\nMsg id: 0x0344

Note left of Elecom_dfe3ed: 1905 device information type\nDevice bridging capability\nSupported service information

Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology query (0x0002)\nMsg id: 0x000b

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Topology response (0x0003)\nMsg id: 0x0007

Note right of Elecom_dfe3f9: \n1905 device information type\nDevice bridging capability\n1905 neighbor device\nNon-1905 neighbor device list\nSupported service information\nAP operational BSS\n(AP operational BSS radio count: 2;\nAP operational BSS radio list) 

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Topology response (0x0003)\nMsg id: 0x0008

Note right of Elecom_dfe3f9: \n1905 device information type\nDevice bridging capability\n1905 neighbor device\nNon-1905 neighbor device list\nSupported service information\nAP operational BSS\n(AP operational BSS radio count: 2;\nAP operational BSS radio list) 

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Vendor specific (0x0004)\nMsg id: 0x0345

Note right of Elecom_dfe3f9: \nVendor specific\nVendor specific OUI: 00:0c:e7 (MediaTek Inc.)\nVendor specific information: 07

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Topology query (0x0002)\nMsg id: 0x0346

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Vendor specific (0x0004)\nMsg id: 0x0347

Note right of Elecom_dfe3f9: \nVendor specific\nVendor specific OUI: 00:0c:e7 (MediaTek Inc.)\nVendor specific information: 080200000000010180240000000000010054010000

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: AP Capability Query (0x8001)\nMsg id: 0x0348

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Topology response (0x0003)\nMsg id: 0x000a

Note right of Elecom_dfe3f9: \n1905 device information type\nDevice bridging capability\n1905 neighbor device\nNon-1905 neighbor device list\nSupported service information\nAP operational BSS\n(AP operational BSS radio count: 2;\nAP operational BSS radio list) 

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Vendor specific (0x0004)\nMsg id: 0x0349

Note right of Elecom_dfe3f9: \nVendor specific\nVendor specific OUI: 00:0c:e7 (MediaTek Inc.)\nVendor specific information: 07

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Vendor specific (0x0004)\nMsg id: 0x034a

Note right of Elecom_dfe3f9: \nVendor specific\nVendor specific OUI: 00:0c:e7 (MediaTek Inc.)\nVendor specific information: 080200000000010180240000000000010054010000

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Topology response (0x0003)\nMsg id: 0x000b

Note right of Elecom_dfe3f9: \n1905 device information type\nDevice bridging capability\n1905 neighbor device\nNon-1905 neighbor device list\nSupported service information\nAP operational BSS\n(AP operational BSS radio count: 2;\nAP operational BSS radio list) 

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: AP Capability Query (0x8001)\nMsg id: 0x034b

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Vendor specific (0x0004)\nMsg id: 0x034c

Note right of Elecom_dfe3f9: \nVendor specific\nVendor specific OUI: 00:0c:e7 (MediaTek Inc.)\nVendor specific information: 07

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Vendor specific (0x0004)\nMsg id: 0x034d

Note right of Elecom_dfe3f9: \nVendor specific\nVendor specific OUI: 00:0c:e7 (MediaTek Inc.)\nVendor specific information: 080200000000010180240000000000010054010000

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: AP Capability Query (0x8001)\nMsg id: 0x034e

Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology response (0x0003)\nMsg id: 0x0346

Note left of Elecom_dfe3ed: \n1905 device information type\nDevice bridging capability\n1905 neighbor device\nSupported service information\n(Supported service count: 1;\nSupported service: 0x00, Multi-AP Controller) 

Elecom_dfe3f9->Elecom_dfe3ed:Msg type: AP Capability Report (0x8002)\nMsg id: 0x0348

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Vendor specific (0x0004)\nMsg id: 0x034f

Note right of Elecom_dfe3f9: \nVendor specific\nVendor specific OUI: 00:0c:e7 (MediaTek Inc.)\nVendor specific information: 07

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Vendor specific (0x0004)\nMsg id: 0x0350

Note right of Elecom_dfe3f9: \nVendor specific\nVendor specific OUI: 00:0c:e7 (MediaTek Inc.)\nVendor specific information: 080200000000010180240000000000010054010000

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: AP Capability Query (0x8001)\nMsg id: 0x0351

Elecom_dfe3f9->Elecom_dfe3ed:Msg type: AP Capability Report (0x8002)\nMsg id: 0x034b
Elecom_dfe3f9->Elecom_dfe3ed:Msg type: AP Capability Report (0x8002)\nMsg id: 0x034e
Elecom_dfe3f9->Elecom_dfe3ed:Msg type: AP Capability Report (0x8002)\nMsg id: 0x0351
```

```
Elecom_dfe3f9->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x000c

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Topology query (0x0002)\nMsg id: 0x0352
Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology response (0x0003)\nMsg id: 0x0352

Note left of Elecom_dfe3ed: \n1905 device information type\nDevice bridging capability\n1905 neighbor device\nSupported service information\n(Supported service count: 1;\nSupported service: 0x00, Multi-AP Controller) 

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Vendor specific (0x0004)\nMsg id: 0x0353

Note right of Elecom_dfe3f9: \nVendor specific\nVendor specific OUI: 00:0c:e7 (MediaTek Inc.)\nVendor specific information: 07

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Vendor specific (0x0004)\nMsg id: 0x0354

Note right of Elecom_dfe3f9: \nVendor specific\nVendor specific OUI: 00:0c:e7 (MediaTek Inc.)\nVendor specific information: 080200000000010180240000000000010054010000

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: AP Capability Query (0x8001)\nMsg id: 0x0355

Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology response (0x0003)\nMsg id: 0x0355

Note left of Elecom_dfe3ed: \nAP capability\nAP capabilities flags: 0x00 
```

```
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x0356
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x0357
Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology notification (0x0001)\nMsg id: 0x0357

Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x0358
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x0359
Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology notification (0x0001)\nMsg id: 0x0359

Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: AP autoconfiguration search (0x0007)\nMsg id: 0x035a

Note left of Elecom_dfe3ed: \n1905 AL MAC address type\nSearchedRole\n(Searched role: 0x00, Registrar)\nAutoconfigFreqBand\n(Auto config frequency band: 0x01, 802.11 5 GHz)\nSupported service information\n(Supported service count: 1;\nSupported service: 0x00, Multi-AP Controller)\nSearched service information\n(Searched service count: 1, Searched service: 0x00, Multi-AP Controller) 

Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: AP autoconfiguration search (0x0007)\nMsg id: 0x035a

Note left of Elecom_dfe3ed: \n1905 AL MAC address type\nSearchedRole\n(Searched role: 0x00, Registrar)\nAutoconfigFreqBand\n(Auto config frequency band: 0x00, 802.11 2.4 GHz)\nSupported service information\n(Supported service count: 1;\nSupported service: 0x00, Multi-AP Controller)\nSearched service information\n(Searched service count: 1, Searched service: 0x00, Multi-AP Controller) 

Elecom_dfe3f9->IEEE_1905.1_Control:Msg type: Topology discovery (0x0000)\nMsg id: 0x000d
Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology query (0x0002)\nMsg id: 0x000e
Elecom_dfe3f9->IEEE_1905.1_Control:Msg type: Topology notification (0x0001)\nMsg id: 0x000f
Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology notification (0x0001)\nMsg id: 0x000f
Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology query (0x0002)\nMsg id: 0x0010

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Topology query (0x0002)\nMsg id: 0x035b
Elecom_dfe3ed->IEEE_1905.1_Control:Msg type: Topology notification (0x0001)\nMsg id: 0x000f
Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology query (0x0002)\nMsg id: 0x0011

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Topology response (0x0003)\nMsg id: 0x0011

Note right of Elecom_dfe3f9: \n1905 device information type\nDevice bridging capability\n1905 neighbor device\nNon-1905 neighbor device list\nSupported service information\nAP operational BSS\n(AP operational BSS radio count: 2;\nAP operational BSS radio list) 


Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology query (0x0002)\nMsg id: 0x0012

Elecom_dfe3f9->Elecom_dfe3ed:Msg type: AP autoconfiguration response (0x0008)\nMsg id: 0x035a

Note left of Elecom_dfe3ed: \nSearchedRole\n(Searched role: 0x00, Registrar)\nAutoconfigFreqBand\n(Auto config frequency band: 0x01, 802.11 5 GHz)\nSupported service information\n(Supported service count: 1;\nSupported service: 0x00, Multi-AP Controller)\nSearched service information\n(Searched service count: 1, Searched service: 0x00, Multi-AP Controller) 

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Topology response (0x0003)\nMsg id: 0x0012

Note right of Elecom_dfe3f9: \n1905 device information type\nDevice bridging capability\n1905 neighbor device\nNon-1905 neighbor device list\nSupported service information\nAP operational BSS\n(AP operational BSS radio count: 2;\nAP operational BSS radio list) 

Elecom_dfe3f9->Elecom_dfe3ed:Msg type: AP autoconfiguration response (0x0008)\nMsg id: 0x035a

Note left of Elecom_dfe3ed: \nSearchedRole\n(Searched role: 0x00, Registrar)\nAutoconfigFreqBand\n(Auto config frequency band: 0x00, 802.11 2.4 GHz)\nSupported service information\n(Supported service count: 1;\nSupported service: 0x00, Multi-AP Controller)\nSearched service information\n(Searched service count: 1, Searched service: 0x00, Multi-AP Controller) 

Elecom_dfe3f9->IEEE_1905.1_Control:Msg type: Topology notification (0x0001)\nMsg id: 0x0014
Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology notification (0x0001)\nMsg id: 0x0014

Elecom_dfe3f9->IEEE_1905.1_Control:Msg type: AP autoconfiguration search (0x0007)\nMsg id: 0x035a

Elecom_dfe3ed->Elecom_dfe3f9:Msg type: Topology query (0x0002)\nMsg id: 0x035d

Elecom_dfe3f9->Elecom_dfe3ed:Msg type: Topology response (0x0003)\nMsg id: 0x035b

Note left of Elecom_dfe3ed: \n1905 device information type\nDevice bridging capability\n1905 neighbor device\n1905 neighbor device\nSearched service information\n(Searched service count: 1, Searched service: 0x00, Multi-AP Controller) 


```

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
