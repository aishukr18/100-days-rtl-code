module glitch_free_clock_enable_tb();

    reg clk;
    reg reset;
    reg enable;
    reg [3:0] d;
    wire [3:0] q;

    glitch_free_clock_enable dut (.clk(clk),.reset(reset),.enable(enable),.d(d),.q(q));

    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        enable = 0;
        d = 4'b0000;

        // Hold reset for 2 cycles
        #10 reset = 0;

        // Apply some data with enable = 0 (should NOT update q)
        d = 4'b1010;
        enable = 0;
        #10;

        // Enable is high — q should update to 1010
        enable = 1;
        #10;

        // Change input again — should update to 1100
        d = 4'b1100;
        #10;

        // Disable enable — q should stay 1100
        enable = 0;
        d = 4'b1111;
        #10;

        // Apply reset — q should go to 0000
        reset = 1;
        #10 reset = 0;

        // Final check
        d = 4'b0101;
        enable = 1;
        #10;

        $stop;
    end

endmodule
