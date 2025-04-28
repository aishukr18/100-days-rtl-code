module sr_ff_tb();
  reg clk, rst, s, r;
  wire q, qb;

  sr_ff uut (.clk(clk), .rst(rst), .s(s), .r(r), .q(q), .qb(qb));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  initial begin
    // Initial values
    rst = 1; s = 0; r = 0;
    #10 rst = 0;

    // Apply inputs
    s = 1; r = 0; #10;   // Set
    s = 0; r = 1; #10;   // Reset
    s = 0; r = 0; #10;   // No change
    s = 1; r = 1; #10;   // Invalid condition

    #20 $finish;
  end
endmodule
