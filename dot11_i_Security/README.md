# Purpose

# Table of Contents  
[Chapter 10. WPA and RSN Key Hierarchy]() 
[Pairwise and Group Keys](#pairwise-and-group-Keys)  

# Chapter 10. WPA and RSN Key Hierarchy 
[Chapter 10. WPA and RSN Key Hierarchy](http://etutorials.org/Networking/802.11+security.+wi-fi+protected+access+and+802.11i/Part+II+The+Design+of+Wi-Fi+Security/Chapter+10.+WPA+and+RSN+Key+Hierarchy/)  
```
We talked about keys in the introduction to WPA/RSN and explained how, unlike WEP, both WPA and RSN use multiple keys at different levels. In fact, there are so many keys used, it's hard enough for the designer to keep track of them all, let alone an attacker. But don't panic, although there are many keys, they are all hidden away inside the workings of WPA/RSN?the administrator needs only to define a single master key from which all these others are derived.

This chapter describes what a key hierarchy is and why so many keys are needed. We look at the key hierarchies for TKIP and AES?CCMP, the two ciphersuites described in Chapters 11 and 12. We also review what steps are involved in creating and updating the hierarchy, both when the Wi-Fi LAN is first started and during normal operation.
```

## Pairwise and Group Keys  
[Pairwise and Group Keys](http://etutorials.org/Networking/802.11+security.+wi-fi+protected+access+and+802.11i/Part+II+The+Design+of+Wi-Fi+Security/Chapter+10.+WPA+and+RSN+Key+Hierarchy/Pairwise+and+Group+Keys/)  
```
Data sent between two workstations is called unicast and data sent from one to multiple workstations is called multicast; the case in which one workstation sends to all the others is a special case of multicast called broadcast. Multicast and unicast messages have different security characteristics.

Unicast data sent between two parties needs to be private to those two parties. This is best accomplished by using a specific key for each pair of devices communicating. We call this a pairwise key; usually it protects communication between a mobile device and the access point. This means that each mobile device needs to store one pairwise key, and the access point needs a set of pairwise keys?one for each mobile device that is associated.

By contrast, broadcast (or multicast) data must be received by multiple parties who form a trusted group. Therefore, a key must be shared by all the members of that trusted group. This is called the group key. Each trusted mobile device and the access point need to know a single group key. The concept of pairwise and group keys is shown in Figure 10.1. 

Figure 10.1. Pairwise and Group Keys
```
![alt tag](http://etutorials.org/shared/images/tutorials/tutorial_113/10fig01.gif)  

```
The methods of managing the pairwise keys and the group keys are somewhat different so we define each as a separate key hierarchy. We refer to the pairwise key hierarchy to describe all the keys used between a pair of devices (one of which is usually the access point) and the group key hierarchy to describe the various keys shared by all the devices.
```
```
The next important terms are preshared keys and server-based keys. 
As the name suggests, preshared keys are installed in the access point and in the mobile device by some method outside WPA/RSN. It could be that you phone up a user and tell him the password, or send him a letter that he has to eat after reading or whatever eccentric method you choose. Most WEP systems use preshared keys?it is the responsibility of the user to get the keys delivered to the two parties who want to communicate. Preshared keys bypass the concept of upper-layer authentication completely; you are assumed to be authentic simply by proving possession of the key.

The alternative, server-based keys, requires an upper-layer authentication process that allows the mobile device and an authentication server to generate matching secret keys. The authentication sever arranges for the access point to get a copy for use in session protection. It has the major advantage that the operator can keep a single key database that can be used in conjunction with many access points. When a new employee joins, for example, the administrator has to update only one database.
```
## Pairwise Key Hierarchy  
[Pairwise Key Hierarchy](http://etutorials.org/Networking/802.11+security.+wi-fi+protected+access+and+802.11i/Part+II+The+Design+of+Wi-Fi+Security/Chapter+10.+WPA+and+RSN+Key+Hierarchy/Pairwise+Key+Hierarchy/)
```
The pairwise key hierarchy is the most complicated, so let's review that first. 
The hierarchy starts at the top with a pairwise master key (PMK) delivered from the upper-layer authentication server or with a preshared key. 
Let's put preshared keys aside for the moment and look at the server-key approach. 
The PMK is the top of the pairwise key hierarchy. There is a different PMK for each mobile device, and from this all other pairwise keys are derived. The following paragraphs show how the PMK is created and how it is used to generate the actual keys used in encryption.
```


## Group Key Hierarchy  
[Group Key Hierarchy](http://etutorials.org/Networking/802.11+security.+wi-fi+protected+access+and+802.11i/Part+II+The+Design+of+Wi-Fi+Security/Chapter+10.+WPA+and+RSN+Key+Hierarchy/Group+Key+Hierarchy/)  

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
