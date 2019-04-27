#***************************************************************
#
#  Purpose Test ChrPairs
#
#***************************************************************
set currpath [file dirname [info script]]
set lib_path [file join  ".." "lib"]
source "$lib_path/API_Misc.tcl"
# source "$lib_path/API_Chariot.tcl"

set inifile [file join [file dirname [info script]] setup.ini]
################################################################################
# Get INI file paramter
################################################################################
# Func_INI::Ping_igp "192.168.1.152"
set Func_INI::verbose on;#on off

Func_INI::_GetChariot_Param $inifile
Func_INI::_GetDUT $inifile
Func_INI::Ping_igp "192.168.1.1"
Func_INI::_GetTopologyIP $inifile
Func_INI::_GetWLAN_ClientModelName $inifile
Func_INI::_GetCriteria $inifile


#***************************************************************
#
# Script main
#
# catch is used when there could be extended error information,
# so we can log what happened.
#***************************************************************
set Func_Chariot::verbose off;#on off

# Create a new test.
Func_Chariot::Initialize

# Set the test filename for saving later.
Func_Chariot::Test_Filename

# Set test duration
set Func_Chariot::test_duration [dict get $Func_INI::dict_Chariot_Param "test_duration"]
# puts $Func_Chariot::test_duration
Func_Chariot::SetRunOpts

#Set chariot related parameters
set Func_Chariot::pairCount [dict get $Func_INI::dict_Chariot_Param "paircount"]
set Func_Chariot::e1Addrs [dict get $Func_INI::dict_TopologyIP  "lan_ep_ipaddr"]
set Func_Chariot::e2Addrs [dict get $Func_INI::dict_TopologyIP  "wlan_ep_ipaddr"]
set Func_Chariot::protocols [dict get $Func_INI::dict_Chariot_Param "protocols"]
set Func_Chariot::chrscript [dict get $Func_INI::dict_Chariot_Param "scripts"]

# Define some pairs for the test.
Func_Chariot::SetChrPair

Func_Chariot::RunTest_tillEnd