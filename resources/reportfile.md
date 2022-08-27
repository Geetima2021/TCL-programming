- The ```riscv_sta.tcl``` file is used for sta analysis for the Post_synthesis netlts using opensource tool ``OpenSTA``. ``riscv_conf.tcl``is the tcl file for sta analysis of the different netlist use in PNR flow of RISCV. We use the following command to execute OpenSTA ```sta <tcl file1>```. At present the tcl file is use for sta analysis of ``Post_Synthesis``stage across the different sky130 timing libraries. The TCL script shall be modified for sta analysis across other PnR stages. The max and min delay report is generated at present and report for wns, tns is yet to be included.
- Next an html table is created from the generated report file whose code is available in ``riscv_rpt_table.tcl`` file and ``build_report.html`` is its html file automatically generated from the tcl code. For execuction of the code ``tclsh <tcl file2>`` command is used. 



