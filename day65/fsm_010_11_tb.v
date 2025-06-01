module fsm_010_11_tb();

  reg clk, rst, data_in;
  wire y;

  fsm_010_11 dut(.clk(clk),.rst(rst),.data_in(data_in),.y(y));
  
  initial clk = 0;
  always #10 clk = ~clk;

  task reset();
  begin
    @(negedge clk);
    rst = 1'b1;
    @(negedge clk);
    rst = 1'b0;
  end
  endtask
  
  task din(input a);
  begin
    @(negedge clk);
    data_in = a;
  end
  endtask

  initial begin
    clk = 0;
    rst = 0;
    data_in = 0;

    reset;

    $monitor("Time=%0t | clk=%b rst=%b data_in=%b y=%b", $time, clk, rst, data_in, y);

    din(0);
    din(1);
    din(0); 
    din(0);
    din(1); 
    din(1); 
    din(0);
    din(1); 
    
    #50;
    $finish;
  end

endmodule
