//Interface groups the design signals, specifies the direction (Modport) and Synchronize the signals(Clocking Block)

interface dut_if(input logic HCLK, HRESETn);
  
  
  //SYSTEMVERILOG: timeunit and timeprecision notation
  	timeunit 1ns;
  	timeprecision 100ps;
  
  
  
  // Add design signals here
  		
  	logic		[31:0] HWDATA;
  	logic		[31:0] HADDR;
  	logic 		[31:0] HRDATA;
  	logic		[2:0] HSIZE;
  	logic		[2:0] HBURST;
  	logic		[3:0] HPROT;
  	logic		[1:0] HTRANS;
  	logic			  HWRITE;
  	logic			  HSEL;
  	logic			  HRESP;
  	logic			  HREADY;
  	logic			  HREADYOUT;
    logic			  	  error;
  
  
  
  //Master Clocking block - used for Drivers
  
  	clocking driver_cb @(posedge HCLK);
      
      
      default input #1 output #1;		//input and output skews
      output  		   HSEL, HADDR, HWDATA, HWRITE, HSIZE, HBURST, HPROT, HTRANS, error;
      input			   HRDATA, HREADYOUT, HRESP, HREADY;
      
    endclocking
  
  
  //Monitor Clocking block - For sampling by monitor components
  
  
  	  
  	clocking monitor_cb @(posedge HCLK);
      
      
      default input #1 output #1;		//input and output skews
      input  		   HSEL, HADDR, HWDATA, HWRITE, HSIZE, HBURST, HPROT, HTRANS;
      input			   HRDATA, HREADYOUT, HRESP,HREADY, error;
      
    endclocking
  
  
  
  //Add modports here
  
  
  modport MON (
    
    clocking monitor_cb, input HCLK, HRESETn
  
  );
  
  
  modport DRV (
    
    clocking driver_cb, input HCLK, HRESETn
  
  );
  
      
  
  
  
  
endinterface
