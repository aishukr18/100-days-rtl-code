meealy_101_tb();
  reg clk, rst, data_in;
  wire y;

  meealy_101 dut(
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .y(y)
  );


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
  
  // Data input task
  task din(input a);
  begin
    @(negedge clk);
    data_in = a;
  end
  endtask

  initial begin
    // Initial values
    clk = 0;
    rst = 0;
    data_in = 0;

    // Apply reset
    reset;

    // Monitor values
    $monitor("Time=%0t | clk=%b rst=%b data_in=%b y=%b", $time, clk, rst, data_in, y);

    // Input sequence to test detection of non-overlapping "101"
    din(1);
    din(0);
    din(1); // Should detect 101 here -> y=1
    din(0);
    din(1); // Should detect 101 here again -> y=1
    din(1); // No 101, just a single 1
    din(0);
    din(1); // Should detect 101 here -> y=1

    #50;
    $finish;
  end
endmodule
