# ChangeLog
# By Philip Shen @DQA Cameo
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
    load ChariotExt
    package require ChariotExt
    
    # Define symbols for the errors we're interested in.
    variable CHR_OPERATION_FAILED "CHRAPI 108"
    variable CHR_OBJECT_INVALID   "CHRAPI 112"
    variable CHR_APP_GROUP_INVALID "CHRAPI 136"
    
    variable verbose off
    variable logfile "../log/chariot.log"
    variable test    {}
    variable testFile    {}
}

proc Func_Chariot::Initialize {} {
    variable verbose 
    variable logfile 
    variable test
    
    # Create a new test.
    puts "Create the test..."
    set test [chrTest new]
}
proc Func_Chariot::Test_Filename {} {
    variable verbose
    variable logfile
    variable test
    variable testFile
    
    # Set the test filename for saving later.
    puts "Set test filename..."
    if {[catch {chrTest set $test FILENAME $testFile}]} {
        # pLogError $test $errorCode "chrTest set FILENAME"
        
        if {$verbose == on} {
            Func_INI::Log "info" $logfile [list $test $errorCode "chrTest set FILENAME"]            
        };#if {$verbose == on}
        
        return
    }
}