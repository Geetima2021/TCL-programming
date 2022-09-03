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
   - Add the WNS,TNS and FEP values

## Implementation

   The required timing libraries and verilog files required are available in this [folder1](https://github.com/Geetima2021/vsdpcvrd/tree/main/resources) and [folder2](https://github.com/Geetima2021/vsdpcvrd/tree/main/resources/openlane_opensta/verilog) respectively. Other necessary files are available [here](https://github.com/Geetima2021/TCL-programming/tree/main/resources).
    
- Initially ``riscv_sta.tcl`` file is written for Post_synthesis netlist STA analysis using opensource tool ``OpenSTA`` across the different skywater130 timing libraries. The file is executed using the ``sta <tclfile>`` command. The generated report is saved in [Post_Synthesis directory](https://github.com/Geetima2021/TCL-programming/tree/main/resources/Post_Synthesis).
- Next an html table is created from the generated report file whose code is available in ``riscv_rpt_table.tcl`` file and ``build_report.html`` is its html file, automatically generated from the tcl code. For execuction of the code ``tclsh <tcl file2>`` command is used.
- Next the script is further modified for simultaneous sta analysis of all the PnR netlists available. ``riscv_conf.tcl``is the modified tcl file used in sta analysis of the different netlist use in PnR flow of RISCV [Note: The netlists and the spef file are generated using openLANE flow]. The generated reports are saved in their respective folder. Apart from the minmax report, wns and tns report are also generated. 
- The script ``riscv_rpt_table.tcl`` is to be modified to append the wns, tns and fep values in the html table. The Post_CTS and Post_Layout table is to be generated.

 
 ## Acknowledgement
 
- [Phillip Guhring](https://github.com/thesourcerer8), Software architect at Libresilicon Association.
- [Kunal Ghosh](https://github.com/kunalg123), Co-founder, VSD Corp. Pvt. Ltd.
 
