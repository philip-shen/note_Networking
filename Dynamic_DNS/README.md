# Purpose

# Table of Contents  

# Get Domain from DDNS setting  
[ドメイン取得からDDNS設定まで May 08, 2015](https://qiita.com/mizuki_takahashi/items/b0c5adebea48b9f2f7a6)  
## 早速ドメイン取得  
[早速ドメイン取得](https://qiita.com/mizuki_takahashi/items/b0c5adebea48b9f2f7a6#%E6%97%A9%E9%80%9F%E3%83%89%E3%83%A1%E3%82%A4%E3%83%B3%E5%8F%96%E5%BE%97)  
```
ドメイン取得業者にも色々特徴はあるのですが、
以降、お名前.comでのドメインを取得した場合の説明となります。
```
## DDNS(Dynamic DNS)の設定  
[DDNS(Dynamic DNS)の設定](https://qiita.com/mizuki_takahashi/items/b0c5adebea48b9f2f7a6#ddnsdynamic-dns%E3%81%AE%E8%A8%AD%E5%AE%9A)  

DDNS(ダイナミックDNSサービス)は有料・無料多数ありますが、
私も愛用している「MyDNS」の設定を紹介します。(無料)

```
1. トップページ上部の「JOIN US」からユーザー登録
2. 登録したメールアドレスにMasterIDとPasswordが送られてくるのでログイン
3. 「Welcome Administratar」欄の「DOMAIN INFO」を選択
4. 下記のようにお名前.comで取得したドメイン名を「Domain」欄に入力して「CHECK」ボタンを選択 
```
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.amazonaws.com%2F0%2F53476%2F04762ab7-f725-0121-ecbb-0bc02b7a4c27.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&s=3a9d472f6b350f8188fd983c1c8e4141)  

```
5. 「Welcome Administratar」欄の「IP ADDRESS DIRECT」を選択
6. 下記のように自宅回線の動的IPアドレスを入力して「CHECK」ボタンを選択
→ 自宅回線のIPアドレスを知るにはココをクリック mydns_ip_address_direct.png 
```
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.amazonaws.com%2F0%2F53476%2F3fcc316b-c5fa-09b0-f81d-1346f3b5ee20.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&w=1400&fit=max&s=d23f2923c6d3894f2582ee59ab6fc0e8)  

## お名前.comでネームサーバーをMyDNSを使用するように設定  
[お名前.comでネームサーバーをMyDNSを使用するように設定](https://qiita.com/mizuki_takahashi/items/b0c5adebea48b9f2f7a6#%E3%81%8A%E5%90%8D%E5%89%8Dcom%E3%81%A7%E3%83%8D%E3%83%BC%E3%83%A0%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E3%82%92mydns%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%99%E3%82%8B%E3%82%88%E3%81%86%E3%81%AB%E8%A8%AD%E5%AE%9A)  

```
1. お名前.comのマイページへログイン
2. 「ドメイン設定」→「ネームサーバーの変更」→「取得したドメイン(hogehoge.com)」の順に選択
3. 「他のネームサーバーを利用」を選択し、下記のように設定
    1プライマリネームサーバー＝ns0.mydns.jp
    2セカンダリネームサーバー＝ns1.mydns.jp
    3＝ns2.mydns.jp ※設定できるなら
```
![alt tag](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.amazonaws.com%2F0%2F53476%2F1df2c6e4-aed5-da59-3858-1d95c7ae411b.png?ixlib=rb-1.2.2&auto=compress%2Cformat&gif-q=60&w=1400&fit=max&s=7b219a143c5670c27d569af0b9ee9b45)  

```
4.最後に「確認画面へ進む」を選択後「設定する」を押下し反映

※反映完了まで24時間から72時間程度かかる場合があります。
```

# DDNS(MyDNS)を定期的に更新  
[DDNS(MyDNS)を定期的に更新 2015-06-10](https://qiita.com/mizuki_takahashi/items/89699f87fb10d812748a)  

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
