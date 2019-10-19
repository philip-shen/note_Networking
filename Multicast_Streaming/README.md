# Purpose

# Table of Contents  
[ONVIF Introduction](#novif-introduction)  
[IPv4 / IPv6 multicast address](#ipv4--ipv6-multicast-address)  

[Reference](#reference)  
[VLC media playerを使ったストリーミング配信と受信、ffmpegによる動画保存](#vlc-media-player%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%9F%E3%82%B9%E3%83%88%E3%83%AA%E3%83%BC%E3%83%9F%E3%83%B3%E3%82%B0%E9%85%8D%E4%BF%A1%E3%81%A8%E5%8F%97%E4%BF%A1ffmpeg%E3%81%AB%E3%82%88%E3%82%8B%E5%8B%95%E7%94%BB%E4%BF%9D%E5%AD%98)  
[[VLC]RTSPで配信する](#vlcrtsp%E3%81%A7%E9%85%8D%E4%BF%A1%E3%81%99%E3%82%8B)  
[Dockerで運用しているMastodonのIPv6対応](#docker%E3%81%A7%E9%81%8B%E7%94%A8%E3%81%97%E3%81%A6%E3%81%84%E3%82%8Bmastodon%E3%81%AEipv6%E5%AF%BE%E5%BF%9C)  
[ONVIF -- Multicast 問題分析經驗談](#onvif----multicast-%E5%95%8F%E9%A1%8C%E5%88%86%E6%9E%90%E7%B6%93%E9%A9%97%E8%AB%87)  

# ONVIF Introduction   
[ONVIF の概要](https://qiita.com/t-tkd3a/items/86ee8c92cb580c5bae7b)  

## ONVIF Profile  
[ONVIF Profile](https://qiita.com/t-tkd3a/items/86ee8c92cb580c5bae7b#onvif-profile)

Profile | 概要 | 初出
------------------------------------ | --------------------------------------------- | ---------------------------------------------
S | IPカメラ／エンコーダ 向け | 2011/12
T | 高性能化した IPカメラ／エンコーダ 向け(H.264 , H.265 | 2017 (策定中)
G | 録画機能 | 2014/6
Q | ネットワーク内のセキュリティ製品の設定の管理を容易とする仕組み | 2016/7
C | ドアなど 物理的アクセス制御 向け | 2013/12
A | アクセス権限管理 向け | 2017/6

## 実装方法  
[実装方法](https://qiita.com/t-tkd3a/items/86ee8c92cb580c5bae7b#%E5%AE%9F%E8%A3%85%E6%96%B9%E6%B3%95)  

RTP/RTSP で 映像/音声データのみ扱えればいい場合  
[GStreamer(RTP and RTSP support)](https://gstreamer.freedesktop.org/documentation/additional/rtp.html?gi-language=c#gstreamer-rtsp-server)

# IPv4 / IPv6 multicast address  
[IPv4 / IPv6 multicast address](https://www.infraexpert.com/study/multicastx00.html)  

◆　主なIPv4マルチキャストアドレス  

マルチキャストアドレス | 用途
------------------------------------ | ---------------------------------------------
224.0.0.1 | All hosts or all systems on this subnet
224.0.0.2 | All routers on this subnet
224.0.0.4 | DVMRP routers
224.0.0.5 | All OSPF routers
224.0.0.6 | All OSPF DR routers
224.0.0.9 | RIPv2 routers
224.0.0.10 | EIGRP routers
224.0.0.13 | All PIM routers
224.0.1.39 | RP announce
224.0.1.40 | RP discovery

◆　主なIPv6マルチキャストアドレス  

マルチキャストアドレス | 用途
------------------------------------ | ---------------------------------------------
FF02::1 | 全てのノードアドレス（ リンクローカル ）
FF02::2 | 全てのルータ（ リンクローカル ）
FF02::5 | OSPFv3 ルータ
FF02::6 | OSPFv3 DR/BDR
FF02::9 | RIPng ルータ
FF02::A | EIGRP ルータ
FF02::D | 全てのPIMルータ
FF02::1:2 | 全てのDHCPエージェント
FF05::1:3 | 全てのDHCPサーバ（ サイトローカル ）
FF02::1:FF00:0/104 | 要請ノードマルチキャスト


# Troubleshooting


# Reference  
## VLC media playerを使ったストリーミング配信と受信、ffmpegによる動画保存  
[VLC media playerを使ったストリーミング配信と受信、ffmpegによる動画保存 ](https://qiita.com/subretu/items/0db769b506bcd0148077)  
```  
    ここでは、以下の３点についてまとめています。
        VLC media playerを使った動画のRTSP形式でのストリーミング配信
        VLC media playerを使ったストリーミング配信の受信
        ffmpegによる動画の保存方法

```  
## VLC media player にてRTSP形式のストリーミング配信＋受信
[VLC media player にてRTSP形式のストリーミング配信＋受信](https://qiita.com/subretu/items/0db769b506bcd0148077#vlc-media-player-%E3%81%AB%E3%81%A6rtsp%E5%BD%A2%E5%BC%8F%E3%81%AE%E3%82%B9%E3%83%88%E3%83%AA%E3%83%BC%E3%83%9F%E3%83%B3%E3%82%B0%E9%85%8D%E4%BF%A1%E5%8F%97%E4%BF%A1)  
### ストリーミング配信  
[ストリーミング配信](https://qiita.com/subretu/items/0db769b506bcd0148077#%E3%82%B9%E3%83%88%E3%83%AA%E3%83%BC%E3%83%9F%E3%83%B3%E3%82%B0%E9%85%8D%E4%BF%A1)  
１．「メディア」→「ストリーム」をクリック  
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F264860%2Fa46df011-bb6e-a3d3-76ee-9a53965a9d7b.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&w=1400&fit=max&s=07c583e9a5ad0db369d2fd9841658e65)  
２．再生したい動画ファイルを追加し、「ストリーム再生」をクリック  
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F264860%2F47eb337f-6bd9-ae44-2b8a-ed8578d940d5.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&s=706965f5ad579ca903803ca1c305e6a0)  
３．「次へ」をクリック  
![alt tag](https://i.imgur.com/abqb0yg.jpg)  
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F264860%2F97c5e524-e8fb-666a-30f1-02f113fc7c5a.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&s=8990ba2c7116ae4039f5b29631aefa66)   
４．新しい出力先から「ＲＴＳＰ」を選択し、「追加」をクリック  
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F264860%2Fdb1d1c9c-003b-742b-c50f-3c413a5f8ccf.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&s=39c2ba22ecb088fa60faa0fd5f3662d6)  
５．特に指定のない場合は「次へ」をクリック  
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F264860%2F6522277a-88c5-a4b3-a13b-9f72e3f63217.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&s=10f629ce5f805020d7e12dccab9ec944)  
６．「次へ」をクリック  
```  
※「トランスコーディングを有効にする」のチェックはどちらでも可）
```  
７．「ストリーム」をクリックするとストリーミング配信される  
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F264860%2F831ed343-b9b2-af6d-341d-dc7a62041026.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&s=76af28a4cdf1cfbd25de20848b44459b)  

## ストリーミング受信  
[ストリーミング受信](https://qiita.com/subretu/items/0db769b506bcd0148077#%E3%82%B9%E3%83%88%E3%83%AA%E3%83%BC%E3%83%9F%E3%83%B3%E3%82%B0%E5%8F%97%E4%BF%A1)  
１．「メディア」→「ネットワークストリームを開く」をクリック  
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F264860%2F21ac7e38-2511-2ca9-7fc1-4b1b46944d37.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&s=c18ea291baab352121042cac2fa4a9b1)  
２．ネットワークＵＲＬを入力し、「再生」をクリック  
* 今回はRTSPでのストリーミング配信のため、「rtsp://～」とする。  
* ローカルでの配信のため、IPアドレスは「127.0.0.1」もしくは「localhost」とする。  
* ポート番号は、配信時に設定したものとする。  
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F264860%2Fac9c8252-81de-7ab9-0792-059e14cbc700.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&s=0ab4c1afa985aa33e92458562b44b2d8)  
３．ストリーミング配信を受信  
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F264860%2F113ae2ce-6674-9812-07a0-b81bf308f518.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&s=05726f34bb3b5f7207f69a58942eb1d8)  
4．RTP and RTSP ストリーミング配信を受信  
![alt tag](https://i.imgur.com/LsWYsjS.jpg)  

## ffmpegを実行してストリーミング配信を保存  
[ffmpegを実行してストリーミング配信を保存](https://qiita.com/subretu/items/0db769b506bcd0148077#ffmpeg%E3%82%92%E5%AE%9F%E8%A1%8C%E3%81%97%E3%81%A6%E3%82%B9%E3%83%88%E3%83%AA%E3%83%BC%E3%83%9F%E3%83%B3%E3%82%B0%E9%85%8D%E4%BF%A1%E3%82%92%E4%BF%9D%E5%AD%98)  

例として以下のコマンドを実行すると、対象フォルダに60秒刻みでmp4ファイルが保存される。  
```  
ffmpeg -i "rtsp://127.0.0.1:8554/" -f segment -segment_time "60" -segment_format_options movflags=+faststart -reset_timestamps "1" -strftime "1" d:\temp\sample_%Y-%m-%d_%H-%M-%S.mp4
```  
※コマンド解説

* -i "rtsp://127.0.0.1:8554/" ：入力ファイル(URLも可)
* -f segment：出力フォーマットをsegment
* -segment_time "60" ：セグメントを60秒
* -segment_format_options movflags=+faststart ：読み込みから再生開始を早める
* -reset_timestamps "1"：タイムスタンプを初期化
* -strftime "1" ：各セグメント名にstrftime の書式(%Y%m%d%H%M%S)を用いる
* d:\temp\sample_%Y-%m-%d_%H-%M-%S.mp4：ファイルの保存先




## [VLC]RTSPで配信する  
[[VLC]RTSPで配信する  Jul 02,2016](https://qiita.com/tommy19970714/items/d4f44e5d402404049629)  
### 配信側の設定  
[配信側の設定](https://qiita.com/tommy19970714/items/d4f44e5d402404049629#%E9%85%8D%E4%BF%A1%E5%81%B4%E3%81%AE%E8%A8%AD%E5%AE%9A)  
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.amazonaws.com%2F0%2F56557%2F25172ab9-ed8d-4b85-d1e0-4dc7b2d4ddb2.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&w=1400&fit=max&s=aeecebfd4e1eaff7fd3ccc2fb7b9cfad)  
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.amazonaws.com%2F0%2F56557%2F9dbe08ee-8c32-a0ef-253b-bc36d3449153.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&w=1400&fit=max&s=437f819181833c93d0f6fe7661cfb5a5)  

### 受信側の設定  
[受信側の設定](https://qiita.com/tommy19970714/items/d4f44e5d402404049629#%E5%8F%97%E4%BF%A1%E5%81%B4%E3%81%AE%E8%A8%AD%E5%AE%9A)  

![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.amazonaws.com%2F0%2F56557%2F624e4230-0392-4d01-27f7-0f5bc7e9f0f4.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&s=6fe0b3bdbc275bd5f2479ee7eabb1681)  
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.amazonaws.com%2F0%2F56557%2F44e77ad3-1e71-6896-f7e0-13cc6ed057a4.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&w=1400&fit=max&s=603872c7b34df898b6598b7e8fc7d697)  

### 配信/受信してみる  
[配信/受信してみる](https://qiita.com/tommy19970714/items/d4f44e5d402404049629#%E9%85%8D%E4%BF%A1%E5%8F%97%E4%BF%A1%E3%81%97%E3%81%A6%E3%81%BF%E3%82%8B) 
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.amazonaws.com%2F0%2F56557%2Fb7410bcb-4f63-5b98-afb8-dcb36f4c2cd9.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&s=6b3b72ff3b9f2ab83ffa5af417726e61)  


## Dockerで運用しているMastodonのIPv6対応  
[Dockerで運用しているMastodonのIPv6対応 May 28,2017](https://qiita.com/konosuke/items/f2bc33887c1259616616)  
```  
Docker-composeで作成されるネットワークはデフォルトではIPv4アドレスしか割り当てられないため、Mastodonインスタンス間の通信ではIPv6を使えません。
とりあえずDockerコンテナにIPv6 ULA(RFC4193)を割り当ててNAT66(IP masquerade)を使用してコンテナから外部へIPv6で喋れるようにしました。
```  

## ONVIF -- Multicast 問題分析經驗談  
[ONVIF -- Multicast 問題分析經驗談 5/28,2013](http://albert-oma.blogspot.com/2013/05/multicast.html)  
### Multicast 步驟分析  
1. IPCAM 送出 multicast rtp  

另外因為IPCAM同時可能有多個網路介面，因此需要指定將對外傳輸的網路介面。  
```  
    ip route add 224.0.0.0 netmask 240.0.0.0 dev eth0
```  

若要確認此 multicast 封包是否可送達其他機器，可以在其他機器上使用VLC試著接收multicast封包，如下：  
```  
    vlc rtp://@224.0.0.1:50000
```  
2. IPCAM 接收  
multicast rtcp 實作時，socket的設定如下：
```  
    // 此時會發出 IGMP 封包
    setsockopt (socket, IPPROTO_IP, IP_ADD_MEMBERSHIP, &mreq, sizeof(mreq)); 
```  
註：若要離開multicast group，可以自行設定IP_DROP_MEMBERSHIP，或是當socket closed時，由kernel發出 IGMP Leave。 

## ONVIF -- 各種平台上可使用的測試工具  
[ONVIF -- 各種平台上可使用的測試工具 8/21,2013](http://albert-oma.blogspot.com/2013/08/onvif.html)  

* []()  
![alt tag]()  
```  
```  

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
