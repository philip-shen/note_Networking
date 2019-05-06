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
    
    # Define symbols for the errors we're interested in.
    variable CHR_OPERATION_FAILED "CHRAPI 108"
    variable CHR_OBJECT_INVALID   "CHRAPI 112"
    variable CHR_APP_GROUP_INVALID "CHRAPI 136"
    
    variable verbose off
    variable logfile "../log/chariot.log"
    variable test    {}
    variable testFile    {}
    variable errmsg    {}
    variable e1Addrs    {}
    variable e2Addrs    {}
    variable protocols    {}
    variable chrscript    {}
    variable runOpts    {}
    variable test_duration    {}
    variable pair    {}
    variable chr_done    {}
    variable chr_how_ended    {}
    variable allpairs_avg    {}
    variable allpairs_min    {}
    variable allpairs_max    {}
    variable list_pair_avg    {}
    variable list_pair_min    {}
    variable list_pair_max    {}
    
}

proc Func_Chariot::Initialize {} {
    variable verbose
    variable logfile 
    variable test
    
    # Create a new test.
    puts "Create the test..."
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
    puts "Set test filename..."
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
        puts "Create pair [expr $index + 1]..."
        update
        set pair [chrPair new]
        if {$verbose == on} {
            Func_INI::Log "info" $logfile [list "$pair chrPair new"]
        };#if {$verbose == on}
        
        # Set pair attributes from our lists.
        puts "Set pair atttributes..."
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
        puts "Add the pair to the test..."
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
        puts "Create a pair..."
        set pair [chrPair new]
        
        # Set pair attributes from our lists.
        puts "Set pair atttributes..."
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
        puts "Add the pair to the test..."
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
    
    puts "Set test duration..."
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
    
    # The test is complete, so now we can run it.
    puts "Run the test..."
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
    puts "Get the test result..."
    update
    set chr_how_ended [chrTest get $test HOW_ENDED]
    
    if {$verbose == on} {
        Func_INI::Log "info" $logfile [list "$test $chr_how_ended chrTest save"]
    };#if {$verbose == on}
    
    if {$chr_how_ended == "NORMAL"} {
        # prevent lats list to append
        #if [info exist list_pair_avg] {unset list_pair_avg}
        #if [info exist list_pair_min] {unset list_pair_min}
        #if [info exist list_pair_max] {unset list_pair_max}
        
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
            puts "Get the test result..."
            update
            if {$verbose == on} {
                Func_INI::Log "info" $logfile [list "$test $chr_how_ended chrPairResults get $pair THROUGHPUT"]
                Func_INI::Log "info" $logfile [list "pair[expr $index + 1]_avg: $pair_avg" "pair[expr $index + 1]_min: $pair[expr $index + 1]_min" "pair_max: $pair_max"]
            };#if {$verbose == on}
            
            # collect each pair thruput
            lappend list_pair_avg $pair_avg
            lappend list_pair_min $list_pair_min
            lappend list_pair_max $list_pair_max
        
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
        set allpairs_min [tcl::mathop::+ {*}$list_pair_min]
        set allpairs_max [tcl::mathop::+ {*}$list_pair_max]
        
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
    puts "Save the test..."
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
    puts "Terminate the test..."
    set test [chrTest delete $test force]
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
    
    # Clean up used resources before exiting.
    Func_Chariot::Terminate
}