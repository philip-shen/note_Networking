# Purpose



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
