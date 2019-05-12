# ChangeLog
# By Philip Shen 
# ---------------------------------------------------------------------
# Apr28219 Initialize
################################################################################
namespace eval Func_Chariot {
    # Load the Chariot API.
    #
    # NOTE:  If you are using Tcl Version 8.0.p5 or older
    # then you will need to modify the following lines to load and
    # use Chariot instead of ChariotExt.  For example:
    # load Chariot
    # package require Chariot
    #load ChariotExt
    package require ChariotExt
    ################################################################################
    # refer chariotext.tcl
    ################################################################################
    global auto_index
    eval $auto_index(ChariotExt)
    ################################################################################
    # to calculate allpairs max/min result
    ################################################################################
    package require math::statistics
    
    # Define symbols for the errors we're interested in.
    variable CHR_OPERATION_FAILED "CHRAPI 108"
    variable CHR_OBJECT_INVALID   "CHRAPI 112"
    variable CHR_APP_GROUP_INVALID "CHRAPI 136"
    
    variable verbose off
    variable logfile "../log/chariot.log"
    variable test    {}
    variable testFile    {}
    variable errmsg    {}
    variable pairCount    {}
    variable e1Addrs    {}
    variable e2Addrs    {}
    variable protocols    {}
    variable chrscript    {}
    variable runOpts    {}
    variable test_duration    {}
    variable reTest    {}
    variable pair    {}
    variable chr_done    {}
    variable chr_how_ended    {}
    variable allpairs_avg    {}
    variable allpairs_min    {}
    variable allpairs_max    {}
    variable list_pair_avg    {}
    variable list_pair_min    {}
    variable list_pair_max    {}
    variable path_thruput_csvfile    {}
}

proc Func_Chariot::Initialize {} {
    variable verbose
    variable logfile 
    variable test
    
    # Create a new test.
    set strmsg "Create the test..."
    puts $strmsg
    insertLogLine info $strmsg
    update
    
    set test [chrTest new]
    #puts "chrTest_new_test: $test"
    
    if {$verbose == on} {
        Func_INI::Log "info" $logfile [list "$test chrTest new"]
    };#if {$verbose == on}
    
    
}
proc Func_Chariot::GetErrmsg {errcode} {
    variable errmsg
    
    switch -regexp [string tolower $errcode]  {
        {108} {
            set errmsg [string tolower "CHR_OPERATION_FAILED"]
        }
        {112} {
            set errmsg [string tolower "CHR_OBJECT_INVALID"]
        }
        {136} {
            set errmsg [string tolower "CHR_APP_GROUP_INVALID"]
        }
    };#switch
    
}
proc Func_Chariot::Test_Filename {} {
    variable verbose
    variable logfile
    variable test
    variable testFile
    variable errmsg
    
    # Set the test filename for saving later.
    set strmsg "Set test filename: $testFile..."
    puts $strmsg
    insertLogLine info $strmsg
    update
    
    if {$verbose == on} {
        Func_INI::Log "info" $logfile [list "$test chrTest $testFile"]
    };#if {$verbose == on}
    
    if {[catch {chrTest set $test FILENAME $testFile}]} {
        # pLogError $test $errorCode "chrTest set FILENAME"
        GetErrmsg $errorCode
        Func_INI::Log "info" $logfile [list $test $errmsg "chrTest set FILENAME"]            
        
        return
    }
    
}

proc Func_Chariot::SetChrPair {} {
    variable verbose
    variable logfile
    variable test
    variable pairCount
    variable e1Addrs
    variable e2Addrs
    variable protocols
    variable errmsg
    variable chrscript
    variable pair
    
    if {$verbose == on} {
        Func_INI::Log "info" $logfile [list "$test PairCount:$pairCount"]
    };#if {$verbose == on}
    
    for {set index 0} {$index < $pairCount} {incr index} {
        # Create a pair.
        set strmsg "Create pair [expr $index + 1]..."
        puts $strmsg
        insertLogLine info $strmsg
        update
        
        set pair [chrPair new]
        if {$verbose == on} {
            Func_INI::Log "info" $logfile [list "$pair chrPair new"]
        };#if {$verbose == on}
        
        # Set pair attributes from our lists.
        set strmsg "Set pair atttributes..."
        puts $strmsg
        insertLogLine info $strmsg
        update
        
        chrPair set $pair COMMENT "Pair [expr $index + 1]"
        chrPair set $pair E1_ADDR $e1Addrs
        chrPair set $pair E2_ADDR $e2Addrs
        chrPair set $pair PROTOCOL $protocols
        
        if {$verbose == on} {
            Func_INI::Log "info" $logfile [list  "$test $pair {Pair [expr $index + 1]} $e1Addrs $e2Addrs $protocols"]
            Func_INI::Log "info" $logfile [list  "$test $pair $chrscript"]
            
        };#if {$verbose == on}
        
        # Define a script for use by this pair.
        # We need to check for errors with extended info here.
        
        if {[catch {chrPair useScript $pair $chrscript}]} {            
            # pLogError $pair $errorCode "chrPair useScript"
            #GetErrmsg $errorCode
            Func_INI::Log "info" $logfile [list  "$test $pair $chrscript chrPair useScript"]
                        
            return
        }
        
        
        
        # Add the pair to the test.
        set strmsg "Add the pair to the test..."
        puts $strmsg
        insertLogLine info $strmsg
        update
        
        if {[catch {chrTest addPair $test $pair}]} {
            # pLogError $test $errorCode "chrTest addPair"
            GetErrmsg $errorCode
            Func_INI::Log "info" $logfile [list $test $errmsg "chrTest addPair"]
            
            return
        }
        
        if {$verbose == on} {
            Func_INI::Log "info" $logfile [list $test "chrPair useScript"]
            Func_INI::Log "info" $logfile [list $test "chrTest addPair"]
        };#if {$verbose == on}
                
    };#for {set index 0}
    
}

proc Func_Chariot::SetChrPair_reverse {} {
    variable verbose
    variable logfile
    variable test
    variable pairCount
    variable e1Addrs
    variable e2Addrs
    variable protocols
    variable errmsg
    variable chrscript
    variable pair
    
    for {set index 0} {$index < $pairCount} {incr index} {
        # Create a pair.
        set strmsg "Create a pair..."
        puts $strmsg
        insertLogLine info $strmsg
        
        set pair [chrPair new]
        
        # Set pair attributes from our lists.
        set strmsg "Set pair atttributes..."
        puts $strmsg
        insertLogLine info $strmsg
        update
        
        chrPair set $pair COMMENT "Pair_Reverse [expr $index + 1]"
        chrPair set $pair E1_ADDR $e2Addrs
        chrPair set $pair E2_ADDR $e1Addrs
        chrPair set $pair PROTOCOL $protocols
        
        # Define a script for use by this pair.
        # We need to check for errors with extended info here.
        
        if {[catch {chrPair useScript $pair $chrscript}]} {
            # pLogError $pair $errorCode "chrPair useScript"
            if {$verbose == on} {
                GetErrmsg $errorCode
                Func_INI::Log "info" $logfile [list $test $errmsg "chrPair useScript"]
            };#if {$verbose == on}
            
            return
        }
        
        # Add the pair to the test.
        set strmsg "Add the pair to the test..."
        puts $strmsg
        insertLogLine info $strmsg
        update
        
        if {[catch {chrTest addPair $test $pair}]} {
            # pLogError $test $errorCode "chrTest addPair"
            if {$verbose == on} {
                GetErrmsg $errorCode
                Func_INI::Log "info" $logfile [list $test $errmsg "chrTest addPair"]
            };#if {$verbose == on}
                        
            return
        }
        
    };#for {set index 0}
    
}

proc Func_Chariot::SetRunOpts {} {
    variable verbose
    variable logfile
    variable test
    variable runOpts
    variable test_duration
    
    set runOpts [chrTest getRunOpts $test]
    if {$verbose == on} {
        Func_INI::Log "info" $logfile [list  "$test,$runOpts "]
    };#if {$verbose == on}
    
    set strmsg "Set test duration..."
    puts $strmsg
    insertLogLine info $strmsg
    update
    
    if {[catch {chrRunOpts set $runOpts TEST_END FIXED_DURATION}]} {
        GetErrmsg $errorCode
        Func_INI::Log "info" $logfile [list $test $errmsg "chrTest Test_End Fixed_Duration"]
        
        return
    }    
    
    if {$verbose == on} {
        Func_INI::Log "info" $logfile [list "$test,$runOpts chrTest Test_End Fixed_Duration"]
    };#if {$verbose == on}
    
    if {[ catch {chrRunOpts set $runOpts TEST_DURATION $test_duration}]} {
        GetErrmsg $errorCode
        Func_INI::Log "info" $logfile [list $test $errmsg "chrTest Test_Duration"]
        
        return
    }

    if {$verbose == on} {
        Func_INI::Log "info" $logfile [list "$test,$runOpts chrTest Test_Duration"]
    };#if {$verbose == on}
    
}
proc Func_Chariot::RunTest_tillEnd {} {
    variable verbose
    variable logfile
    variable test
    variable pair
    variable chr_done
    variable test_duration
    
    # The test is complete, so now we can run it.
    set strmsg "Run the test Test_Duration: $test_duration sec(s)..."
    puts $strmsg
    insertLogLine info $strmsg
    update
    
    if {[catch {chrTest start $test}]} {
        # pLogError $test $errorCode "chrTest start"
        # GetErrmsg $errorCode
        Func_INI::Log "info" $logfile [list "$test chrTest start"]
                
        return
    }
    
    if {$verbose == on} {
        Func_INI::Log "info" $logfile [list  "$test chrTest start"]
    };#if {$verbose == on}
    
    set chr_done [chrTest isStopped $test]
    
    while { !$chr_done } {
        # wait 5 second
        set chr_done [chrTest isStopped $test 5]
    }
    
    if {$verbose == on} {
        Func_INI::Log "info" $logfile [list  "$test chrTest isStopped"]
    };#if {$verbose == on}
}
################################################################################
# http://www.voidcn.com/article/p-qozsbtna-bda.html
# 
# for { set i 0 } { $i < [llength $files] } { incr i } {
#set long [llength $files]
#puts "files $long"
#puts "work_dir_length $work_dir_length "
# set tt [chrTest new]
# set f [lindex $files $i]
# set record_time [string range $f $work_dir_length [string length $f]]
# set record_time [string range $record_time 0 38]
# set script [string range $record_time 40 $work_dir_length]
# puts -nonewline "$record_time, "
# chrTest load $tt $f
# chrTest getPairCount $tt
# chrTest getPair $tt 0
# set p1 [chrTest getPair $tt 0]
#puts "Number of timing records = [chrPair getTimingRecordCount $p1]"
# 提取MLR和DF文件
# 根据不同的??需求，也可以?取吞吐量，?延，抖?，?包率等指?
#set mlr [chrPairResults get $p1 MEDIA_LOSS_RATE ]
#set df [chrPairResults get $p1 DELAY_FACTOR]
# set th [chrPairResults get $p1 THROUGHPUT ]
# puts "mlr, [lindex $mlr 0], [lindex $mlr 1], [lindex $mlr 2],\
# df, [lindex $df 0], [lindex $df 1], [lindex $df 2]"
# set avg [format "%.3f" [lindex $th 0]]
#set min [format "%.3f" [lindex $th 1]]
#set max [format "%.3f" [lindex $th 2]]
#puts "$avg,$min,$max "
###################################
#chrTest getPair $tt 0
# set p2 [chrTest getPair $tt 1]
# set th2 [chrPairResults get $p2 THROUGHPUT ]
# set avg1 [format "%.3f" [lindex $th2 0]]
##################################
# set p2 [chrTest getPair $tt 2]
# set th2 [chrPairResults get $p2 THROUGHPUT ]
# set avg2 [format "%.3f" [lindex $th2 0]]
##################################################
# set p2 [chrTest getPair $tt 3]
# set th2 [chrPairResults get $p2 THROUGHPUT ]
# set avg3 [format "%.3f" [lindex $th2 0]]
##################################################
# puts "$avg,$avg1,$avg2,$avg3"
##################################################
# chrTest delete $tt force
# 
# }
################################################################################

proc Func_Chariot::GetPairResult {} {
    variable verbose
    variable logfile
    variable test
    variable pairCount
    variable pair
    variable allpairs_avg
    variable allpairs_min
    variable allpairs_max
    variable list_pair_avg
    variable list_pair_min
    variable list_pair_max
    variable chr_how_ended
    
    # Save the test so we can show results later.
    #puts "Get the test result..."
    update
    set chr_how_ended [chrTest get $test HOW_ENDED]
    
    if {$verbose == on} {
        Func_INI::Log "info" $logfile [list "$test $chr_how_ended chrTest save"]
    };#if {$verbose == on}
    
    if {$chr_how_ended == "NORMAL"} {
        # prevent lats list to append
        if [info exist list_pair_avg] {unset list_pair_avg}
        if [info exist list_pair_min] {unset list_pair_min}
        if [info exist list_pair_max] {unset list_pair_max}
        
        # get each pair data
        for {set index 0} {$index < $pairCount} {incr index} {
            # get the each pair token
            set pair [chrTest getPair $test $index]
            
            set throughput [list 0 0 0]
            catch {set throughput [chrPairResults get $pair THROUGHPUT]}
            
            set pair_avg [format "%.4f" [lindex $throughput 0]]
            set pair_min [format "%.4f" [lindex $throughput 1]]
            set pair_max [format "%.4f" [lindex $throughput 2]]
            
            # Save the test so we can show results later.
            set strmsg "Get the test result..."
            puts $strmsg
            insertLogLine info $strmsg
            update
            
            if {$verbose == on} {
                Func_INI::Log "info" $logfile [list "$test $chr_how_ended chrPairResults get $pair THROUGHPUT"]
                Func_INI::Log "info" $logfile [list "pair[expr $index + 1]_avg: $pair_avg" \
                                                "pair[expr $index + 1]_min: $pair_min" \
                                                "pair[expr $index + 1]_max: $pair_max"]
            };#if {$verbose == on}
            
            # collect each pair thruput
            lappend list_pair_avg $pair_avg
            lappend list_pair_min $pair_min
            lappend list_pair_max $pair_max
        
        };#for {set index 0}
        
        ################################################################################
        # What is the most elegant way to find the sum of all numbers in a string in TCL?
        # https://stackoverflow.com/questions/34240206/what-is-the-most-elegant-way-to-find-the-sum-of-all-numbers-in-a-string-in-tcl?rq=1
        #
        # set sum [tcl::mathop::+ {*}[regexp -all -inline {-?\d+(?:\.\d+)(?:e[-+]?\d+)} $theString]]
        #
        # set sum [tcl::mathop::+ {*}[lmap tuple $theList {lindex $tuple 1}]]
        # Requires Tcl 8.6
        ################################################################################
                
        set allpairs_avg [tcl::mathop::+ {*}$list_pair_avg]
        #set allpairs_min [tcl::mathop::+ {*}$list_pair_min]
        #set allpairs_max [tcl::mathop::+ {*}$list_pair_max]
        set allpairs_min [math::statistics::mean $list_pair_min]
        set allpairs_max [math::statistics::mean $list_pair_max]
        
        set allpairs_avg [format "%.3f" $allpairs_avg]
        set allpairs_min [format "%.3f" $allpairs_min]
        set allpairs_max [format "%.3f" $allpairs_max]
        
        if {$verbose == on} {
            Func_INI::Log "info" $logfile [list "allpairs_avg: $allpairs_avg" "allpairs_min: $pair_min" "allpairs_max: $allpairs_max"]
        };#if {$verbose == on}
        
    } else  {
        
        set tp_avg 0
    };#if {$how_ended == "NORMAL"}
}

proc Func_Chariot::SaveResult {} {
    variable verbose
    variable logfile
    variable test
    
    # Save the test so we can show results later.
    set strmsg "Save the test..."
    puts $strmsg
    insertLogLine info $strmsg
    update
    
    if {[catch {chrTest save $test}]} {
        # pLogError $test $errorCode "chrTest save"
        # GetErrmsg $errorCode
        Func_INI::Log "info" $logfile [list "$test chrTest save"]
    }
    
    if {$verbose == on} {
        Func_INI::Log "info" $logfile [list "$test chrTest save"]
    };#if {$verbose == on}

}

# Refer ChrLBSimple.tcl
# (13)
# Clean up used resources before exiting.
# (Test will deallocate associated pairs automatically)
proc Func_Chariot::Terminate {} {
    variable verbose
    variable logfile
    variable test
    
    # Terminate a new test.
    set strmsg "Terminate the test..."
    puts $strmsg
    insertLogLine critical $strmsg
    update
    
    set test [chrTest delete $test force]
}

proc Func_Chariot::LogResult2CSV {} {
    variable verbose
    variable logfile
    variable path_thruput_csvfile
    
    if [info exist str_out] {unset str_out}
    append str_out $Func_Chariot::allpairs_avg "," \
            $Func_Chariot::allpairs_max "," \
            $Func_Chariot::allpairs_min "," \
            $Func_Chariot::testFile
    
    # Log thruput result to CSV file.
    set strmsg "Log Avg/Max/Min Thruput to thruput.csv..."
    puts $strmsg
    insertLogLine info $strmsg    
    update
    
    Log::LogOut $str_out $path_thruput_csvfile
    
}

proc Func_Chariot::RunRoutine {} {
    variable verbose
    variable logfile
    variable test
    
    # Create a new test.
    Func_Chariot::Initialize
    
    # Set the test filename for saving later.
    Func_Chariot::Test_Filename
    
    # Set test_duration
    Func_Chariot::SetRunOpts
    
    # Define some pairs for the test.
    Func_Chariot::SetChrPair
    
    # Excute test.
    Func_Chariot::RunTest_tillEnd
    
    # Get the test result.
    Func_Chariot::GetPairResult
    
    # Save the test so we can show results later.
    Func_Chariot::SaveResult
    
    # Log thruput result to CSV file.
    Func_Chariot::LogResult2CSV
    
    # Clean up used resources before exiting.
    Func_Chariot::Terminate
}
################################################################################
# For GUI Widget purpose
################################################################################

proc Func_Chariot::RunRoutine_11ac_lan2wlan {} {
    variable verbose
    variable logfile
    variable test
    variable chrscript
    variable maxretry
    variable path_thruput_csvfile
    
    # Read variables from INI file
    set inifile [file join $Func_INI::currPath setup.ini]
    Func_INI::_GetChariot_Param $inifile
    Func_INI::_GetDUT $inifile
    Func_INI::_GetTopologyIP $inifile
    Func_INI::_GetWLAN_ClientModelName $inifile
    Func_INI::_GetCriteria $inifile
    
    set Func_Chariot::reTest [dict get $Func_INI::dict_Chariot_Param "retest"]
    
    # Set chariot related parameters for testing
    set maxretry $Func_Chariot::reTest
    
    # Check Topology Status
    set retval [Func_INI::ChkTopologyalive]
    if {$retval == "false"} {
        set strmsg "********** Please Double Check Topology Status! **********"
        
        insertLogLine critical $strmsg
        return
    } else  {
        set strmsg "********** Start 11AC LAN2WLAN chariot Thruput Test! **********"
        
        insertLogLine notice $strmsg
        update
    };#if {$retval == "false"}
    
    for {set retry 0} {$retry < $maxretry} {incr retry} {
        
        # LAN-->WLAN
        ################################################################################
        
        # Set test duration
        set Func_Chariot::test_duration [dict get $Func_INI::dict_Chariot_Param "test_duration"]
        
        # Set chariot related parameters
        #################################################################################
        set Func_Chariot::pairCount [dict get $Func_INI::dict_Chariot_Param "paircount"]
        set Func_Chariot::e1Addrs [dict get $Func_INI::dict_TopologyIP  "lan_ep_ipaddr"]
        set Func_Chariot::e2Addrs [dict get $Func_INI::dict_TopologyIP  "wlan_ep_ipaddr"]
        set Func_Chariot::protocols [dict get $Func_INI::dict_Chariot_Param "protocols"]
        
        # Prevent duplicate string
        #if [info exist Func_INI::testChrfile_11ac_lan2wlan] {unset Func_INI::testChrfile_11ac_lan2wlan}
         
        # Setup Chariot test file name
        Func_INI::GenChariotTestFile_11ac_lan2wlan
        # Set absoluate path
        if [info exist testChrfile_11ac_lan2wlan] {unset testChrfile_11ac_lan2wlan}
        append testChrfile_11ac_lan2wlan $Func_INI::log_Path / $Func_INI::testChrfile_11ac_lan2wlan
        
        set Func_Chariot::testFile $testChrfile_11ac_lan2wlan
        
        # Set test duration
        set Func_Chariot::test_duration [dict get $Func_INI::dict_Chariot_Param "test_duration"]
        
        # Set absoluate path
        if [info exist Func_Chariot::chrscript] {unset Func_Chariot::chrscript}
        append Func_Chariot::chrscript $Func_INI::lib_Path / [dict get $Func_INI::dict_Chariot_Param "scripts"]
        
        # Log thruput value to CSV file
        if [info exist Func_Chariot::path_thruput_csvfile] {unset Func_Chariot::path_thruput_csvfile}
        append Func_Chariot::path_thruput_csvfile $Func_INI::log_Path / "thruput.csv"
        
        # Create a new test.
        # Set the test filename for saving later.
        # Set test_duration
        # Define some pairs for the test.
        # Excute test.
        # Get the test result.
        # Save the test so we can show results later.
        # Clean up used resources before exiting.
        Func_Chariot::RunRoutine
    
    };#for {set retry 0} {$retry < $maxretry} {incr retry}
    
}

proc Func_Chariot::RunRoutine_11ac_wlan2lan {} {
    variable verbose
    variable logfile
    variable test
    variable chrscript
    variable maxretry
    variable path_thruput_csvfile
    
    # Read variables from INI file
    set inifile [file join $Func_INI::currPath setup.ini]
    Func_INI::_GetChariot_Param $inifile
    Func_INI::_GetDUT $inifile
    Func_INI::_GetTopologyIP $inifile
    Func_INI::_GetWLAN_ClientModelName $inifile
    Func_INI::_GetCriteria $inifile
    
    set Func_Chariot::reTest [dict get $Func_INI::dict_Chariot_Param "retest"]
    
    # Set chariot related parameters for testing
    set maxretry $Func_Chariot::reTest
    
    # Check Topology Status
    set retval [Func_INI::ChkTopologyalive]
    if {$retval == "false"} {
        set strmsg "********** Please Double Check Topology Status! **********"
        
        insertLogLine critical $strmsg
        return
    } else  {
        set strmsg "********** Start 11AC WLAN2LAN chariot Thruput Test! **********"
        
        insertLogLine notice $strmsg
        update
    };#if {$retval == "false"}
    
    for {set retry 0} {$retry < $maxretry} {incr retry} {
        # WLAN-->LAN
        ################################################################################
        
        # Set test duration
        set Func_Chariot::test_duration [dict get $Func_INI::dict_Chariot_Param "test_duration"]
        
        # Set chariot related parameters
        #################################################################################
        set Func_Chariot::pairCount [dict get $Func_INI::dict_Chariot_Param "paircount"]
        set Func_Chariot::e1Addrs [dict get $Func_INI::dict_TopologyIP  "wlan_ep_ipaddr"]
        set Func_Chariot::e2Addrs [dict get $Func_INI::dict_TopologyIP  "lan_ep_ipaddr"]
        set Func_Chariot::protocols [dict get $Func_INI::dict_Chariot_Param "protocols"]
        
        # Creat Chariot test file name
        Func_INI::GenChariotTestFile_11ac_wlan2lan
        
        # Set absoluate path
        if [info exist testChrfile_11ac_wlan2lan] {unset testChrfile_11ac_wlan2lan}
        append testChrfile_11ac_wlan2lan $Func_INI::log_Path / $Func_INI::testChrfile_11ac_wlan2lan
                
        set Func_Chariot::testFile $testChrfile_11ac_wlan2lan               
        
        # Set absoluate path
        if [info exist Func_Chariot::chrscript] {unset Func_Chariot::chrscript}
        append Func_Chariot::chrscript $Func_INI::lib_Path / [dict get $Func_INI::dict_Chariot_Param "scripts"]
        
        # Log thruput value to CSV file
        if [info exist Func_Chariot::path_thruput_csvfile] {unset Func_Chariot::path_thruput_csvfile}
        append Func_Chariot::path_thruput_csvfile $Func_INI::log_Path / "thruput.csv"
        
        # Create a new test.
        # Set the test filename for saving later.
        # Set test_duration
        # Define some pairs for the test.
        # Excute test.
        # Get the test result.
        # Save the test so we can show results later.
        # Clean up used resources before exiting.
        Func_Chariot::RunRoutine
        
    
    };#for {set retry 0} {$retry < $maxretry} {incr retry}
}
