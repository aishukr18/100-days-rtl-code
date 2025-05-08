module clk_gated_counter_tb();
    reg clk;
    reg reset;
    reg enable;
    wire [3:0] count;

    clk_gated_counter dut (.clk(clk),.reset(reset),.enable(enable),.count(count));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1;
        enable = 0;

        // Wait a few clock cycles
        #20;

        // De-assert reset
        reset = 0;

        // Enable counting
        enable = 1;
        #50;  // Allow counter to increment

        // Disable counting
        enable = 0;
        #30;

        // Re-enable counting
        enable = 1;
        #40;
        $stop;
    end

endmodule
