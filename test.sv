//A program block that creates the environment and initiate the stimulus
`include "environment.sv"

program test(dut_if vif);
  
  //declare environment handle
  environment env;
  
  initial begin
    //create environment
    env = new(vif, 5);
    
    
   
    
    //initiate the stimulus by calling run of env
    env.run();

  end

endprogram
