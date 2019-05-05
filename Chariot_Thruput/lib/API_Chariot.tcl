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
    variable tp_avg    {}
    variable min    {}
    variable max    {}
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
        puts "Create a pair..."
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

proc Func_Chariot::GetPairResult {} {
    variable verbose
    variable logfile
    variable test
    variable tp_avg
    variable min
    variable max
    variable chr_how_ended
    
    # Save the test so we can show results later.
    puts "Get the test result..."
    update
    set chr_how_ended [chrTest get $test HOW_ENDED]
    
    if {$verbose == on} {
        Func_INI::Log "info" $logfile [list "$test $chr_how_ended chrTest save"]
    };#if {$verbose == on}
    
    if {$chr_how_ended == "NORMAL"} {
        set throughput [list 0 0 0]
        catch {set throughput [chrPairResults get $pair THROUGHPUT]}
        
        set tp_avg [format "%.3f" [lindex $throughput 0]]
        set min [format "%.3f" [lindex $throughput 1]]
        set max [format "%.3f" [lindex $throughput 2]]
        
        # Save the test so we can show results later.
        puts "Get the test result..."
        update
        if {$verbose == on} {
            Func_INI::Log "info" $logfile [list "tp_avg: $tp_avg" "min: $min" "max: $max"]
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