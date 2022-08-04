#! /bin/env tclsh

set new [glob Post_Synthesis/*.rpt]

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
                set startpoint [lindex $line 1]
                #puts "$pattern value for $filename is $startpoint"
	        puts "$startpoint"
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
                 #puts "$pattern value for $filename is $endpoint"
		 puts "$endpoint"
                }
        }
close $rd_report
}
