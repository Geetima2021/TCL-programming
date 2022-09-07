#! /bin/env tclsh
set report [open build_report.html w+]
puts $report {<html>}
puts $report {<style>
body {
    font-family: Open Sans, Source Sans Pro, system-ui, -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Arial, sans, Apple Color Emoji, Segoe UI Emoji, Georgia
}
body a:hover {
    background-color: yellow;
}
body>a {
    background-color: lavender;
    margin: 5px;
    color: darkblue;
    font-family: Open Sans, Source Sans Pro, system-ui, -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Arial, sans, Apple Color Emoji, Segoe UI Emoji, Georgia;
    text-decoration: none;
    display: inline-block;
    padding:4px 10px 4px 10px;
    border-radius: 5px;
}
table {
    border-collapse:collapse;
    border-color: gray;
}
h1 {
    font-family: Open Sans, Source Sans Pro, system-ui, -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Arial, sans, Apple Color Emoji, Segoe UI Emoji, Georgia;
    color: #303030;
}
h2 {
    font-family: Open Sans, Source Sans Pro, system-ui, -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Arial, sans, Apple Color Emoji, Segoe UI Emoji, Georgia;
    color: #303030;
}
td {
    font-family: Open Sans, Source Sans Pro, system-ui, -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Arial, sans, Apple Color Emoji, Segoe UI Emoji, Georgia;
    font-size: -1;
    vertical-align: top;
    border-color: gray;
    padding: 2px;
}
tr:nth-child(even) {
  background-color:#e0f0e0;
}
tr:nth-child(odd) {
  background-color:#f8f8f8;
}
input:invalid {
  border: 2px dashed red;
}
.error {
  color: red;

}
.warning {
  color: red;
}
</style>}

puts $report {<body><table border="1">}
puts $report {<tr><td colspan = "10" > <h1> Static timing analysis - Post Synthesis</h1></td></tr>}

puts $report {<tr><td title='Simulation Number'><h2>SI No.</h2></td><td title='Process/Voltage/Temperature Corner'><h2>PVT Corner</h2></td><td><h2>Start/end point(hold)</h2></td><td><h2>Start/end point(setup)</h2></td><td title='nanoseconds'><h2>Hold slack</h2></td><td title='nanoseconds'><h2>Setup slack</h2></td><td title='nanoseconds'><h2>WNS</h2></td><td title='nanoseconds'><h2>TNS</h2></td></tr>}

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
			 
        puts $report "<tr><td>$count</td><td><a href ='$rpt_file' target ='_blank'>$filename </a></td><td>$start0/$end0</td><td>$start1/$end1</td><td>$sla0</td><td>$sla1</td><td>$worse_negative_slack</td><td>$total_negative_slack</td></tr>"

	incr count
}

puts $report {<tr><td colspan = "11" ><br></td></tr>}
puts $report {<tr><td colspan = "10" ><h1> Static timing analysis - Post CTS</h1></td></tr>}
puts $report {<tr><td title='Simulation Number'><h2>SI No.</h2></td><td title='Process/Voltage/Temperature Corner'><h2>PVT Corner</h2></td><td><h2>Start/end point(hold)</h2></td><td><h2>Start/end point(setup)</h2></td><td title='nanoseconds'><h2>Hold slack</h2></td><td title='nanoseconds'><h2>Setup slack</h2></td><td title='nanoseconds'><h2>WNS</h2></td><td title='nanoseconds'><h2>TNS</h2></td></tr>}

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
			 
        puts $report "<tr><td>$count</td><td><a href ='$rpt_file' target ='_blank'>$filename </a></td><td>$start0/$end0</td><td>$start1/$end1</td><td>$sla0</td><td>$sla1</td><td>$worse_negative_slack</td><td>$total_negative_slack</td></tr>"

	incr count
}

puts $report {<tr><td colspan = "11" ><br></td></tr>}
puts $report {<tr><td colspan = "10" ><h1> Static timing analysis - Post Layout</h1></td></tr>}
puts $report {<tr><td title='Simulation Number'><h2>SI No.</h2></td><td title='Process/Voltage/Temperature Corner'><h2>PVT Corner</h2></td><td><h2>Start/end point(hold)</h2></td><td><h2>Start/end point(setup)</h2></td><td title='nanoseconds'><h2>Hold slack</h2></td><td title='nanoseconds'><h2>Setup slack</h2></td><td title='nanoseconds'><h2>WNS</h2></td><td title='nanoseconds'><h2>TNS</h2></td></tr>}

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
			 
        puts $report "<tr><td>$count</td><td><a href ='$rpt_file' target ='_blank'>$filename </a></td><td>$start0/$end0</td><td>$start1/$end1</td><td>$sla0</td><td>$sla1</td><td>$worse_negative_slack</td><td>$total_negative_slack</td></tr>"

	incr count
}
puts $report {</table></body></html>}








