# ChangeLog
# By Philip Shen @DQA Cameo
# ---------------------------------------------------------------------
# Apr27219 Initialize 
################################################################################
namespace eval Func_INI {
    package require inifile
    
    variable verbose off
    variable logfile "../log/inifile.log"
    variable list_sections {}
    variable list_keys {}
    variable list_values {}
    variable list_TopologyIP    {}
    variable dict_TopologyIP    {}
    variable list_WLAN_ClientModelName    {}
    variable dict_WLAN_ClientModelName    {}
    variable list_Chariot_Param    {}
    variable dict_Chariot_Param    {}   
    variable list_Criteria    {}
    variable dict_Criteria    {}
    variable list_DUT    {}
    variable dict_DUT    {}
    
    variable str_LoopSimulator ""    
}
proc Func_INI::GetSections {inifname} {
    variable list_sections
    
    set hinifile [ini::open $inifname r]
    set list_sections [ini::sections $hinifile]
    ini::close $hinifile
    #list length == 0
    if ![llength $list_sections] {
        return false
    }
    return true
}
proc Func_INI::GetKeys {inifname section} {
    variable list_keys
    
    set hinifile [ini::open $inifname r]
    set list_keys [ini::keys $hinifile $section]
    ini::close $hinifile
    if ![llength $list_keys] {
        return false
    }
    return true
}
proc Func_INI::GetValue {inifname section key} {
    variable list_values
    
    set hinifile [ini::open $inifname r]
    set keyvalue [ini::value $hinifile $section $key]
    ini::close $hinifile
    
    if ![string length $keyvalue] {
        return false
    }
    
    set list_values [split $keyvalue ',']
    return true
}
proc Func_INI::Log {level filename list_msg} {
    foreach temp $list_msg {
        set msg "$temp"
        Log::tofile $level $filename $msg
    }
}

proc Func_INI::_GetTopologyIP {inifname} {
    variable list_sections
    variable list_keys
    variable list_values
    variable list_TopologyIP
    variable dict_TopologyIP
    variable verbose
    variable logfile
    
    set retval [GetSections $inifname]
    if {$retval == false} {
        return false
    }
    
    foreach temp $list_sections {
        switch -regexp $temp {
            {^Topology} {
                set sec_topology $temp
            }
        };#switch
    }
    
    set retval [GetKeys $inifname $sec_topology]
    if {$retval == false} {
        return false
    }
    
    foreach temp $list_keys {
        set retval [GetValue $inifname $sec_topology $temp]
        lappend list_TopologyIP $list_values
        
        # store to dict from ini file
        dict set dict_TopologyIP [string tolower $temp] [lindex $list_values 0]
    }
    
    if {$verbose == on} {
        # Log "info" $logfile [list "[lindex $list_keys 0] = [lindex $list_TopologyIP 0]" \
                # "[lindex $list_keys 1] = [lindex $list_TopologyIP 1]" \
                # "[lindex $list_keys 2] = [lindex $list_TopologyIP 2]" \
                # "[lindex $list_keys 3] = [lindex $list_TopologyIP 3]" \
                # "[lindex $list_keys 4] = [lindex $list_TopologyIP 4]"]
        foreach item [dict keys $dict_TopologyIP] {
            set value [dict get $dict_TopologyIP $item]
            Log "info" $logfile [list "$item = $value"]
        }
    }
    
    return true
}

proc Func_INI::_GetChariot_Param {inifname} {
    variable list_sections
    variable list_keys
    variable list_values
    variable list_Chariot_Param
    variable dict_Chariot_Param
    variable verbose
    variable logfile
    
    set retval [GetSections $inifname]
    if {$retval == false} {
        return false
    }
    
    foreach temp $list_sections {
        switch -regexp $temp {
            {^Chariot_Param} {
                set sec_chariot_param $temp
            }
        };#switch
    }
    
    set retval [GetKeys $inifname $sec_chariot_param]
    if {$retval == false} {
        return false
    }
    
    foreach temp $list_keys {
        set retval [GetValue $inifname $sec_chariot_param $temp]
        lappend list_Chariot_Param $list_values
        # store to dict from ini file
        dict set dict_Chariot_Param [string tolower $temp] [lindex $list_values 0]
    }
    
    if {$verbose == on} {
        # Log "info" $logfile [list "[lindex $list_keys 0] = [lindex $list_Chariot_Param 0]" \
                # "[lindex $list_keys 1] = [lindex $list_Chariot_Param 1]" \
                # "[lindex $list_keys 2] = [lindex $list_Chariot_Param 2]" \
                # "[lindex $list_keys 3] = [lindex $list_Chariot_Param 3]" ]
        foreach item [dict keys $dict_Chariot_Param] {
            set value [dict get $dict_Chariot_Param $item]
            Log "info" $logfile [list "$item = $value"]
        }
    }
    
    return true
}

proc Func_INI::_GetCriteria {inifname} {
    variable list_sections
    variable list_keys
    variable list_values
    variable list_Criteria
    variable dict_Criteria
    variable verbose
    variable logfile
    
    
    set retval [GetSections $inifname]
    if {$retval == false} {
        return false
    }
    
    foreach temp $list_sections {
        switch -regexp $temp {
            {^Criteria} {
                set sec_criteria $temp
            }
        };#switch
    }
    
    set retval [GetKeys $inifname $sec_criteria]
    if {$retval == false} {
        return false
    }
    
    foreach temp $list_keys {
        set retval [GetValue $inifname $sec_criteria $temp]
        lappend list_Criteria $list_values
        
        # store to dict from ini file
        dict set dict_Criteria [string tolower $temp] [lindex $list_values 0]        
    }
    
    if {$verbose == on} {
        # Log "info" $logfile [list "[lindex $list_keys 0] = [lindex $list_Criteria 0]" \
                # "[lindex $list_keys 1] = [lindex $list_Criteria 1]" ]
        foreach item [dict keys $dict_Criteria] {
            set value [dict get $dict_Criteria $item]
            # puts "$item = $value"
            Log "info" $logfile [list "$item = $value"]
        }
    }
    
    return true
}

proc Func_INI::_GetWLAN_ClientModelName {inifname} {
    variable list_sections
    variable list_keys
    variable list_values
    variable list_WLAN_ClientModelName
    variable dict_WLAN_ClientModelName
    variable verbose
    variable logfile
    
    set retval [GetSections $inifname]
    if {$retval == false} {
        return false
    }
    
    foreach temp $list_sections {
        switch -regexp $temp {
            {^WLAN_Client} {
                set sec_wlan_clientmodelname $temp
            }
        };#switch
    }
    
    set retval [GetKeys $inifname $sec_wlan_clientmodelname]
    if {$retval == false} {
        return false
    }
    
    foreach temp $list_keys {
        set retval [GetValue $inifname $sec_wlan_clientmodelname $temp]
        lappend list_WLAN_ClientModelName $list_values
        
        # store to dict from ini file
        dict set dict_WLAN_ClientModelName [string tolower $temp] [lindex $list_values 0]
    }
    
    if {$verbose == on} {
        # Log "info" $logfile [list "[lindex $list_keys 0] = [lindex $list_WLAN_ClientModelName 0]"]
        
        foreach item [dict keys $dict_WLAN_ClientModelName] {
            set value [dict get $dict_WLAN_ClientModelName $item]
            Log "info" $logfile [list "$item = $value"]
        }
    }
    
    return true
}

proc Func_INI::_GetDUT {inifname} {
    variable list_sections
    variable list_keys
    variable list_values
    variable list_DUT
    variable dict_DUT
    variable verbose
    variable logfile
    
    set retval [GetSections $inifname]
    if {$retval == false} {
        return false
    }
    
    foreach temp $list_sections {
        switch -regexp $temp {
            {^DUT} {
                set sec_dut $temp
            }
        };#switch
    }
    
    set retval [GetKeys $inifname $sec_dut]
    if {$retval == false} {
        return false
    }
    
    foreach temp $list_keys {
        set retval [GetValue $inifname $sec_dut $temp]
        lappend list_DUT $list_values
        # store to dict from ini file
        dict set dict_DUT [string tolower $temp] [lindex $list_values 0]
    }
    
    if {$verbose == on} {
        
        # Log "info" $logfile [list "[lindex $list_keys 0] = [lindex $list_DUT 0]" \
                # "[lindex $list_keys 1] = [lindex $list_DUT 1]"  \
                # "[lindex $list_keys 2] = [lindex $list_DUT 2]"]
        
        foreach item [dict keys $dict_DUT] {
            set value [dict get $dict_DUT $item]
            Log "info" $logfile [list "$item = $value"]
        }
        
    }
    
    return true
}
################################################################################
# Procedure : PingTest
# Purpose   : Before connecting, check host if exists.
################################################################################
proc Func_INI::PingTest {host} {
    catch {exec ping.exe $host -n 1} pingmsg
    set result [string first "Reply" $pingmsg]
    
    if { $result == -1} {
        # puts "Ping $host no Reply"; update
        return false
    } else {
        # puts "Ping $host OK"; update
        return true
    }
}
########################################
# tcl script for ping not working
# https://stackoverflow.com/questions/12524919/tcl-script-for-ping-not-working
##########################################
proc Func_INI::Ping_igp {host} {
    variable verbose
    variable logfile
    
    if {[catch {exec ping $host -n 1} result]} { set result 0 }
    
    if { [regexp "0% loss"  $result]} {
        set logstr "$host alive"
        #puts $logstr
        if {$verbose == on} {
            Log "info" $logfile [list $logstr]
        }
        return true
    } else {
        set logstr "$host failed"
        #puts $logstr
        if {$verbose == on} {
            Log "info" $logfile [list $logstr]
        }
        
        return false
    }
}
proc Func_INI::ChkDUTalive {strIPAddr} {
    
    #set retval [PingTest $strIPAddr]
    set retval [Ping_igp $strIPAddr]
    return $retval
}
########################################
# Define a simple custom logproc
##########################################
namespace eval Log {
    package require logger
}

# Define a simple custom logproc
proc Log::log_to_file {lvl logfiletxt} {
    # set logfile "mylog.log"
    set msg "\[[clock format [clock seconds] -format "%H:%M:%S %m%d%Y"]\] \
            [lindex $logfiletxt 1]"
    set f [open [lindex $logfiletxt 0] {WRONLY CREAT APPEND}] ;# instead of "a"
    fconfigure $f -encoding utf-8
    puts $f $msg
    close $f
}
################################################################################
#${log}::logproc level
# ${log}::logproc level command
# ${log}::logproc level argname body
# This command comes in three forms - the third, older one is deprecated
# and may be removed from future versions of the logger package.
# The current set version takes one argument, a command to be executed
# when the level is called. The callback command takes on argument,
# the text to be logged. If called only with a valid level logproc returns
# the name of the command currently registered as callback command.
# logproc specifies which command will perform the actual logging for a given level.
# The logger package ships with default commands for all log levels,
# but with logproc it is possible to replace them with custom code.
# This would let you send your logs over the network, to a database, or anything else.
################################################################################
proc Log::tofile {level strfilename strtext} {
    # Initialize the logger
    set log [logger::init global]
    
    # Install the logproc for all levels
    foreach lvl [logger::levels] {
        interp alias {} log_to_file_$lvl {} Log::log_to_file $lvl
        ${log}::logproc $lvl log_to_file_$lvl
    }
    
    ${log}::$level [list $strfilename $strtext]
    
    return true
}

proc Log::parray {a {pattern *}} {
    upvar 1 $a array
    if ![array exists array] {
        error "\"$a\" isn't an array"
    }
    set maxl 0
    foreach name [lsort [array names array $pattern]] {
        if {[string length $name] > $maxl} {
            set maxl [string length $name]
        }
    }
    set maxl [expr {$maxl + [string length $a] + 2}]
    foreach name [lsort [array names array $pattern]] {
        set nameString [format %s(%s) $a $name]
        puts stdout [format "%-*s = %s" $maxl $nameString $array($name)]
    }
}
proc Log::LogList_level {level filename list_msg} {
    set path_logfile [file join ".." "log" $filename]
    
    foreach temp $list_msg {
        set strmsg "$temp"
        Log::tofile $level $path_logfile $strmsg
    }
}
proc Log::LogOut {str_out logfname} {
    
    set path_logfile [file join ".." "log" $logfname]
    # set clk [clock format [clock seconds] -format "%b%d%H%M%S%Y"]
    # append str_out;# "  ";append Str_Out $clk
    
    set rnewinfd [open $path_logfile a]
    puts $rnewinfd $str_out
    flush $rnewinfd;close $rnewinfd
}