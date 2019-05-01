################################################################################
# Ttk MessageBox
# wrapper of ttk::dialog for using it like tk_messageBox
################################################################################
namespace eval Message {} {;#<<<
    variable retval {}
}

proc Message::msgset {btn} {
    variable retval $btn
}

# return selected button name
proc Message::show {args} {
    variable retval
    if [winfo exists .ttkmessage] {
        destroy .ttkmessage
    }
    eval ttk::dialog .ttkmessage $args -command {Message::msgset}
    wm withdraw .ttkmessage
    lower .ttkmessage .
    update
    if {[tk windowingsystem] eq "x11"} {
        ::Util::moveCenter .ttkmessage
    } else {
        ::Util::moveCenter .ttkmessage \
                [list [winfo reqwidth .ttkmessage] [winfo reqheight .ttkmessage]]
    }
    
    Util::ngrab set .ttkmessage
    wm transient .ttkmessage .
    wm deiconify .ttkmessage
    focus -force .ttkmessage
    tkwait window .ttkmessage
    Util::ngrab release
    return $retval
}
################################################################################
# -icon
# Specifies an icon to display. Must be one of the following: error, info, question or warning.
#
# -type
# Specifies a set of buttons to be displayed. The following values are possible:
# abortretryignore
# Displays three buttons whose symbolic names are abort, retry and ignore.
# ok
#     Displays one button whose symbolic name is ok.
# okcancel
#             Displays two buttons whose symbolic names are ok and cancel.
# retrycancel
#              Displays two buttons whose symbolic names are retry and cancel.
# yesno
#      Displays two buttons whose symbolic names are yes and no.
# yesnocancel
#             Displays three buttons whose symbolic names are yes, no and cancel.
# user
#     Displays buttons of -buttons option.
################################################################################
proc Message::popup {list_args} {
    set icon_opt    [lindex $list_args 0]
    set appname    [lindex $list_args 1]
    set version    [lindex $list_args 2]
    set strmsg    [lindex $list_args 3]
    set strdetail    [lindex $list_args 4]
    
    show -buttons ok -icon $icon_opt -title "$appname  Version:$version\n" \
            -message $strmsg -detail $strdetail -type okcancel
}
proc Message::popup_buttopt {list_args } {
    set icon_opt    [lindex $list_args 0]
    set appname    [lindex $list_args 1]
    set version    [lindex $list_args 2]
    set strmsg    [lindex $list_args 3]
    set strdetail    [lindex $list_args 4]
    set str_buttopt   [lindex $list_args 5]
    #abortretryignore; ok; okcancel;retrycancel;yesno;yesnocancel;
    set retval [show -buttons $str_buttopt -icon $icon_opt -title "$appname  Version:$version\n" \
            -message $strmsg -detail $strdetail -type yesnocancel -default yes]
    
    return $retval
}
namespace eval Util {
    variable grabStack [list]
}
proc Util::moveCenter {widget {size {}}} {
    set sw [winfo vrootwidth $widget]
    set sh [winfo vrootheight $widget]
    if {[llength $size] == 0} {
        update idletask
        set w [winfo width $widget]
        set h [winfo height $widget]
    } else {
        set w [lindex $size 0]
        set h [lindex $size 1]
    }
    wm geometry $widget +[expr {($sw-$w)/2}]+[expr {($sh-$h)/2}]
}
# Nested grab command
# ngrab set .w   : stack window and grab it.
# ngrab release  : release a top of stack window.
proc Util::ngrab {command {w {}}} {
    variable grabStack
    switch -exact -- $command {
        set {
            if {$w eq {}} { error "wrong args : ngrab command window" }
            grab set $w
            focus -force $w
            lappend grabStack $w
        }
        release {
            set cur [lindex $grabStack end]
            set grabStack [lrange $grabStack 0 "end-1"]
            if {[llength $grabStack] == 0} {
                grab release $cur
                return
            }
            grab set [lindex $grabStack end]
        }
    }
}
namespace eval Statusbar {;#<<<
    variable var
    array set var {
        encoding {}
        version {}
        time {}
        row {}
    }
}
proc Statusbar::Statusbar {} {
    ttk::frame .statusbar
    ttk::label .statusbar.enc -textvariable [namespace current]::var(encoding)
    ttk::label .statusbar.ver -textvariable [namespace current]::var(version)
    ttk::label .statusbar.time -textvariable [namespace current]::var(time)
    ttk::label .statusbar.row -textvariable [namespace current]::var(row)
    ttk::label .statusbar.dummy
    foreach w [winfo children .statusbar] {
        $w configure -takefocus 0 -relief flat -anchor w -padding 0
    }
    foreach n {0 1 2 3} {
        ttk::separator .statusbar.sep$n -orient vertical
    }
    pack .statusbar.ver .statusbar.sep0 .statusbar.enc .statusbar.sep1 \
            -fill y -side left -pady 2 -padx 1
    
    pack .statusbar.time .statusbar.sep2 .statusbar.row .statusbar.sep3 \
            -fill y -side right -pady 2 -padx 1
    
    return .statusbar
}

proc Statusbar::clear {} {
    variable var
    set var(encoding) "Encoding : unknown"
    set var(version) "Version : unknown"
    set var(time) "Time : 0 msec"
    set var(row) "Rows : 0 lines"
}

proc Statusbar::update {} {
    variable var
    set var(encoding) "Encoding : A"
    set var(version) "Version : B"
    set var(time) "Time : C"
    set var(row) "Rows : D"
}
