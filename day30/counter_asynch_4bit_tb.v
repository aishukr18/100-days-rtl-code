module counter_asynch_4bit_tb();
reg clk;
reg reset;
wire [3:0] q;

counter_asynch_4bit uut (
    .clk(clk),
    .reset(reset),
    .q(q)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reset = 1; 
    #10;
    reset = 0;

    // Run the counter for some time
    #200;
    
    // Apply reset again in between
    reset = 1;
    #10;
    reset = 0;

    #100;

    $finish;
end

// Monitor the outputs
initial begin
    $monitor("Time=%0t | Reset=%b | Counter=%b", $time, reset, q);
end

endmodule
