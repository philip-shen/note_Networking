# Purpose

# Table of Contents  
[WPA3](#wpa3)

[WPA3 Wi-Fi Easy Connect](#wpa3-wi-fi-easy-connect)
[Wi-Fi Easy Connect简介](#wi-fi-easy-connect%E7%AE%80%E4%BB%8B)  
[Wi-Fi Easy Connect连接过程](#wi-fi-easy-connect%E8%BF%9E%E6%8E%A5%E8%BF%87%E7%A8%8B)  
[Device Provisioning Protocol (DPP)](#device-provisioning-protocol-dpp)  


[Wi-Fi Direct](#wi-fi-direct)  

[Wi-Fi CERTIFIED](#wi-fi-cERTIFIED)  
[Wi-Fi CERTIFIED Agile Multiband](#wi-fi-certified-agile-multiband)  


# WPA3  
[WPA3 – Improving your WLAN security Sep 14, 2018](https://wlan1nde.wordpress.com/2018/09/14/wpa3-improving-your-wlan-security/)

## Protected Management Frames (PMF)  
## WPA3-Personal  
![alt tag](https://wlan1nde.files.wordpress.com/2018/09/beacon-with-sae-text-1.png)  
```  
The “Pre-Shared Key” (PSK) method of WPA2 is replaced by “Simultaneous Authentication of Equals” (SAE), 
which offers a more robust password-based authentication. 

The passphrase itself is no longer used for key derivation (keyword: “Pairwise Master Key” (PMK)), 

the key derivation is based on “Elliptic Curve Cryptography” (ECC) or a special form of ECC with integer numbers only called “Finite Field” instead.
```  
# WPA3 Wi-Fi Easy Connect  
[スマホでQRコードを読み取り、ほかの機器をWi-Fi接続する「Wi-Fi Easy Connect」、画面やカメラがない機器を接続可能に 2018年12月18日](https://internet.watch.impress.co.jp/docs/column/nettech/1158782.html)  


[初探WPA3中的Wi-Fi Easy Connect ](https://www.anquanke.com/post/id/150324)  
## Wi-Fi Easy Connect简介
## Wi-Fi Easy Connect连接过程  
```  
Wi-Fi Easy Connect中包含两个角色类型：Configurator 和 Enrollee。

    Configurator，可以是手机、平板等移动设备上的应用程序，AP的Web接口或应用程序接口。
    ￼Enrollee，除Configurator外的其他都是Enrollee

为了尽量减少交互的过程，Wi-Fi Easy Connect包含扫描二维码的方式。其中可以包括设备的安全密钥和唯一标志符等信息。
任何可以扫描二维码的设备都可以轻松读取，消除了手动输入的负担。

最为常见的场景是：

    用户使用手机扫描目标设备的二维码后，会自动尝试与其建立安全连接。
    连接建立后，向目标设备传递Wi-Fi网络的配置信息。
    目标设备使用这些信息去尝试扫描，选择，连接到目标网络。

除此之外，也可以主动显示二维码，让待联网目标设备来扫描以连上网络。在官方的文档中给出了一个例子：
酒店可以在房间里的电视上显示二维码，客人只需使用手机扫描该二维码就可以连接上酒店网络。如果双方都没有扫描或展示二维码的能力，
还可以使用字符串的形式来建立连接。

使用Wi-Fi Easy Connect的连接过程如下：
```  
```  
1.配置AP
    首先用户可以使用手机等设备扫描AP上的二维码，通过设备配置协议（Device Provisioning Protocol，DPP）来配置AP使其创建网络。
```  
![alt tag](https://p1.ssl.qhimg.com/t0118592b4a08a7ab4a.png)  
```  
2. 配置设备
当网络建立后，就可以开始配置其他客户端设备了。同样可以通过扫描二维码的形式，
每个设备都将获得自己特有的配置用以加入网络。同时，会生成属于该设备与网络间独特的安全证书，保护双方的通信。
```  
![alt tag](https://p2.ssl.qhimg.com/t01cb52d809c4eb2097.png)  
```  
设备连接到网络
一旦配置完成，设备就会使用得到的配置信息去尝试连接目标无线网络。
```  
![alt tag](https://p4.ssl.qhimg.com/t017af4dae58b1cf0f7.png)  

## Device Provisioning Protocol (DPP)  
```  
每当扫描二维码时都会通过DPP协议来完成后续配置过程。需要注意的是，enrollee既可以是等待连接网络的客户端设备，也可以是AP设备。

DPP的过程分为这几部：
```  
```  
1. Bootstrapping
    该过程由扫描二维码或输入字符串触发，交换双方设备的公钥以及其他信息。在二维码中包含了设备的公钥，以及频道、MAC地址等信息，其通过通过编码压缩成为了base64uri的形式，如下图二维码的信息包含了一个公钥和频道1、36的信息：

    DPP:C:81/1,115/36;K:MDkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDIgADM2206avxHJaHXgLMkq/24e0rsrfMP9K1Tm8gx+ovP0I=;;
```  
```  
2.  Authentication 与 Configuration
    Configurator和Enrollee使用DPP认证协议来建立安全连接。Enrollee从Configurator中获得配置信息，
    连接到目标AP或者自己成为AP。该配置信息由Wi-Fi网络的类型、SSID、凭证信息组成。
    凭证信息中可以包含一个由Configurator签署的连接器，其中含有设备的公钥、网络角色（客户端或AP）、
    组属性（用以确定是否允许建立网络连接），以及签名信息。这确保了连接器对每个设备是唯一的，没法被其他设备所使用。
    如果是用于AP的连接器，则可以确保没有其他AP可以伪装成该AP。
    
    Network access
    客户端使用配置中的网络信息扫描目标AP，接着利用连接器使用Network Introduction Protocol协议去认证并建立连接。
```  
```  
3. 在Network Introduction Protocol中包含了这些过程：

    Enrollee客户端与AP确认连接器由Configurator签名
    确认网络角色是互补的：客户端与AP建立建立
    确认组属性是否匹配
    Enrollee客户端和AP基于连接器的公钥生成成对主密钥（PMK）
    Enrollee客户端与AP建立连接
```  

# Wi-Fi Direct  
[Wi-Fi子機同士を直接接続する「Wi-Fi Direct」2019年1月8日](https://internet.watch.impress.co.jp/docs/column/nettech/1160701.html)

# Wi-Fi CERTIFIED  
[認証不要でWi-Fi通信の傍受を不可能に、フリーWi-Fi向け新規格「Wi-Fi CERTIFIED Enhanced Open」2018/11/6](https://internet.watch.impress.co.jp/docs/column/nettech/1151607.html)  
【利便性を向上するWi-Fi規格】（第16回）  
![alt tag](https://internet.watch.impress.co.jp/img/iw/docs/1151/607/005_WiFi_29_02_s.jpg)  

![alt tag](https://internet.watch.impress.co.jp/img/iw/docs/1151/607/005_WiFi_29_03_s.jpg)  
![alt tag]()  


[Wi-FiでVoIPを実現する音声伝達向け規格「Wi-Fi CERTIFIED Voice-Personal」2018年12月25日 ](https://internet.watch.impress.co.jp/docs/column/nettech/1159973.html)
【利便性を向上するWi-Fi規格】（第23回）  


[高精度の屋内測位機能を提供する「Wi-Fi CERTIFIED 2019年1月15日](https://internet.watch.impress.co.jp/docs/column/nettech/1164278.html)  
[Wi-Fiで100μs精度の時刻同期ができる「Wi-Fi CERTIFIED TimeSync」2019年1月22日](https://internet.watch.impress.co.jp/docs/column/nettech/1165313.html)  

[公衆Wi-Fiアクセスポイント向けの「Wi-Fi CERTIFIED Vantage」2019年1月29日](https://internet.watch.impress.co.jp/docs/column/nettech/1166523.html)  

## Wi-Fi CERTIFIED Agile Multiband  
[同一LAN内移動時のローミングなどを規定した「Wi-Fi CERTIFIED Agile Multiband」2019年2月5日](https://internet.watch.impress.co.jp/docs/column/nettech/1168082.html)  
【利便性を向上するWi-Fi規格】（第28回）  
### 同一ネットワーク内で接続先のアクセスポイントを素早く切り替え可能にする「Dynamic Monitoring」  
```  
最初の「Dynamic Monitoring」は、「IEEE 802.11k」をベースとする規格だ。「IEEE 802.11-2007」にAmendment 1として2008年に収録されており、「IEEE 802.11-2016」ではAnnex Cにまとめられている。IEEE 802.11kの骨子は「RRM（Radio Resource Management）」の強化で、具体的にはアクセスポイントからクライアントに対し、MAC層のManagement Frameを利用して以下の情報を伝達する仕組みだ。

    近隣アクセスポイントの位置
    各アクセスポイントからのビーコン信号の強度
    各チャネルにおける無線LANの信号レベル
    各チャネルにおける無線LAN以外の信号レベル（2.4GHz帯なら電子レンジなど）
```  
![alt tag](https://internet.watch.impress.co.jp/img/iw/docs/1168/082/html/005_WiFi_41_02.png.html)  

### 新プロトコル採用で認証を高速化する「Fast network transitions」  
![alt tag](https://internet.watch.impress.co.jp/img/iw/docs/1168/082/html/005_WiFi_41_01.jpg.html)  


![alt tag](https://internet.watch.impress.co.jp/img/iw/docs/1168/082/html/005_WiFi_24_02.png.html)  


[異なるESSIDのへの接続を高速化「Wi-Fi CERTIFIED Optimized Connectivity」2019年2月13日](https://internet.watch.impress.co.jp/docs/column/nettech/1168949.html)  
【利便性を向上するWi-Fi規格】（第29回）  

![alt tag]()  
```  

```  
![alt tag]()  

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
