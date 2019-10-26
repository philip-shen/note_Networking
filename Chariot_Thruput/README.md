# Purpose
Throuput Test(LAN<--->WLAN; WLAN<--->WAN; WLAN<--->WAN) via Chariot by Tcl

# Table of Contents  
[Topology](#topology)  

[PreTest Environment](#pretest-environment)  

[Setup Procedure](#setup-procedure)  
    [*Installation version of Tcl/Tk is x86 not x64, even on Win 10.*](#installation-version-of-tcltk-is-x86-not-x64-even-on-win-10)  
    [Git clone this project](#git-clone-this-project)  
    [Files Directory](#files-directory)  
    [Edit setup.ini to meet your testing topology](#edit-setupini-to-meet-your-testing-topology)  
    [Debug Mode Enable/Disable setting](#debug-mode-enabledisable-setting)  
    [Double Click test_chariot_gui.tcl](#double-click-test_chariot_guitcl)  
    [Click Button on Widget](#click-button-on-widget)  
    [Check Log Folder for Result](#check-log-folder-for-result)  

[QoS Test](#qos-test)  
[Topology](#topology-1)  

[Reference](#reference)  

# Topology  
## WLAN-->LAN-->WLAN  Chariot Thruput Test  
![alt tag](https://i.imgur.com/hkKDpW6.jpg)  
(Diagram made with [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/))  

## WAN-->W/LAN-->WAN  Chariot Thruput Test  
![alt tag](https://i.imgur.com/RiAvpgf.jpg)  
(Diagram made with [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/))  

# PreTest Environment  
## ixChariot 6.7  
## Win7 32bit, 64bit  
## Win10 64bit  
*The utility recommends to host on end point of LAN side*   

## IxChariot via Tcl  
[Working with IxChariot from TestShell Studio and Runner 04/24,2015](https://community.quali.com/articles/2555/working-with-ixchariot-from-testshell-studio-and-r)  
### Set up  
```  
Best to avoid ActiveState TCL and instead get the TCL server from Ixia. 
For this, you may need to download the IxOS which contains an installer for this. 
In the download, there are two files which relate to TCL. 
One is a CAB and another is a .msi installer for TCL 8.5. The latter is the one you need to run. 
It should install under IxChariot so you should end up with 
"C:\Program Files (x86)\Ixia\Tcl\8.5.12.0" 
(it may be the version changes over time since this article was posted).

To run a test through TCL, you can try one of the samples that come with IxChariot. 
The script I tried is called ChrPairsTest.tcl and is found under "C:\Program Files (x86)\Ixia\IxChariot\SDK\samples\tcl" typically.
```  
### Running a Chariot Test via TCL  
```  
Firstly, you should run the test from the IxChariot installation folder (this is critical). 
Typically this is "C:\Program Files (x86)\Ixia\IxChariot" so cd here. 
Next you will need to invoke the tclsh.exe which is located in 
"C:\Program Files (x86)\Ixia\Tcl\8.5.12.0\bin". 
Either use the relative path to this, or add the path to the PATH environment variable 
and use tclsh.exe. The single argument is the path to the sample test TCL script.

The test should run and you should see some output. 
At the end, a file (suffix tst) will be created. So for TCL script ChrPairsTest.tcl, 
you will get chrpairstest.tst. This contains output from the test.
```  

# Setup Procedure  
## Installation version of Tcl/Tk is x86 not x64, even on Win 10.
[How to load a dll in Tcl? Aug 11, 2013](https://stackoverflow.com/questions/18171997/how-to-load-a-dll-in-tcl)  

## Git clone this project 
[philip-shen/note_Networking](https://github.com/philip-shen/note_Networking)  

## Files Directory  
```  
Chariot_Thruput
│
main--->Main Tcl Scripts for production test.
│
lib--->The library folder inculdes Chariot scripts.
│
log--->Test rsults and log infos.
│
test--->Tcl Test scripts for development.
│
```  

## Edit setup.ini to meet your testing topology  
```  
; --------------------------------------
; Chariot Thruput test case variables
; -------------------------------------
[DUT]
DUT_ModelName= DD
DUT_FWVer= 1.05
DUT_HWVer= A1

[WLAN_Client]
;WLAN_ModelName= ASUS PCE-AC88
;WLAN_ModelName= DWA-192A1
WLAN_ModelName= AC8260
;WLAN_ModelName= ASUS PCE-AC66

[Topology]
WAN_EP_IPAddr=10.0.0.2
DUT_WAN_IPAddr=10.0.0.1
DUT_LAN_IPAddr=192.168.1.1

WLAN_EP_IPAddr=127.0.0.1
;LAN_EP_IPAddr=127.0.0.1

;WLAN_EP_IPAddr=192.168.1.106
LAN_EP_IPAddr=192.168.0.102

[Criteria]
Thruput_11N_Avg= 300
Thruput_11AC_Avg= 500

[Chariot_Param]
Chariot_Path= C:\Program Files (x86)\Ixia\IxChariot
;Chariot_Path= D:\Program Files\Ixia\IxChariot
Scripts= High_Performance_Throughput.scr
Protocols= TCP
PairCount= 2
ReTest=    1
;unit:sec
Timeout= 5
Test_duration= 2
```  
## Debug Mode Enable/Disable setting
```  
set Func_INI::verbose on;#on off

set Func_Chariot::verbose on;#on off
```  
## Double Click test_chariot_gui.tcl  
![alt tag](https://i.imgur.com/QuC7xZL.jpg)

## Click Button on Widget 
![alt tag](https://i.imgur.com/h3aT4ze.jpg)  

##  Check Log Folder for Result  
![alt tag](https://i.imgur.com/LZllH9N.jpg)

# QoS Test  
## Topology  
![alt tag](https://i.imgur.com/Up4Dtwk.jpg)  
(Diagram made with [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/))  

# Troubleshooting  


# Reference
* [Python call Ixchariot tcl API - GitHub 8 Jun 2017](https://github.com/qdyxmas/PyIxChariot)
* [Tcl Windows API extension May 6, 2018](https://twapi.magicsplat.com/)  
* [Tcl Programming for Windows [DRAFT] 2015-01-20](https://www.magicsplat.com/book/)  
* [Tcl Windows API usage examples 2003](https://twapi.magicsplat.com/v1.1/examples.html)  
* [TclCurl 5/2013](https://wiki.tcl-lang.org/page/TclCurl)  
* [Tcl wrapper for Curl ](https://github.com/jdc8/tclcurl)  
* [How to load a dll in Tcl? Aug 11, 2013](https://stackoverflow.com/questions/18171997/how-to-load-a-dll-in-tcl)  
```
I have this problem, too,couldn't load library "ChariotExt": invalid argument.

And sovled it by change tcl version x64 to x86.
```  

```  
Title: WLAN-->LAN-->WLAN \n Chariot Thruput Test
WLAN_EP_IPAddr->DUT_LAN:
DUT_LAN->LAN_EP_IPAddr:
LAN_EP_IPAddr->DUT_LAN:
DUT_LAN->WLAN_EP_IPAddr:
```  

```  
Title: WAN-->W/LAN-->WAN \n Chariot Thruput Test
WAN_EP_IPAddr->DUT_WAN_IPAddr:
DUT_WAN_IPAddr-->DUT_LAN_IPAddr:
DUT_LAN_IPAddr-->W/LAN_EP_IPAddr(DMZ):
W/LAN_EP_IPAddr(DMZ)->WAN_EP_IPAddr:
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
