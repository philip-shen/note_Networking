# Table of Contents  
[Statefull DHCPv6 Client](#statefull-dhcpv6-client)  

# Statefull DHCPv6 Client  
### 01 Link-Local Address Creation  
![alt tag](https://i.imgur.com/XzCbV7M.jpg)  
### 02 Statefull DHCPv6 Procedure  
![alt tag](https://i.imgur.com/gaifNLy.jpg)  
### 03 Duplicate Address Detection(DAD) Solicited-node Multicast Address  
![alt tag](https://i.imgur.com/1UK5cYY.jpg)  
### 04 Address Resolution and Neighbor Unreachability Detection  
![alt tag](https://i.imgur.com/YrjF9A6.jpg)  
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
