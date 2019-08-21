# Table of Contents  
[Multicast Address](#multicast-address)

[Statefull DHCPv6 Client](#statefull-dhcpv6-client)  
[01 Link-Local Address Creation](#01-link-local-address-creation)  
[02 Statefull DHCPv6 Procedure](#02-statefull-dhcpv6-procedure)  
[03 Duplicate Address Detection(DAD) Solicited-node Multicast Address](#03-duplicate-address-detectiondad-solicited-node-multicast-address)  
[04 Address Resolution and Neighbor Unreachability Detection](#04-address-resolution-and-neighbor-unreachability-detection)  

[Reference](#reference)  

# Multicast Address
[Multicast address](https://en.wikipedia.org/wiki/Multicast_address)  
**Well-known IPv6 multicast addresses**  

Address | Description
------------------------------------ | ---------------------------------------------
ff02::1 | All nodes on the local network segment
ff02::2 | All routers on the local network segment
ff02::5 | OSPFv3 All SPF routers
ff02::6 | OSPFv3 All DR routers
ff02::8 | IS-IS for IPv6 routers
ff02::9 | RIP routers
ff02::a | EIGRP routers
ff02::d | PIM routers
ff02::16 | MLDv2 reports (defined in RFC 3810)
ff02::1:2 | All DHCP servers and relay agents on the local network segment (defined in [RFC 3315](https://tools.ietf.org/html/rfc3315))
ff02::1:3 | All LLMNR hosts on the local network segment (defined in [RFC 4795](https://tools.ietf.org/html/rfc4795))
ff05::1:3 | All DHCP servers on the local network site (defined in RFC 3315)
ff0x::c | Simple Service Discovery Protocol
ff0x::fb | Multicast DNS
ff0x::101 | Network Time Protocol
ff0x::108 | Network Information Service
ff0x::181 | Precision Time Protocol (PTP) version 2 messages (Sync, Announce, etc.) except peer delay measurement
ff02::6b | Precision Time Protocol (PTP) version 2 peer delay measurement messages
ff0x::114 | Used for experiments

[Multicast DNS mDNS](https://en.wikipedia.org/wiki/Multicast_DNS)    
**Packet structure**  
UDP port 5353  

IPv4 | IPv6
------------------------------------ | ---------------------------------------------
MAC: 01:00:5E:00:00:FB |  MAC: 33:33:00:00:00:FB(IPv6mcast_16)
224.0.0.251 | ff02::fb

[Solicited-node Multicast Address FF02::1:FF00:::/104](https://github.com/philip-shen/note_Networking/tree/master/IPv6_StatelessAddAutoConf_SLAAC#solicited-node-multicast-address-ff021ff00104)  

# Statefull DHCPv6 Client  
### 01 Link-Local Address Creation  
![alt tag](https://i.imgur.com/lFvkgp1.jpg)  
(Diagram made with [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/))  

### 02 Statefull DHCPv6 Procedure  
![alt tag](https://i.imgur.com/Z0qFeqi.jpg)  
(Diagram made with [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/))  

### 03 Duplicate Address Detection(DAD) Solicited-node Multicast Address  
![alt tag](https://i.imgur.com/SOkd2V5.jpg)  
(Diagram made with [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/))  

### 04 Address Resolution and Neighbor Unreachability Detection  
![alt tag](https://i.imgur.com/A1JhQnB.jpg)  
(Diagram made with [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/))  

```
test@ubuntu:~$ 
# interfaces(5) file used by ifup(8) and ifdown(8)
#auto lo ens33
#iface ens33 inet dhcp
auto lo
iface lo inet loopback
auto eth0
iface eth0 inet static
 address 192.168.0.110
 gateway 192.168.0.1
 netmask 255.255.255.0
 network 192.168.0.0
 broadcast 192.168.0.255
auto eth0
iface eth0 inet6 dhcp
```

```
test@ubuntu:~$ ip add sh
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN group default qlen 1000
    link/ether 00:0c:29:be:e6:8e brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.110/24 brd 192.168.0.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 3000:aaaa:bbbb:cccc:1111:2222:0:2/128 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:febe:e68e/64 scope link
       valid_lft forever preferred_lft forever
```
```
test@ubuntu:~$ ip add sh
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN group default qlen 1000
    link/ether 00:0c:29:ed:0a:c8 brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.120/24 brd 192.168.0.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 3000:aaaa:bbbb:cccc:1111:2222:0:3/128 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:feed:ac8/64 scope link
       valid_lft forever preferred_lft forever
```
```
test@ubuntu:~$ ip add sh
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN group default qlen 1000
    link/ether 00:0c:29:0a:3b:c6 brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.130/24 brd 192.168.0.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 3000:aaaa:bbbb:cccc:1111:2222:0:4/128 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:fe0a:3bc6/64 scope link
       valid_lft forever preferred_lft forever
```

[20141210 - Client端IPv6自動取得的流程](http://gienmin.blogspot.com/2014/12/20141210-clientipv6.html)
```  
1. 首先Client會被設定要以哪種方式取得IPv6，StateLess還是Stateful。而StateLess還可分成要啟動DHCPv6的和不用的。所以總共有三種方式
2. Client端發送ICMPv6 RS(Router Solicitation)封包給Router
3. Router回覆ICMPv6 RA(Router Advertisement)封包給Client
4. Client端檢查Router回覆的RA訊息（type code = 134），若有，分析其ICMP標頭裡頭的M/O Flag，對應表格及代表意義如下：
```  
![alt tag](http://3.bp.blogspot.com/-vHcSxA52dhw/VIfgmEOjDDI/AAAAAAAACco/QrP3inZnzT0/s1600/ipv6_process_01.png)  
![alt tag](http://3.bp.blogspot.com/-f-XfLjeauLk/VIfgtZlc0sI/AAAAAAAACcw/Vn9KGG39t30/s1600/ipv6_process_02.png)  
![alt tag](http://1.bp.blogspot.com/-Gjzuoa-MkfE/VIfg1vH3QNI/AAAAAAAACc4/O8tBP--nd60/s1600/ipv6_process_03.png)  
```  
5. Client發送Multicast的Solicit包，若是開啟Rapid Commit option，表示進行快速設定，直接跳至步驟8
6. Router發送Unicast的Advertisement包
7. Client發送Multicast的Request包
8. Router發送Unicast的Reply包
若是之前RA訊息中(M=0, O=1)，那這邊可以獲得DNS。若之前RA訊息中(M=1)，那這邊可以取得IPv6的DNS以及被分配的位址
```  

# Reference
* [IPv6 only works after pinging the default gateway. Feb 11 '13](https://serverfault.com/questions/477471/ipv6-only-works-after-pinging-the-default-gateway)
```  
Now, my problem is that my IPv6 isn't working properly. If I try to ping an IPv6 address e.g. ping6 ipv6.google.com. I get: "Destination unreachable: Address unreachable"
```  
```  
answered Feb 23 '13 

I gave the whole problem another try today, a couple of weeks later. And what can I say, I fixed it. Can someone please explain me why adding a ipv6 loopback fixed my problem? Here is what I've added to my /etc/network/interfaces file:

iface lo inet6 loopback

I have no ideas why I've forgot to add it in the first place!^^ Thank you all for your responses!
```  

```  
Title: Tracetroute6 LAN_PC to WAN_PC
Vmware_bee68e(LAN_PC)->DLinkIn_1712a2\n(LAN): UDP\n (IPv6 Src: 2003:0:0:b::1, Dst: 2003:0:0:a::d)
Vmware_bee68e(LAN_PC)->DLinkIn_1712a2\n(LAN): UDP\n (IPv6 Src: 2003:0:0:b::1, Dst: 2003:0:0:a::d)
DLinkIn_1712a2\n(LAN)->Vmware_bee68e(LAN_PC): ICMPv6\n (IPv6 Src: 2003:0:0:b::a, Dst: 2003:0:0:b::1\n Type: Time Exceeded (3)\n Code: 0 (hop limit exceeded in transit))
Vmware_bee68e(LAN_PC)->DLinkIn_1712a2\n(LAN): UDP\n (IPv6 Src: 2003:0:0:b::1, Dst: 2003:0:0:a::d)
Vmware_bee68e(LAN_PC)->DLinkIn_1712a2\n(LAN): UDP\n (IPv6 Src: 2003:0:0:b::1, Dst: 2003:0:0:a::d)
DLinkIn_1712a2\n(LAN)->Vmware_bee68e(LAN_PC): ICMPv6\n (IPv6 Src: 2003:0:0:a::d, Dst: 2003:0:0:b::1\n Type: Destination Unreachable (1)\n Code: 4 (Port unreachable))

Vmware_7bb4e8(WAN_PC)->DLinkIn_f4675d\n(DUT2 LAN):ICMPv6\n (IPv6 Src: 2003:0:0:a::d, Dst: 2003:0:0:b::1\n Type: Destination Unreachable (1)\n Code: 4 (Port unreachable))
Vmware_7bb4e8(WAN_PC)->DLinkIn_f4675d\n(DUT2 LAN):NS\n (IPv6 Src: fe80::20c:29ff:fe7b:b4e8,\n Dst: 2003:0:0:a::e)
DLinkIn_f4675d\n(DUT2 LAN)->Vmware_7bb4e8(WAN_PC):NA\n (IPv6 Src: 2003:0:0:a::e,\n Dst: fe80::20c:29ff:fe7b:b4e8)
DLinkIn_1712a3\n(DUT WAN)->Vmware_7bb4e8(WAN_PC):NS\n (IPv6 Src: fe80::eead:e0ff:fe17:12a3,\n Dst: 2003:0:0:a::e)
Vmware_7bb4e8(WAN_PC)->DLinkIn_1712a3\n(DUT WAN):NA\n (IPv6 Src: 2003:0:0:a::d,\n Dst: fe80::eead:e0ff:fe17:12a3)

Vmware_bee68e(LAN_PC)->DLinkIn_1712a2\n(LAN): NS\n (IPv6 Src: fe80::20c:29ff:febe:e68e, Dst: 2003:0:0:b::a\n for 2003:0:0:b::a from Vmware_bee68e(LAN_PC))
Vmware_bee68e(LAN_PC)->DLinkIn_1712a2\n(LAN): NS\n (IPv6 Src: fe80::20c:29ff:febe:e68e, Dst: 2003:0:0:b::a\n for 2003:0:0:b::a from Vmware_bee68e(LAN_PC))
DLinkIn_1712a2\n(LAN)->Vmware_bee68e(LAN_PC): NS\n (IPv6 Src: fe80::eead:e0ff:fe17:12a2, Dst: 2003:0:0:b::1\n for 2003:0:0:b::1 from DLinkIn_1712a2\n(LAN))
Vmware_bee68e(LAN_PC)->DLinkIn_1712a2\n(LAN): NA\n (IPv6 Src: 2003:0:0:b::1, Dst: fe80::eead:e0ff:fe17:12a2\n 2003:0:0:b::1 (sol))
Vmware_bee68e(LAN_PC)->DLinkIn_1712a2\n(LAN): NA\n (IPv6 Src: 2003:0:0:b::1, Dst: fe80::eead:e0ff:fe17:12a2\n 2003:0:0:b::1 (sol))
DLinkIn_1712a2\n(LAN)->Vmware_bee68e(LAN_PC): NA\n (IPv6 Src: 2003:0:0:b::a, Dst: fe80::20c:29ff:febe:e68e\n 2003:0:0:b::a (rtr, sol))
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
