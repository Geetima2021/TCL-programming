#! /bin/env tclsh
set report [open build_report.html w+]
puts $report {<html><body><table border="1">}
puts $report {<tr><td colspan = "10" > Static timing analysis - Post synthesis</td></tr>}
puts $report {<tr><td title='Simulation Number'>SI No.</td><td title='Process/Voltage/Temperature Corner'>PVT Corner</td><td>Start/end point(setup)</td><td>Start/end point(hold)</td><td title='nanoseconds'>Setup slack</td><td title='nanoseconds'>Hold slack</td></tr>}
set rpt [glob Post_Synthesis/*.rpt]
set count 0
foreach rpt_file $rpt {	
	set rd_report [open $rpt_file r]
	set filename [lindex [split [file rootname [file tail $rpt_file] ] _ ] 0] 	
	set group 0
  	while {[gets $rd_report line] != -1 } {
		#set start($lineno)
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
		set sla($group) [lindex [string map {"       " ""} $line] 0]
		incr group
		}
         }	
	close $rd_report
	set start0 $start(0)
	set start1 $start(1)
	set end0 $end(0)
	set end1 $end(1)
	set sla0 $sla(0)
	set sla1 $sla(1)
        puts $report "<td>$count</td><td>$filename</td><td>$start1/$end1</td><td>$start0/$end0</td><td>$sla1</td><td>$sla0</td></tr>"
	incr count
}
puts $report {</table></body></html>}
	
	











