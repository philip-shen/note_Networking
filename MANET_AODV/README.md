# Purpose
Create personal GitHub Pages in github.io domain.
Setup up individual GitHub Pages site locally with Jekyll by Docker more quickly and easily.

# 

# Troubleshooting


# Reference
* [600.647 - Advanced Topics in Wireless Networks, Spring 08](https://www.cs.jhu.edu/~cs647/)
* [第7回 AODV(Ad hoc On-Demand Distance Vector)プロトコル 2003/5/22](https://internet.watch.impress.co.jp/www/column/wp2p/wp2p07.htm)
* [アドホックネットワークの概要と技術動向 千葉大学大学院 阪田 史郎 2005年2月26日](https://slidesplayer.net/slide/11226125/)
* [創発システムに向けて 慶應義塾大学環境情報学部 徳田英幸](https://slidesplayer.net/slide/11499738/)
* [第5回 DSR（Dynamic Source Routing）プロトコル 2003年3月5日](https://internet.watch.impress.co.jp/www/column/wp2p/wp2p05.htm)
* [第6回　OLSR（Optimized Link State Routing）プロトコル 2003年4月15日](https://internet.watch.impress.co.jp/www/column/wp2p/wp2p06.htm)
* [第7回 AODV(Ad hoc On-Demand Distance Vector)プロトコル 2003年5月27日](https://internet.watch.impress.co.jp/www/column/wp2p/index.htm)

* [DSDV VS AODV Published on Sep 19, 2014](https://www.slideshare.net/SenthilKanth/dsdv-dsr-aodvtuto)

* [Shashank95/AODV-vs-DSDV-vs-DSR-on-NS2.35 - GitHub 8 Apr 2017](https://github.com/Shashank95/AODV-vs-DSDV-vs-DSR-on-NS2.35)
* [joshjdevl/docker-ns3  29 Apr 2014](https://github.com/joshjdevl/docker-ns3)
* [[ns-3] Cloning MANET Routing Protocols in ns-3 November 7, 2015](http://mohittahiliani.blogspot.com/2015/11/ns-3-cloning-manet-routing-protocols-in.html)
```
 This post provides a "python script" to clone AODV, DSDV, OLSR or DSR in ns-3. By cloning, we mean that an identical copy of an existing protocol is created in ns-3, but with a different name. 

Once the clone is created, you can modify it for your research work without affecting the original code of existing protocols in ns-3.

Warning: DSR cloning will work only for ns-3.25 and higher versions of ns-3!

python script
```

```
 Steps to create a clone:

1. Download the python script: clone-manet-routing.py
2. Place it in ns-allinone-3.xx/ns-3.xx/src directory
3. Go to ns-allinone-3.xx/ns-3.xx/src via terminal and give the following command:
chmod 777 clone-manet-routing.py

4. Give the following command to create a clone of AODV:
./clone-manet-routing.py aodv myaodv

5. Go to ns-allinone-3.xx/ns-3.xx/ via terminal and give the following commands:
./waf configure --enable-examples
./waf

You are done with it!
Note: Replace aodv by dsdv, olsr or dsr in Step 4 to clone DSDV, OLSR or DSR respectively.
```

```
Verifying the working of a clone:

1. Copy myaodv.cc from ns-allinone-3.xx/ns-3.xx/src/myaodv/examples
2. Paste it in ns-allinone-3.xx/ns-3.xx/scratch
3. Give the following command from ns-3.xx directory to run it:

./waf --run scratch/myaodv

If the command succeeds, you have successfully cloned AODV to MYAODV.
```

* [NS-3_MANET_Projects 24 Dec 2016](https://github.com/setu4993/NS-3_MANET_Projects)
```
All of the programs written (and edited from examples) for implementation of various Mobile Ad-Hoc Networks in Network Simulator-3 for class projects. 
C++
```

* [ns-3.26で始めるネットワークシミュレーション Feb 06, 2017](https://qiita.com/haltaro/items/b474d924f63692c155c8)
* [ns-3でTCPの輻輳制御を観察する Feb 20, 2017](https://qiita.com/haltaro/items/d479538345357f08c595)
* [ns-3構築を爆速で終わらせるためのシェルスクリプト Jul 29, 2018](https://qiita.com/wawawa/items/02984c882816966c5583)

* [how can i extract delay and throughput from manet-routing-compare.cc in ns3? Apr 29 '17](https://stackoverflow.com/questions/43700595/how-can-i-extract-delay-and-throughput-from-manet-routing-compare-cc-in-ns3)

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
