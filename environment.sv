//A container class that contains Mailbox, Generator, Driver, Monitor and Scoreboard
//Connects all the components of the verification environment


`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"


class environment;
  
  
    //mailbox handles
  mailbox		gen2driv;
  mailbox		mon2scb;
  
  //handles of all components
  generator 	gen;
  driver		driv;
  monitor		mon;
  scoreboard	scb;
  

  
  //declare an event
  
  //virtual interface handle
  virtual dut_if mem_vif;
  
  //constructor
  function new(virtual dut_if mem_vif, int total_trans);
    this.mem_vif = mem_vif;
    
    // creating the mailbox handles
    gen2driv	= new();
    mon2scb		= new();
    
    gen			= new(gen2driv, total_trans);
    driv		= new(gen2driv, mem_vif,  total_trans);
    mon			= new(mon2scb, mem_vif, total_trans);
    scb			= new(mon2scb, total_trans);
    
  endfunction
    
  //event for synchronization between generator and test
  event gen_end;
  
  
  //pre_test methods
    task pre_test();
      driv.reset();
    endtask
  
  //test methods
    task test();
      fork
        gen.main();
       
        driv.main();
        mon.main();
        scb.main();
        
      join_any
      
    endtask
  
  //post_test methods
  task post_test();
    //$display("before trigger___---Post test");
    wait(gen.ended.triggered);
    wait(driv.drv_ended.triggered);
    wait(mon.mon_ended.triggered);
    wait(scb.scb_ended.triggered);
   
    $display("Saleem");
   //wait(gen.total_trans == driv.total_trans);
    //wait(gen.total_trans == scb.total_trans);
  endtask
    
  //run methods
  task run();
    pre_test();
    test();
    post_test();
    $finish;
  endtask
  
endclass


