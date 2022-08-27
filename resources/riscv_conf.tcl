#! /bin/env tclsh

set lib_dir [lsort [glob ../../../timing_libs/*.lib] ]
set verilog_files  [lsort [glob ../verilog_files/*.v] ]
foreach lines $lib_dir {	
	set filename [file tail $lines ]
	set name1 [lindex [split [file rootname $filename] hd] 3]	
	#set ext [file extension $filename]
	set map1 [string map {"__" ""} $name1]
	set map2 [string map {"_" ""} $map1]	
	set new_name "$map2"
	read_liberty $lines
		set synthesis_file_path [lindex $verilog_files 0]
		if {[file exists $synthesis_file_path]} {
			set filename1 [string totitle [lindex [split [file rootname [file tail $synthesis_file_path] ] .] 1] ]
			mkdir -p Post_$filename1
			mkdir -p Post_$filename1\_WNS
			mkdir -p Post_$filename1\_TNS			
			read_verilog $synthesis_file_path
			link_design rvmyth	
			read_sdc -echo rvmyth.sdc
			report_checks -path_delay min_max -fields {nets cap slew input_pins} -digits {4} > Post_Synthesis/$new_name\_Post_synthesis_minmax.rpt
			report_wns > Post_Synthesis_WNS/$new_name\_Post_synthesis_wns.rpt
			report_tns > Post_Synthesis_TNS/$new_name\_Post_synthesis_tns.rpt
			}
		set cts_file_path [lindex $verilog_files 1]
		if {[file exists $cts_file_path]} {
			set filename2 [string toupper [lindex [split [lindex [split [file rootname [file tail $$cts_file_path] ] .] 1] _] 1] ] 
			mkdir -p Post_$filename2
			mkdir -p Post_$filename2\_WNS
			mkdir -p Post_$filename2\_TNS
			read_verilog $cts_file_path
			link_design rvmyth	
			read_sdc -echo rvmyth.sdc
			set_propagated_clock [all_clocks]
			#report_checks -path_delay min_max -fields {nets cap slew input_pins} -format full_clock_expanded -digits {4} > Post_CTS/$new_name\_Post_cts_minmax.rpt
			report_checks -path_delay min_max -fields {nets cap slew input_pins} -digits {4} > Post_CTS/$new_name\_Post_cts_minmax.rpt
			report_wns > Post_CTS_WNS/$new_name\_Post_cts_wns.rpt
			report_tns > Post_CTS_TNS/$new_name\_Post_cts_tns.rpt
			}
		set preroute_file_path [lindex $verilog_files 2]
		if {[file exists $preroute_file_path]} {
			set filename3 [string totitle [lindex [split [lindex [split [file rootname [file tail $preroute_file_path] ] .] 1] _] 1] ]
			mkdir -p Post_$filename3
			mkdir -p Post_$filename3\_WNS
			mkdir -p Post_$filename3\_TNS
			read_verilog $preroute_file_path
			link_design rvmyth	
			read_sdc -echo rvmyth.sdc
			set_propagated_clock [all_clocks]
			read_spef rvmyth.spef
			#report_checks -path_delay min_max -fields {nets cap slew input_pins} -format full_clock_expanded -digits {4} > Post_Preroute/$new_name\_Post_Preroute_minmax.rpt
			report_checks -path_delay min_max -fields {nets cap slew input_pins} -digits {4} > Post_Preroute/$new_name\_Post_Preroute_minmax.rpt
			report_wns > Post_Preroute_WNS/$new_name\_Post_preroute_wns.rpt
			report_tns > Post_Preroute_TNS/$new_name\_Post_preroute_tns.rpt
			}
	
	
}


















