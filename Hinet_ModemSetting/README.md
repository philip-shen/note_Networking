# Purpose
Take note for IPv6/IPv4 access methods 

# Table of Contents  
[PPPoE dailed by Hinet Modem or by Router/PC](#pppoe-dailed-by-hinet-modem-or-by-routerpc)  

[IPv6アドレス図鑑](#ipv6アドレス図鑑)  
[::1](#1)  
[fe80:0:0:0:...](#fe80000)  
[::](#)  
[2001:db8:...](#2001db8)  
[2xxx:... or 3xxx:...](#2xxx-or-3xxx)  
[fcxx:... or fdxx:...](#fcxx-or-fdxx)  
[ffxx:...](#ffxx)  
[::ffff:a.b.c.d](#ffffabcd)  
[2002:...](#2002)  
[2001:0:...](#20010)  

[]()  
[]()  
[]()  
[]()  
[]()  
[]()  

# PPPoE dailed by Hinet Modem or by Router/PC
[VTUR Zyxel P-874 軟撥及硬撥同時支援的設定方法 Mar 9, 2012](http://tiserle.blogspot.com/2012/03/vtur-zyxel-p-874.html)  
[]()  

![alt tag](http://4.bp.blogspot.com/-aqYv1FIns6E/T1oGVPojw-I/AAAAAAAABkg/eE5AKNT6SEc/s640/8.png)

## You can be able to plug WAN port of Router/PC under Hinet Modem LAN port then get IPv6/IPv4 address  
> IPv4 Info  
![alt tag](https://i.imgur.com/oReI4AS.jpg)  
> IPv6 Info  
![alt tag](https://i.imgur.com/7iBD6Bp.jpg)  

# IPv6アドレス図鑑  
* [IPv6アドレス図鑑 2017-07-03](https://qiita.com/search?q=ipv6)  
## ::1  
### 種別：Loopback Address  
### レア度：-  

## fe80:0:0:0:...  
## 種別：Link-local Address
## レア度: -  
```
このアドレスでやりとりするときにはそれだけで一意に宛先を決定できないのでどのリンクなのかを明示する必要があります。fe00::1%eth0 というように % のあとにインタフェースを付加します（Windowsの場合は %15のようにIDを付加する）。コマンドによってはこの書き方ができなくて例えばlinux の ping6 コマンドの場合は次のようにオプションでリンクを指定する必要があります。
```  
> % ping6 -I eth0 fe80::1  

## ::  
## 種別：文脈次第  
## レア度: -  
```  
すべて0のアドレスです。IPv4での0.0.0.0同様文脈に応じてデフォルトゲートウェイなどいくつかの意味を持ちます。
```  

## 2001:db8:...  
## 種別：文書記述用 Address
## レア度: ★  
```  
文書の中に生息する紙魚のようなアドレスです。例として使用します。最初、なんの説明もなくドキュメントの中に出てきて戸惑いました。ルーターで中継されないので実際に使ってしまっても害はないようですが……。
```    
## 2xxx:... or 3xxx:...  
## 種別：GUA     
## レア度：★  
```  
インターネットに出られるアドレスです。プロバイダーからもらわないといけないので、レア度を★にしました。IPv4では基本的に1つずつしかもらえませんでしたが、IPv6ではまとめてこの範囲という感じで複数もらえることが多いです。LAN内の各機器やサーバー上のVMにそれぞれグローバルなアドレスをふることができます。
```    
## fcxx:... or fdxx:...  
## 種別：ULA  
## レア度：★★  
```  
インターネットには出ないけどリンクの外には出たいという中間的な用途のために用いられます。GUAは変化する可能性があるのでサイト内で固有のアドレスを付与したいときや付与されたGUAの数が足りないときに用いられます。
```    

## ffxx:...  
## 種別：Multicast Address 
## レア度：★  
```  
これまで紹介したのは単一のノードに送信するためのユニキャストアドレスですが、これは複数のノードに送信するためのアドレスです。

よく使うものとしては ff02::1があります。これはリンク内のすべてのノードに対して送ります。リンク固有なのでリンクローカルアドレス同様リンクを明示する必要があります。
```    

## ::ffff:a.b.c.d  
## 種別：IPv4射影IPv6 Address
## レア度：★★★  
```  
a.b.c.d の部分にはIPv4のアドレスがそのまま入ります。これは実体をもったアドレスではなくIPv4のアドレスをIPv6のアドレス体系からみたときにこうあらわそうというものです。IPv4, IPv6両対応のサーバのログなどにあらわれます。
```    

## 2002:...  
## 種別：6to4 Address  
## レア度：★★★  
```  
GUAの一種なのでインターネットに出られます。Apple AirMac Expressの設定でIPv6を有効にしたら付与されました。6to4という技術でIPv4のネットワークをトンネリングしてIPv6のパケットを流してくれるようです。ぼくの環境ではpingとsshは通信できましたが、http(s)は通らなかったです。調べるのも面倒なので放置してしまいました。
```    

## 2001:0:...  
## 種別：Teredo Address  
## レア度：★★  
```  
これも6to4同様トンネリング用です。Windows機に付与されてました。
```    


# Troubleshooting


# Reference
* []()  
* [IPv6 IPoE に思いを馳せながら ISP をどうやって選定するか考える話 2019-02-18](https://qiita.com/soprano1125/items/65295cd8c371abc6ebe8)  
* [AndroidのIPv6アドレス, ルーティングテーブルの確認 (モバイルがIPv6接続の時) 2017-05-30](https://qiita.com/ip6/items/68178d4c864ec6504d5d)  
* [/etc/network/interface での IPv6 2017-05-10](https://qiita.com/kwi/items/1dd8ed8f89255956d7a9)   


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
