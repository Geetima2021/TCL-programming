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
    
 Example table 
 
 
 ![tab](https://user-images.githubusercontent.com/63381455/182808943-87f2ecb2-b665-46f1-b5e5-4a56f88fc0f0.png)
 
 
 Thereafter the WNS, TNS and FEP shall be appended to the table.
 
 ## Acknowledgement
 
 This work is in continuation to the vsdhdp titled ``Performance characterization for VSDBabySoC comprising of RISC-V core, PLL and DAC``.
 
- [Phillip Guhring](https://github.com/thesourcerer8), Software architect at Libresilicon Association.
- [Kunal Ghosh](https://github.com/kunalg123), Co-founder, VSD Corp. Pvt. Ltd.
 
