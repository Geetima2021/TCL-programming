- The ```riscv_sta.tcl``` file is used for sta analysis using opensource tool ``OpenSTA``. We use the following command to execute OpenSTA ```sta <tcl file1>```. At present the tcl file is use for sta analysis of ``Post_Synthesis``stage across the different sky130 timing libraries. The TCL script shall be modified for sta analysis across other PnR stages. The max and min delay report is generated at present and report for wns, tns is yet to be included.
- Next an html table is created from the generated report file whose code is available in ``riscv_rpt_table.tcl`` file and ``build_report.html`` is its html file. For execuction of the code ``tclsh <tcl file2>`` command is used. 



