Table of Contents
=================

   * [Table of Contents](#table-of-contents)
   * [Purpose](#purpose)
   * [QUICをゆっくり解説](#quicをゆっくり解説)
      * [<a href="https://eng-blog.iij.ad.jp/archives/10039" rel="nofollow">QUICをゆっくり解説(1)：QUICが標準化されました 2021年07月01日 木曜日</a>](#quicをゆっくり解説1quicが標準化されました-2021年07月01日-木曜日)
         * [4. 標準化の動向](#4-標準化の動向)
         * [5. 普及状況](#5-普及状況)
      * [<a href="https://eng-blog.iij.ad.jp/archives/10283" rel="nofollow">QUICをゆっくり解説(2)：ネゴせよ 2021年07月16日 金曜日</a>](#quicをゆっくり解説2ネゴせよ-2021年07月16日-金曜日)
      * [<a href="https://eng-blog.iij.ad.jp/archives/10539" rel="nofollow">QUICをゆっくり解説(3)：QUICパケットの構造 2021年08月11日 水曜日</a>](#quicをゆっくり解説3quicパケットの構造-2021年08月11日-水曜日)
      * [<a href="https://eng-blog.iij.ad.jp/archives/10582" rel="nofollow">QUICをゆっくり解説(4)：ハンドシェイク 2021年08月16日 月曜日</a>](#quicをゆっくり解説4ハンドシェイク-2021年08月16日-月曜日)
      * [<a href="https://eng-blog.iij.ad.jp/archives/10620" rel="nofollow">QUICをゆっくり解説(5)：2回目以降のハンドシェイクと0-RTT 2021年08月25日 水曜日</a>](#quicをゆっくり解説52回目以降のハンドシェイクと0-rtt-2021年08月25日-水曜日)
      * [<a href="https://eng-blog.iij.ad.jp/archives/10660" rel="nofollow">QUICをゆっくり解説(6)：増幅攻撃との戦い</a>](#quicをゆっくり解説6増幅攻撃との戦い)
      * [<a href="https://eng-blog.iij.ad.jp/archives/10710" rel="nofollow">QUICをゆっくり解説(7)：アプリケーションデータとストリーム 2021年09月10日 金曜日</a>](#quicをゆっくり解説7アプリケーションデータとストリーム-2021年09月10日-金曜日)
      * [<a href="https://eng-blog.iij.ad.jp/archives/10748" rel="nofollow">QUICをゆっくり解説(8)：フロー制御 2021年09月15日 水曜日</a>](#quicをゆっくり解説8フロー制御-2021年09月15日-水曜日)
         * [1. フロー制御と輻輳制御](#1-フロー制御と輻輳制御)
         * [2. QUICのフロー制御](#2-quicのフロー制御)
         * [3. ウインドウとクレジット](#3-ウインドウとクレジット)
      * [<a href="https://eng-blog.iij.ad.jp/archives/10757" rel="nofollow">QUICをゆっくり解説(9)：コネクションの終了 2021年09月22日 水曜日</a>](#quicをゆっくり解説9コネクションの終了-2021年09月22日-水曜日)
         * [正常な終了](#正常な終了)
         * [エラー終了](#エラー終了)
         * [リセット](#リセット)
            * [TCP のリセット](#tcp-のリセット)
            * [QUIC のリセット](#quic-のリセット)
      * [<a href="https://eng-blog.iij.ad.jp/archives/10892" rel="nofollow">QUICをゆっくり解説(10)：コネクションのマイグレーション 2021年10月06日 水曜日</a>](#quicをゆっくり解説10コネクションのマイグレーション-2021年10月06日-水曜日)
      * [<a href="https://eng-blog.iij.ad.jp/archives/11018" rel="nofollow">QUICをゆっくり解説(11)：ヘッダの保護 2021年10月14日 木曜日</a>](#quicをゆっくり解説11ヘッダの保護-2021年10月14日-木曜日)
      * [<a href="https://eng-blog.iij.ad.jp/archives/11035" rel="nofollow">QUICをゆっくり解説(12)：確認応答(ACK) 2021年10月19日 火曜日</a>](#quicをゆっくり解説12確認応答ack-2021年10月19日-火曜日)
      * [<a href="https://eng-blog.iij.ad.jp/archives/11048" rel="nofollow">QUICをゆっくり解説(13)：ロス検知 2021年10月26日 火曜日</a>](#quicをゆっくり解説13ロス検知-2021年10月26日-火曜日)
      * [<a href="https://eng-blog.iij.ad.jp/archives/11144" rel="nofollow">QUICをゆっくり解説(14)：輻輳制御 2021年11月02日 火曜日</a>](#quicをゆっくり解説14輻輳制御-2021年11月02日-火曜日)
      * [<a href="https://eng-blog.iij.ad.jp/archives/11166" rel="nofollow">QUICをゆっくり解説(15)：HTTP/3 2021年11月10日 水曜日</a>](#quicをゆっくり解説15http3-2021年11月10日-水曜日)
      * [<a href="https://eng-blog.iij.ad.jp/archives/11419" rel="nofollow">QUICをゆっくり解説(16)：ヘッダ圧縮 2021年11月17日 水曜日</a>](#quicをゆっくり解説16ヘッダ圧縮-2021年11月17日-水曜日)
         * [おわりに](#おわりに)
   * [QUIC at 10,000 feet](#quic-at-10000-feet)
   * [Reference](#reference)
   * [h1 size](#h1-size)
      * [h2 size](#h2-size)
         * [h3 size](#h3-size)
            * [h4 size](#h4-size)
               * [h5 size](#h5-size)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)# Purpose

# Purpose  

# QUICをゆっくり解説  
[QUICをゆっくり解説 – 新しいインターネット通信規格](https://eng-blog.iij.ad.jp/quic)
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/06/7bdb569284dfaab45ed8e75ceadea7c7.png" width="700" height="300">  

## [QUICをゆっくり解説(1)：QUICが標準化されました 2021年07月01日 木曜日](https://eng-blog.iij.ad.jp/archives/10039)
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/06/a11b4bb3ba448d1fa402ac3dc62cc91f-4.png" width="700" height="300">  

### 4. 標準化の動向  
RFC9000ばかりが話題になっていますが、現時点では以下の4つがRFCとなりました。
[RFC8999: Version-Independent Properties of QUIC](https://www.rfc-editor.org/rfc/rfc8999.html)
[RFC9000: QUIC: A UDP-Based Multiplexed and Secure Transport](https://www.rfc-editor.org/rfc/rfc9000.html)
[RFC9001: Using TLS to Secure QUIC](https://www.rfc-editor.org/rfc/rfc9001.html)
[RFC9002: QUIC Loss Detection and Congestion Control](https://www.rfc-editor.org/rfc/rfc9002.html)

また、以下の2つの草稿がRFCになるのを待っています。
[Hypertext Transfer Protocol Version 3 (HTTP/3)](https://datatracker.ietf.org/doc/html/draft-ietf-quic-http)
[QPACK: Header Compression for HTTP/3](https://datatracker.ietf.org/doc/html/draft-ietf-quic-qpack)

[HTTP Semantics](https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-semantics)

### 5. 普及状況  
```
Firefoxの場合、「ツール」メニューから「ブラウザーツール」「ウェブ開発ツール」として開発ツールを表示さて、URLを入力します。
「ネットワーク」で通信の一覧を表示し、www.google.com の通信のどれかを選択します。
ここでHTTP/2と表示される場合は、ページをリロードしてみてください。
(社内のネットワークなど、環境によってはリロードしてもうまくいかないことがあります。)
```
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/06/firefox-dev-tool-1024x238.png" width="700" height="200">  

```
Chromeでは、QUIC Indicatorという拡張機能を入れておけば、QUICで通信をした際、URL右横のアイコンが緑色になります。
```
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/06/quic-indicator-1024x33.png" width="700" height="20">  

```
緑にならない場合は、リロードをお願いします。
また、「表示」メニューから「開発/管理」「デベロッパー ツール」を選択して、URLを入力し、
「ネットワーク」タブを選択することでも、確かめられます。
```
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/06/chrome-dev-tool-1024x273.png" width="700" height="200">  

```
上記のスクリーンショットでは、草稿のバージョン29(h3-29)が利用されていると分かります。
最後に、Chromeの開発版であるCanaryが google.com に通信したときのパケットダンプを Wireshark で表示してみましょう。
```
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/06/chrome-0rtt-1024x50.png" width="700" height="30">  

## [QUICをゆっくり解説(2)：ネゴせよ 2021年07月16日 金曜日](https://eng-blog.iij.ad.jp/archives/10283)  
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/07/a11b4bb3ba448d1fa402ac3dc62cc91f-2.png" width="700" height="300">  

## [QUICをゆっくり解説(3)：QUICパケットの構造 2021年08月11日 水曜日](https://eng-blog.iij.ad.jp/archives/10539)
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/08/a11b4bb3ba448d1fa402ac3dc62cc91f.png" width="700" height="300">  

## [QUICをゆっくり解説(4)：ハンドシェイク 2021年08月16日 月曜日](https://eng-blog.iij.ad.jp/archives/10582) 
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/08/a11b4bb3ba448d1fa402ac3dc62cc91f-2.png" width="700" height="300">  

## [QUICをゆっくり解説(5)：2回目以降のハンドシェイクと0-RTT 2021年08月25日 水曜日](https://eng-blog.iij.ad.jp/archives/10620)
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/08/a11b4bb3ba448d1fa402ac3dc62cc91f-6.png" width="700" height="300">  

## [QUICをゆっくり解説(6)：増幅攻撃との戦い](https://eng-blog.iij.ad.jp/archives/10660)
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/08/a11b4bb3ba448d1fa402ac3dc62cc91f-7.png" width="700" height="300">  

## [QUICをゆっくり解説(7)：アプリケーションデータとストリーム 2021年09月10日 金曜日](https://eng-blog.iij.ad.jp/archives/10710)
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/08/a11b4bb3ba448d1fa402ac3dc62cc91f-9.png" width="700" height="300">  

## [QUICをゆっくり解説(8)：フロー制御 2021年09月15日 水曜日](https://eng-blog.iij.ad.jp/archives/10748)
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/09/a11b4bb3ba448d1fa402ac3dc62cc91f.png" width="700" height="300">  

### 1. フロー制御と輻輳制御  
### 2. QUICのフロー制御
### 3. ウインドウとクレジット  

## [QUICをゆっくり解説(9)：コネクションの終了 2021年09月22日 水曜日](https://eng-blog.iij.ad.jp/archives/10757)
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/09/a11b4bb3ba448d1fa402ac3dc62cc91f-1.png" width="700" height="300">  

### 正常な終了  
```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                         Error Code (i)                      ...
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                         Frame Type (i)                      ...
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Reason Phrase Length (i)                 ...
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                        Reason Phrase (*)                    ...
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

```

```
各フィールドの意味は以下のとおりです。

エラーコード(Error Code)は、その名のとおりエラーコードの値を入れます。正常終了の場合は 0 を入れます

フレーム型(Frame Type)は、原因となったフレーム型の値を入れます。原因が不明の場合は、0を入れます

理由フレーズの長さ(Reason Phrase Length)には、理由フレーズのバイト数を入れます。理由フレーズを省略する場合は、0を入れます

理由フレーズ(Reason Phrase)は、終了の原因の説明です。UTF-8の文字列を入れます
```
### エラー終了
```
QUICのコネクションをエラー終了させる方法は2つあります。
終了の原因がQUICに起因したものであれば、前述のCONNECTION_CLOSEフレームに適切なエラーコードを入れます。
終了の手続きは、正常終了の場合と同じです。以下にエラーコードの一部を示します。

0x01 – 内部エラー
0x02 – コネクションの拒否
0x03 – フロー制御のエラー
```

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                         Error Code (i)                      ...
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Reason Phrase Length (i)                 ...
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                        Reason Phrase (*)                    ...
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

```
フレーム型のフィールドがないことを除いては、最初に述べたQUICに起因するCONNECTION_CLOSEフレームと同じです。
HTTP/3で定義されているエラーコードの一部を以下に示します。

0x100 – エラーなし (この場合は正常終了)
0x101 – HTTP3 の一般的なプロトコルエラー
0x102 – HTTP3 の内部エラー
0x103 – HTTP3 ストリームの生成に関するエラー
```

### リセット
#### TCP のリセット
[TCPではセキュリティ](https://www.rfc-editor.org/rfc/rfc5961.html)
```
TCPで相手のコネクションをリセットする際は、RSTフラグの立ったTCPセグメントを送ります。
現在のTCPではセキュリティが厳しくなっており、リセットの場合に指定するシーケンス番号は、
相手の期待している値でなければなりません。

状態を失ったというのに、どうやって正しいシーケンス番号を得るのでしょうか？

通常のTCPでは、最初のSYNパケット以外は、ACK情報が付加されています。
ですので、ACK情報から期待されているシーケンス番号を取り出せます(下図)。
```

#### QUIC のリセット

```
QUICでは、TCPよりも話が難しくなります。なぜなら、QUICパケットは暗号化されているからです。
あるコネクションに対して、サーバは暗号化/復号用の鍵を失っています。
この問題を解決するために、QUICではステートレス・リセット・トークンを使います。

ステートレス・リセット・トークンは、そのサーバだけが静的に生成でき、コネクションIDごとに異なるバイト列です。
たとえば、ハッシュ関数に「サーバの秘密鍵＋コネクションID」を入力することで、このようなトークンを生成できるでしょう。

QUICでは、最初のInitailパケットを除くと、相手が送ってくるパケットには、
終点のIDとして自分の生成したコネクションIDが平文で格納されています。
ですので、たとえコネクションに対する復号用の鍵を失っていたとしても、任意のパケットを受け取ると、
ステートレス・リセット・トークンを生成できます。

サーバは、ハンドシェイクの際に、自分が生成したコネクションIDに対するステートレス・リセット・トークンを相手に伝えることができます。
また、コネクションが確立した後は、両者とも NEW_CONNECTION_ID フレームを使って、新しいコネクションIDとそれに対するステートレス・
リセット・トークンを相手に通知することもできます。

コネクションをリセットするときは、以下のようなパケットを生成し、相手に送信します。
```

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|0|1|               Unpredictable Bits (38 ..)                ...
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                                                               |
+                                                               +
|                                                               |
+                   Stateless Reset Token (128)                 +
|                                                               |
+                                                               +
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

```
この書式の要点は2つです：

    リセット用のパケットは、1-RTTパケットに擬態しています
    ステートレス・リセット・トークンは、パケットの末尾16バイトに埋め込まれています
```

```
受信側は、このパケットの復号に失敗します。
その際に、末尾の16バイトを調べ、相手から通知されたステートレス・リセット・トークンに一致した場合、
コネクションを直ちに終了します(下図)。
```
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/09/08-quic-rst.png" width="700" height="300">  


## [QUICをゆっくり解説(10)：コネクションのマイグレーション 2021年10月06日 水曜日](https://eng-blog.iij.ad.jp/archives/10892)
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/10/a11b4bb3ba448d1fa402ac3dc62cc91f.png" width="700" height="300">  


## [QUICをゆっくり解説(11)：ヘッダの保護 2021年10月14日 木曜日](https://eng-blog.iij.ad.jp/archives/11018)
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/10/a11b4bb3ba448d1fa402ac3dc62cc91f-2.png" width="700" height="300">  

## [QUICをゆっくり解説(12)：確認応答(ACK) 2021年10月19日 火曜日](https://eng-blog.iij.ad.jp/archives/11035)
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/10/a11b4bb3ba448d1fa402ac3dc62cc91f-3.png" width="700" height="300">  

## [QUICをゆっくり解説(13)：ロス検知 2021年10月26日 火曜日](https://eng-blog.iij.ad.jp/archives/11048)
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/10/a11b4bb3ba448d1fa402ac3dc62cc91f-4.png" width="700" height="300">  

## [QUICをゆっくり解説(14)：輻輳制御 2021年11月02日 火曜日](https://eng-blog.iij.ad.jp/archives/11144)
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/10/a11b4bb3ba448d1fa402ac3dc62cc91f-5.png" width="700" height="300">  

## [QUICをゆっくり解説(15)：HTTP/3 2021年11月10日 水曜日](https://eng-blog.iij.ad.jp/archives/11166)
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/11/a11b4bb3ba448d1fa402ac3dc62cc91f.png" width="700" height="300">  

## [QUICをゆっくり解説(16)：ヘッダ圧縮 2021年11月17日 水曜日](https://eng-blog.iij.ad.jp/archives/11419)
<img src="https://eng-blog.iij.ad.jp/wp-content/uploads/2021/11/a11b4bb3ba448d1fa402ac3dc62cc91f-1.png" width="700" height="300">  

### おわりに  
```
QPACKの伸長側は、圧縮側の指示どおりに動作するだけなので、実装はそれほど難しくはありません。
一方で、圧縮側は圧縮方法の戦略に幅があり、考慮すべきことが多いと言えます。
私の現時点の実装では、圧縮側は動的表を全く利用していません。
この記事を書いたことをきっかけに、実装に挑戦してみようかと思います。

これまでの16回の連載で、QUICに関しては全体を網羅できたと思います。
この記事をもちまして、「QUICをゆっくり解説」は一区切りとします。
今後は、気が向いたときに落ち穂拾いのような内容をお届けできればよいなと考えています。

最後に、3歳になった娘の寝付きは、全然よくなっていないことを申し添えておきます。
```


## []()
<img src="" width="700" height="300">  
## []()
<img src="" width="700" height="300">  
## []()
<img src="" width="700" height="300">  

# QUIC at 10,000 feet
[QUIC at 10,000 feet](https://docs.google.com/document/d/1gY9-YNDNAB1eip-RTPbqphgySwSNSDHLq9D5Bty4FSU/edit)  
Key advantages of QUIC over TCP+TLS+HTTP2 include:  
* Connection establishment latency  
* Improved congestion control  
* Multiplexing without head-of-line blocking  
* Forward error correction  
* Connection migration  

[Introducing QUIC support for HTTPS load balancing June 13,2018](https://cloudplatform.googleblog.com/2018/06/Introducing-QUIC-support-for-HTTPS-load-balancing.html)  

# Reference
* [HTTP/3 傳輸協議 - QUIC 簡介 May 28](https://medium.com/@chester.yw.chu/http-3-%E5%82%B3%E8%BC%B8%E5%8D%94%E8%AD%B0-quic-%E7%B0%A1%E4%BB%8B-5f8806d6c8cd?sk=6440d24938b77bf68915a064cfaf6e46)  


```
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


