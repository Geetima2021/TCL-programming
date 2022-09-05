#! /bin/env tclsh
set report [open build_report1.html w+]
puts $report {<html><body><table border="1">}
puts $report {<tr><td colspan = "10" > Static timing analysis - Post Synthesis</td></tr>}
#puts $report {<tr><td title='Process/Voltage/Temperature Corner'>PVT Corner</td><td>Start/end point(hold)</td><td>Start/end point(setup)</td><td title='nanoseconds'>Hold slack</td><td title='nanoseconds'>Setup slack</td><td title='nanoseconds'>WNS</td></tr>}
puts $report {<tr><td title='Simulation Number'>SI No.</td><td title='Process/Voltage/Temperature Corner'>PVT Corner</td><td>Start/end point(hold)</td><td>Start/end point(setup)</td><td title='nanoseconds'>Hold slack</td><td title='nanoseconds'>Setup slack</td><td title='nanoseconds'>WNS</td><td title='nanoseconds'>TNS</td></tr>}

set rpt [lsort [glob Post_Synthesis/*.rpt] ]
set count 1
foreach rpt_file $rpt {		
	set rd_report [open $rpt_file r]
	set filename [lindex [split [file rootname [file tail $rpt_file] ] _ ] 0]
	set filenamewns [regsub "synthesis_minmax" [regsub "Post_Synthesis" $rpt_file "Post_Synthesis_WNS"] "synthesis_wns" ]
	set wns_report [open $filenamewns r]
	set filenametns [regsub "synthesis_minmax" [regsub "Post_Synthesis" $rpt_file "Post_Synthesis_TNS"] "synthesis_tns" ]
	set tns_report [open $filenametns r]
	      	
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
		#set new [regsub "$rd_report" $filenamewns ]
		#puts $new
		#if {[lindex $line 0] > 0} {
		#set a "-"
		#puts $a
		#} else {
		#set a 1
		#puts $a
		#}		
		}		
         }	
	close $rd_report
	while {[gets $wns_report line] != -1 } {
		set pattern {wns}
		if {[regexp $pattern $line]} {
		set worse_negative_slack [lindex $line 1]
		}			
	}
	close $wns_report
	while {[gets $tns_report line] != -1 } {
		set pattern {tns}
		if {[regexp $pattern $line]} {
		set total_negative_slack [lindex $line 1]
		}
	}
	close $tns_report
	set start0 $start(0)
	set start1 $start(1)
	set end0 $end(0)
	set end1 $end(1)
	set sla0 $sla(0)
	set sla1 $sla(1)
			 
        puts $report "<td>$count</td><td><a href ='$rpt_file' target ='_blank'>$filename </a></td><td>$start0/$end0</td><td>$start1/$end1</td><td>$sla0</td><td>$sla1</td><td>$worse_negative_slack</td><td>$total_negative_slack</td></tr>"

	incr count
}
puts $report {</table></body></html>}


puts $report {<html><body><table border="1">}
puts $report {<tr><td colspan = "10" > Static timing analysis - Post CTS</td></tr>}
#puts $report {<tr><td title='Process/Voltage/Temperature Corner'>PVT Corner</td><td>Start/end point(hold)</td><td>Start/end point(setup)</td><td title='nanoseconds'>Hold slack</td><td title='nanoseconds'>Setup slack</td><td title='nanoseconds'>WNS</td></tr>}
puts $report {<tr><td title='Simulation Number'>SI No.</td><td title='Process/Voltage/Temperature Corner'>PVT Corner</td><td>Start/end point(hold)</td><td>Start/end point(setup)</td><td title='nanoseconds'>Hold slack</td><td title='nanoseconds'>Setup slack</td><td title='nanoseconds'>WNS</td><td title='nanoseconds'>TNS</td></tr>}

set rpt [lsort [glob Post_CTS/*.rpt] ]
set count 1
foreach rpt_file $rpt {		
	set rd_report [open $rpt_file r]
	set filename [lindex [split [file rootname [file tail $rpt_file] ] _ ] 0]
	set filenamewns [regsub "cts_minmax" [regsub "Post_CTS" $rpt_file "Post_CTS_WNS"] "cts_wns" ]
	set wns_report [open $filenamewns r]
	set filenametns [regsub "cts_minmax" [regsub "Post_CTS" $rpt_file "Post_CTS_TNS"] "cts_tns" ]
	set tns_report [open $filenametns r]
	      	
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
		#set new [regsub "$rd_report" $filenamewns ]
		#puts $new
		#if {[lindex $line 0] > 0} {
		#set a "-"
		#puts $a
		#} else {
		#set a 1
		#puts $a
		#}		
		}		
         }	
	close $rd_report
	while {[gets $wns_report line] != -1 } {
		set pattern {wns}
		if {[regexp $pattern $line]} {
		set worse_negative_slack [lindex $line 1]
		}			
	}
	close $wns_report
	while {[gets $tns_report line] != -1 } {
		set pattern {tns}
		if {[regexp $pattern $line]} {
		set total_negative_slack [lindex $line 1]
		}
	}
	close $tns_report
	set start0 $start(0)
	set start1 $start(1)
	set end0 $end(0)
	set end1 $end(1)
	set sla0 $sla(0)
	set sla1 $sla(1)
			 
        puts $report "<td>$count</td><td><a href ='$rpt_file' target ='_blank'>$filename </a></td><td>$start0/$end0</td><td>$start1/$end1</td><td>$sla0</td><td>$sla1</td><td>$worse_negative_slack</td><td>$total_negative_slack</td></tr>"

	incr count
}
puts $report {</table></body></html>}


puts $report {<html><body><table border="1">}
puts $report {<tr><td colspan = "10" > Static timing analysis - Post Layout</td></tr>}
#puts $report {<tr><td title='Process/Voltage/Temperature Corner'>PVT Corner</td><td>Start/end point(hold)</td><td>Start/end point(setup)</td><td title='nanoseconds'>Hold slack</td><td title='nanoseconds'>Setup slack</td><td title='nanoseconds'>WNS</td></tr>}
puts $report {<tr><td title='Simulation Number'>SI No.</td><td title='Process/Voltage/Temperature Corner'>PVT Corner</td><td>Start/end point(hold)</td><td>Start/end point(setup)</td><td title='nanoseconds'>Hold slack</td><td title='nanoseconds'>Setup slack</td><td title='nanoseconds'>WNS</td><td title='nanoseconds'>TNS</td></tr>}

set rpt [lsort [glob Post_Layout/*.rpt] ]
set count 1
foreach rpt_file $rpt {		
	set rd_report [open $rpt_file r]
	set filename [lindex [split [file rootname [file tail $rpt_file] ] _ ] 0]
	set filenamewns [regsub "layout_minmax" [regsub "Post_Layout" $rpt_file "Post_Layout_WNS"] "layout_wns" ]
	set wns_report [open $filenamewns r]
	set filenametns [regsub "layout_minmax" [regsub "Post_Layout" $rpt_file "Post_Layout_TNS"] "layout_tns" ]
	set tns_report [open $filenametns r]
	      	
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
		#set new [regsub "$rd_report" $filenamewns ]
		#puts $new
		#if {[lindex $line 0] > 0} {
		#set a "-"
		#puts $a
		#} else {
		#set a 1
		#puts $a
		#}		
		}		
         }	
	close $rd_report
	while {[gets $wns_report line] != -1 } {
		set pattern {wns}
		if {[regexp $pattern $line]} {
		set worse_negative_slack [lindex $line 1]
		}			
	}
	close $wns_report
	while {[gets $tns_report line] != -1 } {
		set pattern {tns}
		if {[regexp $pattern $line]} {
		set total_negative_slack [lindex $line 1]
		}
	}
	close $tns_report
	set start0 $start(0)
	set start1 $start(1)
	set end0 $end(0)
	set end1 $end(1)
	set sla0 $sla(0)
	set sla1 $sla(1)
			 
        puts $report "<td>$count</td><td><a href ='$rpt_file' target ='_blank'>$filename </a></td><td>$start0/$end0</td><td>$start1/$end1</td><td>$sla0</td><td>$sla1</td><td>$worse_negative_slack</td><td>$total_negative_slack</td></tr>"

	incr count
}
puts $report {</table></body></html>}








