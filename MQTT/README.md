# Purpose
Take note of MQTT  

# Table of Contents  
[Programming for IoT, major in MQTT]() 

# Programming for IoT, major in MQTT  
[IoT時代のプログラミング（主にMQTTについて）Jul 19, 2017](https://qiita.com/darai0512/items/37158f56e9a6b4ce83ed)  
## MQTTとは  
Message Queuing Telemetry Transport
非常に軽量なプロトコル
    2000年代初めに登場し標準化
    TCP/IP上で動く
publish/subscribe型のメッセージ転送
IoT/モバイルに適する
    センサーデバイス
    Facebook Messengerで使われている

## Publish/Subscribe  
[Publish/Subscribe](https://qiita.com/darai0512/items/37158f56e9a6b4ce83ed#publishsubscribe)  
```
メッセージの送信者(publisher)が特定の受信者(subscriber)に直接メッセージを送信しない
メッセージのやりとりにはBrokerと呼ばれる中継serverが必要
    サーバーがメッセージを保管するため受信側の状態に関係なくメッセージを送れる
        オフラインでもOK
    publisher/subscriberがMQTT client
接続時のデバイスIDが被ると古い接続が切れる
```
## message(= topic + data)  
[message(= topic + data)](https://qiita.com/darai0512/items/37158f56e9a6b4ce83ed#message-topic--data)  
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.amazonaws.com%2F0%2F100881%2Fe5d47fe6-711b-57ff-1256-e3087b318432.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&s=23c27fc2d7aff32019c99d0566a04b1f)

## topic  
```
一般的に/(スラッシュ)で階層化3
    ex, tokyoA/temp
ワイルドカード(#,+)
mosquittoなどの一部ブローカーにはACL機能有り
```

## QoS  
```
client間のメッセージ到達保証レベル(Quality of Service)
通常は0、コントロール系のメッセージは1以上、が基本
    1以上はbrokerでstoreが必要
Kafkaの例だが佐伯さんのスライドがわかりやすい
```

level | desc | example
------------------------------------ | --------------------------------------------- | ---------------------------------------------
0 | At most once(メッセージ到達保証無) | subscriberの受信失敗時のケアがない、など
1 | At least once(届くけど重複するかも) | subscriberのACK受信失敗時に再送、など
2 | Exactly once(確実に重複無く届ける) | transaction制御、速度低下

```
（閑話）ログの質が精度を分ける

    米テックジャイアントのログ収集は実は雑
        重複やロストは気にしない
        ログ設計はすごい。デモグラなど混ぜて1レコードに豊富な情報量
    重複もロストも許さないログでディープラーニングにかけたら、モデルの精度がテックジャイアントより高かった
        precision/recallがほぼ1
        1レコードは購買やPVなど基本情報のみ
        日本向けサービス同士の比較なので、日本語の壁など外的要因な可能性も

※社外秘のため詳細は公開しません
```

## MQTT Broker  
OSS  
    [mosquitto](https://github.com/eclipse/mosquitto)  
cloud  
    [cloudMQTT](https://www.cloudmqtt.com/)  
    [ニフティクラウド](http://cloud.nifty.com/service/mqtt.htm)  
公開MQTTテスト用ブローカー  
    [iot.eclipse.org](https://eclipse.org/paho/clients/js/utility/)  

## MQTT Clinet    
OSS  
    [paho](https://eclipse.org/paho/)  
    [PubSubClient](https://github.com/knolleary/pubsubclient)  

[MQTTのパケットを覗いてみた ↩](https://mm011106.github.io/2014/12/20/mqtt-packets/)  
[MQTTにおけるトランスポート層セキュリティのトレードオフ ↩](https://www.wolfssl.jp/wolfblog/2016/02/19/transport-level_security_tradeoffs_using_mqtt/)  
[初めての MQTT ↩](https://gist.github.com/voluntas/89000a06a7b79f1230ab#topic)  

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
