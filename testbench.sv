// Code your testbench here
// or browse Examples
//Top most file which connets DUT, interface and the test

//-------------------------[NOTE]---------------------------------
//Particular testcase can be run by uncommenting, and commenting the rest
//`include "test1.sv"
//`include "test2.sv"
//`include "test3.sv"
//----------------------------------------------------------------
`include "test.sv"
`include "interface.sv"
module testbench_top;
  
  //declare clock and reset signal
  bit		clk = 0;
  logic		reset;

  //clock generation
  always #5 clk = ~clk;
    
  
  //reset generation
  initial begin
    reset = 0;
    #5 reset = 1;
  end

  //interface instance, inorder to connect DUT and testcase
  dut_if	vif(clk, reset);

  //testcase instance, interface handle is passed to test as an argument
  test t1(vif);
  
  //DUT instance, interface signals are connected to the DUT ports
  amba_ahb_slave DUT(  .hresetn (vif.HRESETn),
                       .hclk	(vif.HCLK),
                       .hsel	(vif.HSEL),
                       .haddr	(vif.HADDR),
                       .hwdata	(vif.HWDATA),
                       .hrdata	(vif.HRDATA),
                       .hwrite	(vif.HWRITE),
                       .hsize	(vif.HSIZE),
                       .hburst	(vif.HBURST),
                       .hprot	(vif.HPROT),
                       .htrans	(vif.HTRANS),
                       .hready	(vif.HREADY),
                       .hresp	(vif.HRESP),
                       .error	(vif.error)
);
  
  //enabling the wave dump
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
