#! /bin/env tclsh

set lib_dir [glob ../../../timing_libs/*.lib]

foreach line $lib_dir {
	
	set filename [file tail $line ]
	set name1 [lindex [split [file rootname $filename] hd] 3]
	
	set ext [file extension $filename]
	#set a [file rootname [file tail $line]] 
	#set c [lindex [split $name hd] 3]
	set map1 [string map {"__" ""} $name1]
	set map2  [string map {"_" ""} $map1]
	
	set new_name "$map2"
	set name2 [string map {".lib" "_Post_synthesis_minmax"} $ext]

	read_liberty $line
	
	read_verilog rvmyth.synthesis.v
	link_design rvmyth
	read_sdc -echo rvmyth.sdc
	mkdir -p Post_synthesis

	report_checks -path_delay min_max -fields {nets cap slew input_pins} -format full_clock_expanded -digits {4} > Post_synthesis/$new_name$name2.rpt

}

set new [glob Post_synthesis/*.rpt]

foreach report $new {
	set rd_report [open $report r]
	set filename [file rootname [file tail $report] ]
        puts "$filename"
	set pattern {slack}
        while {[gets $rd_report line] != -1 } {
		if {[regexp $pattern $line match]} {
		#set filename  [file tail $report]
		#set slack [string map {"            " ""}  $line]
		set slack [lindex $line 0]
          	#puts "Hold/Setup $pattern value for $filename is $slack"
		puts "$slack"
		}
	}
close $rd_report
}
	              		
foreach report $new {
        set rd_report [open $report r]
	set filename [file rootname [file tail $report] ]
        puts "$filename"
        set pattern {Startpoint:}
    	while {[gets $rd_report line] >= 0 } {
		if {[regexp $pattern $line]} {
                set filename  [file tail $report]
                set startpoint [lindex $line 1]
                puts "$pattern value for $filename is $startpoint"
	        #puts "$startpoint"
                } 
         }
close $rd_report	 
}

foreach report $new {
        set rd_report [open $report r]
	set filename [file rootname [file tail $report] ]
        puts "$filename"
        set pattern {Endpoint:}
	while {[gets $rd_report line] >= 0 } {
		 if {[regexp $pattern $line match]} {
                 set filename  [file tail $report]
                 set endpoint [lindex $line 1]
                 puts "$pattern value for $filename is $endpoint"
		 #puts "$endpoint"
                }
        }
close $rd_report
}


#Program taken online need to find out the source and this part is included at present to check whether it works with STA or noe
#This generated table is not the part of the required html table

proc TAG {name args} {
    set body [lindex $args end]
    set result "<$name"
    foreach {t v} [lrange $args 0 end-1] {
	append result " $t=\"" $v "\""
	
    }
    append result ">" [string trim [uplevel 1 [list subst $body]]] "</$name>"
    #puts "$result"
}
proc FOREACH {var lst str} {
    upvar 1 $var v 
    set result {}
    set s [list subst $str]	
    foreach v $lst {append result [string trim [uplevel 1 $s]]}
    return $result
 

}


# Build the data we're displaying
set titles {"" "X" "Y" "Z"}
set data {}
for {set x 0} {$x < 4} {incr x} {
    # Inspired by the Go solution, but with extra arbitrary digits to show 4-char wide values
    lappend data [list\
	    [expr {$x+1}] [expr {$x*3010}] [expr {$x*3+1298}] [expr {$x*2579+2182}]]
}
 
# Write the table to standard out
puts [TAG table border 1 {
	[TAG tr bgcolor #f0f0f0 {
	[FOREACH head $titles {
	    [TAG th {$head}]
	}]
    }]
    [FOREACH row $data {
	[TAG tr bgcolor #ffffff {
	    [FOREACH col $row {
		[TAG td align right {$col}]
	    }]
	}]
    }]
}]
















