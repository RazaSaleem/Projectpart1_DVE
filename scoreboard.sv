//Gets the packet from monitor, generates the expected result and compares with the actual result received from the Monitor

class scoreboard;
   
  //create mailbox handle
  mailbox mon2scb;
  
  int total_trans;
  int error = 0;
  event scb_ended;

  //array to use as local memory
  logic	[7:0] mem [0:1023];
  //constructor
  function new(mailbox mon2scb, int total_trans);
    this.total_trans = total_trans;
    this.mon2scb = mon2scb;
  endfunction
  
  //main method
  task main();
    //int fail=0;
    transaction trans;
    repeat(total_trans)
      begin
     
        mon2scb.get(trans);
        if(trans.HWRITE==1)
          mem[trans.HADDR]=trans.HWDATA;
        else
          begin
            if( mem [trans.HADDR] != trans.HRDATA) error++;
          end
      end
    if (error)
      $display("Test failed with %d errors", error);
    else 
      $display("Test Passed");
    ->scb_ended;
  endtask
  
endclass
