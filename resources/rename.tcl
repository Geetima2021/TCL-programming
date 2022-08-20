#! /bin/env tclsh

set lib_dir [glob ../../../timing_libs/*.lib]

foreach line $lib_dir {
	
	set filename [file tail $line ]
	set name1 [lindex [split [file rootname $filename] hd] 3]
	
	set ext [file extension $filename]
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

