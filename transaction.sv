//Fields required to generate the stimulus are declared in the transaction class

class transaction;

  //declare transaction items
  
  //input signals to DUT
  
  rand bit	[31:0] HWDATA;
  rand bit	[31:0] HADDR;
  rand bit	[2:0]  HSIZE;
  rand bit	[2:0]  HBURST;
  rand bit  [1:0]  HTRANS;
  rand bit  [3:0]  HPROT;
  bit		       HWRITE;
  rand bit  	   HSEL;
  
  //output signals from DUT
  
  bit	    [31:0] HRDATA;
  bit			   HRESP;
  bit			   HREADY;
  bit			   READYOUT;
  
  
  //Add Constraints
  
  constraint CON_C1 {
    
    HWDATA inside {[0:150]};
    HSIZE inside {3'b010};  //HSIZE must be less than or equal to width of data bus
    HTRANS inside { 2'b10}; //IDLE = 10 , BUSY = 10 , NONSEQ = 80 , SEQ
    HPROT inside {4'b0001}; //protection signal for data access only
    HBURST inside {3'b000};
    HSEL inside {1'b1}; // Because we have only one slave
    HADDR inside {[0:255]}; //since slave memory range is 0x0-0x255
  
  }
  constraint c2 {if (HSIZE == 1) HADDR % 2 ==0;
                 else if (HSIZE == 2) HADDR % 4 ==0;}

  //Add print transaction method(optional)
  
//   function new(bit [31:0] HWDATA, bit [31:0] HADDR, bit [2:0] HSIZE, bit [2:0] HBURST, bit [1:0] HTRANS, bit [3:0] HPROT, bit HWRITE, bit HSEL, bit [31:0] HRDATA, bit HRESP, bit HREADY, bit READYOUT);
//     this.HWDATA = HWDATA;
//     this.HADDR = HADDR;
//     this.HSIZE = HSIZE;
//     this.HBURST = HBURST;
//     this.HTRANS = HTRANS;
//     this.HPROT = HPROT;
//     this.HWRITE = HWRITE;
//     this.HSEL = HSEL;
//     this.HRDATA = HRDATA;
//     this.HRESP = HRESP;
//     this.HREADY = HREADY;
//     this.READYOUT = READYOUT;
//   endfunction
  
  function void display();
    $display("- HWDATA = %0d, HADDR = %0d, HSIZE = %0d, HBURST = %0d, HTRANS = %0d, HPROT = %0d, HWRITE = %0d, HSEL = %0d, HRDATA = %0d, HRESP = %0d, HREADY = %0d, READYOUT = %0d",HWDATA ,HADDR, HSIZE, HBURST, HTRANS, HPROT, HWRITE, HSEL, HRDATA, HRESP, HREADY, READYOUT);
 
  endfunction
   
endclass
