//Gets the packet from generator and drive the transaction packet items into interface (interface is connected to DUT, so the items driven into interface signal will get driven in to DUT) 

class driver;
  //virtual interface handle
  virtual dut_if.DRV mem_vif;
  
  int total_trans;
  event drv_ended;
  
  //declare transaction class
   transaction trans;

  //create mailbox handle
  mailbox gen2driv;

  //constructor
  function new(mailbox gen2driv, virtual dut_if.DRV mem_vif, int total_trans);
    //getting the interface
    this.mem_vif = mem_vif;
    //getting the mailbox handle from enivroment
    this.gen2driv = gen2driv;
    this.total_trans = total_trans;
  endfunction
    
  
  //reset methods
  task reset;
    wait(!mem_vif.HRESETn);
    $display("-----[DRIVER]------- Reset");
  //  mem_vif.HSEL 	  	   <= 1;
    mem_vif.driver_cb.HWDATA 	   <= 0;
    mem_vif.driver_cb.HADDR 	   <= 0;
    mem_vif.driver_cb.HSIZE 	   <= 0;
    mem_vif.driver_cb.HBURST 	   <= 0;
    mem_vif.driver_cb.HTRANS 	   <= 0;
    mem_vif.driver_cb.HPROT 	   <= 0;
    mem_vif.driver_cb.HWRITE 	   <= 1;
    mem_vif.driver_cb.error	   <=0;
  //	mem_vif.HREADY 	   <= 1;
    
    wait(mem_vif.HRESETn);
    $display("-----[DRIVER]------- Reset");
  endtask
  
  

  //drive methods
  task drive;
   
    $display("Driver transaction items to interface signals", total_trans);
  
      repeat (total_trans) begin
        
       
        trans = new();
        gen2driv.get(trans);
        
        // begin
        @(posedge mem_vif.HCLK);
        mem_vif.driver_cb.HWDATA 	   <= trans.HWDATA;
        mem_vif.driver_cb.HADDR 	   <= trans.HADDR;
        mem_vif.driver_cb.HSIZE 	   <= trans.HSIZE;
        mem_vif.driver_cb.HBURST 	   <= trans.HBURST;
        mem_vif.driver_cb.HTRANS 	   <= trans.HTRANS;
        mem_vif.driver_cb.HPROT 	   <= trans.HPROT;
        mem_vif.driver_cb.HWRITE 	   <= 1;
    
        @(posedge mem_vif.HCLK);
        mem_vif.driver_cb.HWRITE 	   <= 0;

        
       $display("Address: %0h Data: %0h", mem_vif.driver_cb.HADDR, mem_vif.driver_cb.HWDATA);
        end
    ->drv_ended;
     
  
  endtask
       

  //main methods
  task main();
    //$display("Saleem");
      
    //$display("Address: %0h Data: %0h", trans.HADDR, trans.HWDATA);
    wait(mem_vif.HRESETn) begin
      drive();
    end
   // end 
  endtask : main
        
endclass
