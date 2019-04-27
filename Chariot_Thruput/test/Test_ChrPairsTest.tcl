#***************************************************************
#
#  Purpose Test ChrPairs
#
#***************************************************************
set currpath [file dirname [info script]]
set lib_path [file join  ".." "lib"]
source "$lib_path/API_Misc.tcl"
source "$lib_path/API_Chariot.tcl"

set inifile [file join [file dirname [info script]] setup.ini]
################################################################################
# Get INI file paramter
################################################################################
# Func_INI::Ping_igp "192.168.1.152"

Func_INI::_GetChariot_Param $inifile
Func_INI::_GetDUT $inifile
Func_INI::Ping_igp "192.168.1.1"
Func_INI::_GetTopologyIP $inifile
Func_INI::_GetWLAN_ClientModelName $inifile
Func_INI::_GetCriteria $inifile

set Func_INI::verbose on;#on off

#***************************************************************
#
# Script main
#
# catch is used when there could be extended error information,
# so we can log what happened.
#***************************************************************


