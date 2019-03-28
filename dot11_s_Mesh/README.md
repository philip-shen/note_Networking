# Purpose
Review 802.11s STD.


# Table of Content

# Terminology
## Mesh Point(MP)

## Mesh AP(MAP)

## Mesh Portal(MPP)

## Station(STA)

![alt tag](https://i.imgur.com/ZdKe6zZ.jpg)

# dot11s Security
## Transport Security
### prevent unauthorized devices from directly sending and receiving traffic via the mesh
```
Protect unicast/broadcast traffic between neighbor MPs
```

### We need
```
Mutually authenticate neighbor MPs
Generate and manage session keys and broadcast keys
Data confidentiality over a link
Detect message forgeries and replays received on a link
```

## Authentication and Initial Key Management
### Basic approach is to re-use 802.11i/802.1X
> Re-use of 802.11i facilitates implementation  
> Allows other AKM schemes

![alt tag](https://i.imgur.com/KW2rAZb.jpg)
(Diagram made with [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/))

### 802.1X is widely used and is suitable for many mesh scenarios
> but can be replaced with small scale alternatives if required

### Provides a basis for secure key distribution (PMK)

### In a mesh, PMK is treated as token of authorication for a MP to join the mesh
> Authorized to send and receive messages to/from mesh neighbors

![alt tag](https://i.imgur.com/DOb5nsv.jpg)

# Reference
* [802.11s based wireless mesh network OpenWrt](https://openwrt.org/docs/guide-user/network/wifi/mesh/80211s)
* [good background article from CWNP](http://www.cwnp.com/wp-content/uploads/pdf/802.11s_mesh_networking_v1.0.pdf)
* [IEEE-802.11 Standards 802.11s Linux Wireless](http://wireless.kernel.org/en/developers/Documentation/ieee80211/802.11s)

* [IEEE802.11sについて 2017-06-23](https://qiita.com/miminashi/items/f65d9b4b4aa8eef0f891)
* [802.11s メッシュネットワーク](https://www.nttdocomo.co.jp/binary/pdf/corporate/technology/rd/technical_journal/bn/vol14_2/vol14_2_014jp.pdf)
* [802.11s: メッシュネットワークの構築 January 22, 2017](https://hottuna.server-on.net/computing/?p=239)
* [IEEE 802.11s Meshネットワーク＋tinc VPNをセットアップする UPDATE:18 JAN 2019](https://hottuna.server-on.net/computing/?p=932)
* [Google Wifiについて気づいたこと 2018-04-25](https://qiita.com/invhnd/items/cc85b11275dad7accf10)
* [続々登場するQualcomm「Wi-Fi SON」採用製品は相互非互換、Wi-Fi Allianceは「EasyMesh」を発表 2018年8月28日](https://internet.watch.impress.co.jp/docs/column/nettech/1139650.html)
* [もはや、もっといい選択肢はある！　鳴り物入りで日本上陸した「Google Wifi」のメッシュを試す 2018年5月14日](https://internet.watch.impress.co.jp/docs/column/shimizu/1120372.html)


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
