# Purpose
Take note of Testing Suites for OpenWRT project  

# Table of Contents  

# 
* [richb-hanover/OpenWrtScripts: A set of scripts for maintaining](https://github.com/richb-hanover/OpenWrtScripts)  
```  
This is a set of scripts (sometimes also called "Openscripts") that report, configure and measure (and improve) latency in home routers (and everywhere else!) These scripts work equally well for both LEDE and OpenWrt and include:

    getstats.sh - a script to collect troubleshooting information that helps to diagnose problems in the OpenWrt distribution.

    opkgscript.sh - a script to save the list of currently-installed packages (say, before a sysupgrade), and then restore the full set of packages after the upgrade.

    config-openwrt.sh - a script to configure the OpenWrt router consistently after flashing factory firmware.

    betterspeedtest.sh & netperfrunner.sh & networkhammer.sh - scripts that measure the performance of your router or offer load to the network for testing.

    tunnelbroker.sh - a script to set up a IPv6 6-in-4 tunnel to TunnelBroker.net.
```  

* [mattsm/boardfarm Automated testing with python](https://github.com/mattsm/boardfarm/)
[Software Setup](https://github.com/mattsm/boardfarm/#software-setup)  
```  
If you are a Linux user, and wish to run and/or develop tests, please clone this repository and then install needed libaries:

apt-get install python-pip curl python-tk libsnmp-dev snmp-mibs-downloader
cd openwrt/
pip install -r requirements.txt

The file config.py is the main configuration. For example, it sets the location of the file that describes the available hardware.
```  

# Troubleshooting


# Reference

* [performance_tuning – Gateworks Sep 11, 2018](http://trac.gateworks.com/wiki/performance_tuning)  
* [How to Set-up Specific Network Conditions for Software Testing? July 27, 2017](https://www.testdevlab.com/blog/2017/07/how-to-set-up-specific-network-conditions-for-software-testing/) * [Using Xray for Test Management in Jira July 11, 2019](https://www.testdevlab.com/blog/2019/07/using-xray-for-test-management-in-jira/)  
* [Setting up Router Traffic Mirroring to Wireshark August 24, 2017](https://www.testdevlab.com/blog/2017/08/setting-up-router-traffic-mirroring-to-wireshark/)  

* [uweber/mausezahn  25 Nov 2010](https://github.com/uweber/mausezahn)  
```  
IPv6 support for Mausezahn traffic generator http://www.perihel.at/sec/mz/
```  
* [An Evaluation of Software-Based Traffic Generators using Docker SWEDEN2018 SAI MAN WONG](http://www.nada.kth.se/~ann/exjobb/sai-man_wong.pdf)  
```  
4.3.3  OstinatoOstinato is compatible with Windows, Linux, BSD and macOS [22, 60]. This tool issimilar to Mausezahn as it can craft, generate and analyze packets. Also, Ostinatosupports protocols from layer 2 to 7, for example, Ethernet/802.3, VLAN, ARP,IPv4, IPv6, TCP, UDP and HTTP to only mention a few. Its architecture consistsof controller(s) and agent(s). That is, it is possible to use either a GUI or PythonAPI as a controller to manage the agent and generate streams of packets from asingle or several machines at the same time.The Ostinato solution consists of the imagessaimanwong/ostinato-droneandsaimanwong/ostinato-python-api, as shown in Appendix B.3 and Appendix B.4 respectively. The first image creates a container with an Ostinato agent that waitsfor instructions to generate packets. Finally, the second image spins up a controllercontainer to communicate with the agent via a Python script
```  
[saimanwong/mastersthesis](https://github.com/saimanwong/mastersthesis)  

* [網絡測試工具--Iperf、Netperf 、MZ  2018-08-31](https://www.itread01.com/content/1535702289.html)  
```  
MZ

Mausezahn是什麽？

它是一個用C語言開發的快速產生流量的工具，用戶可以用它來發送幾乎所有可能和不可能產生的包。它可以用來做如下工作：
```  
* [15 Best Free Packet Crafting Tools - Infosec Resources Mar 4, 2018](https://resources.infosecinstitute.com/15-best-free-packet-crafting-tools/#gref)  
* [How to Perform DDoS Test as a Pentester December 3, 2016](https://pentest.blog/how-to-perform-ddos-test-as-a-pentester/)  
 


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
