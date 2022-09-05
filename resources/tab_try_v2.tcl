#! /bin/env tclsh
set report [open build_report1.html w+]
puts $report {<html><body><table border="1">}
puts $report {<tr><td colspan = "10" > Static timing analysis - Post synthesis</td></tr>}
#puts $report {<tr><td title='Process/Voltage/Temperature Corner'>PVT Corner</td><td>Start/end point(hold)</td><td>Start/end point(setup)</td><td title='nanoseconds'>Hold slack</td><td title='nanoseconds'>Setup slack</td><td title='nanoseconds'>WNS</td></tr>}
puts $report {<tr><td title='Simulation Number'>SI No.</td><td title='Process/Voltage/Temperature Corner'>PVT Corner</td><td>Start/end point(hold)</td><td>Start/end point(setup)</td><td title='nanoseconds'>Hold slack</td><td title='nanoseconds'>Setup slack</td><td title='nanoseconds'>WNS</td></tr>}

set rpt [lsort [glob Post_Synthesis/*.rpt] ]
set count 1
foreach rpt_file $rpt {		
	set rd_report [open $rpt_file r]
	set filename [lindex [split [file rootname [file tail $rpt_file] ] _ ] 0] 	        	
	set group 0
  	while {[gets $rd_report line] != -1 } {		
		set pattern {Startpoint:}
		if {[regexp $pattern $line ]} {	
		set start($group) [lindex $line 1] 
	        } 		
		set pattern1 {Endpoint:}
		if {[regexp $pattern1 $line ]} {
		set end($group) [lindex $line 1]
		}				
		set pattern2 {slack}	
		if {[regexp $pattern2 $line ]} {
		set sla($group) [lindex $line 0]
		incr group
		if {[lindex $line 0] > 0} {
		set a "-"
		puts $a
		} else {
		set a 1
		puts $a
		}		
		}
         }	
	close $rd_report
	set start0 $start(0)
	set start1 $start(1)
	set end0 $end(0)
	set end1 $end(1)
	set sla0 $sla(0)
	set sla1 $sla(1)
	

			 
        puts $report "<td>$count</td><td><a href ='$rpt_file' target ='_blank'>$filename </a></td><td>$start0/$end0</td><td>$start1/$end1</td><td>$sla0</td><td>$sla1</td></tr>"
	#puts $report "<td><a href ='$rpt_file' target ='_blank'>$filename </a></td><td>$start0/$end0</td><td>$start1/$end1</td><td>$sla0</td><td>$sla1</td><td>$wns1</td></tr>"
	incr count
}
set rpt1 [lsort [glob Post_Synthesis_WNS/*.rpt] ]
foreach rpt1_file $rpt1 {
	set rd_report1 [open $rpt1_file r]
	set filename [lindex [split [file rootname [file tail $rpt_file] ] _ ] 0]
	while {[gets $rd_report1 line] != -1} {
		set pattern3 {wns}
		if {[regexp $pattern3 $line]} {
		set wns1 [lindex $line 1]
		#puts $wns1
		}
	}
	close $rd_report1 
	#puts $report "<tr><td>$wns1</td></tr>"

}
set rpt1 [lsort [glob Post_Synthesis_TNS/*.rpt] ]
foreach rpt1_file $rpt1 {
	set rd_report1 [open $rpt1_file r]
	set filename [lindex [split [file rootname [file tail $rpt_file] ] _ ] 0]
	while {[gets $rd_report1 line] != -1} {
		set pattern3 {tns}
		if {[regexp $pattern3 $line]} {
		set tns1 [lindex $line 1]
		#puts $tns1
		}
	}
	close $rd_report1 
	#puts $report "<tr><td>$wns1</td></tr>"
}

puts $report {</table></body></html>}




