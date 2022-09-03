# TCL-programming
Problem statement:
    1. To optimize the TCL script for STA – Main task

  - Read the libraries files one by one
  - Read the verilog files one by one 
  - Link the design
  - Read the SDC file
  - Create directories to save the generated report file for the different verilog files  

Sub task – 
 - Renaming the report files
       The report files are named in the following format (PVTCorner_Post_DFlevel_rpttype.rpt) eg ff100C1v65_Post_synthesis_minmax.rpt
 -  Generation of html table
   - From the generated report – Extract the 
     a. Hold and setup slack b. Start-point and end point for both the setup and hold case and thereafter generate a table consisting the above values
   - Combine the start-point and endpoint values of setup and hold and placed it into two different columns
   
   The timing libraries are available in this [folder](https://github.com/Geetima2021/vsdpcvrd/tree/main/resources/timing_libs). The verilog files are available [here](https://github.com/Geetima2021/vsdpcvrd/tree/main/resources/openlane_opensta/verilog).
    
- The ```riscv_sta.tcl``` file is used for sta analysis for the Post_synthesis netlts using opensource tool ``OpenSTA``. ``riscv_conf.tcl``is the tcl file for sta analysis of the different netlist use in PNR flow of RISCV. We use the following command to execute OpenSTA ```sta <tcl file1>```. At present the tcl file is use for sta analysis of ``Post_Synthesis``stage across the different sky130 timing libraries. The TCL script shall be modified for sta analysis across other PnR stages. The max and min delay report is generated at present and report for wns, tns is yet to be included.
- Next an html table is created from the generated report file whose code is available in ``riscv_rpt_table.tcl`` file and ``build_report.html`` is its html file automatically generated from the tcl code. For execuction of the code ``tclsh <tcl file2>`` command is used. 

 
 ## Acknowledgemwnt
 
- [Phillip Guhring](https://github.com/thesourcerer8), Software architect at Libresilicon Association.
- [Kunal Ghosh](https://github.com/kunalg123), Co-founder, VSD Corp. Pvt. Ltd.
 
