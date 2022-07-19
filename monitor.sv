//Samples the interface signals, captures into transaction packet and sends the packet to scoreboard.

class monitor;
  
  //virtual interface handle
  virtual dut_if.MON mem_vif;

  int total_trans;
  event mon_ended;
  
  //create mailbox handle
  mailbox mon2scb;

  //constructor
  function new(mailbox mon2scb, virtual dut_if.MON mem_vif, int total_trans);
    this.mem_vif = mem_vif;
    this.mon2scb = mon2scb;
    this.total_trans= total_trans;
  endfunction
  
  
  
  function void signals(transaction trans);
    trans.HWDATA 	   <= mem_vif.monitor_cb.HWDATA;
    trans.HADDR 	   <= mem_vif.monitor_cb.HADDR;
    trans.HSIZE 	   <= mem_vif.monitor_cb.HSIZE;
    trans.HBURST 	   <= mem_vif.monitor_cb.HBURST;
    trans.HTRANS 	   <= mem_vif.monitor_cb.HTRANS;
    trans.HPROT 	   <= mem_vif.monitor_cb.HPROT;
    trans.HWRITE 	   <= mem_vif.monitor_cb.HWRITE;
    trans.HRDATA 	   <= mem_vif.monitor_cb.HRDATA;
    trans.HREADY 	   <= mem_vif.monitor_cb.HREADY;
    trans.HRESP 	   <= mem_vif.monitor_cb.HRESP;
    trans.HSEL 	   	   <= mem_vif.monitor_cb.HSEL;
  
  endfunction
       


  //main method
  task main();
    transaction trans;
    repeat(total_trans) begin
      trans = new();
      @(posedge mem_vif.HCLK);
      signals(trans);
      @(posedge mem_vif.HCLK);
     
     // $display("Address: %0h Data: %0h", mem_vif.monitor_cb.HADDR, mem_vif.monitor_cb.HWDATA);
      mon2scb.put(trans);
      
     //$display("Address: %0h Data: %0h", trans.HADDR, trans.HWDATA);
    end
    ->mon_ended;
    
  endtask

    

endclass
