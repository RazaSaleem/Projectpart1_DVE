//Generates randomized transaction packets and put them in the mailbox to send the packets to driver 

class generator;
  
  //declare transaction class
  
  rand transaction trans;
    
  //create mailbox handle
  mailbox gen2driv;
  
  
  //repeat count, to specify number of items to generate
  int  total_trans;
  
  //declare an event
  event ended;
  
  //constructor
  function new(mailbox gen2driv, int total_trans);
    // getting the mailbox handle from env
    this.gen2driv = gen2driv;
    this.total_trans = total_trans;
    //this.ended = ended;
  endfunction
  
  //main methods
  task main();
    repeat(total_trans) begin
      
      trans = new();
      if(!trans.randomize()) $display ("GEN: transaction randomize failed");
      gen2driv.put(trans);
      //$display("1=%d    ------ 2=%d" , trans.HADDR, trans.HWDATA);
    end
      -> ended;
   
  endtask
  
endclass
