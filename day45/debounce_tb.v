module debounce_tb();
    reg clk;
    reg rst;
    reg noisy_in;
    wire clean_out;

    debounce uut (.clk(clk),.rst(rst),.noisy_in(noisy_in),.clean_out(clean_out));

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        noisy_in = 0;

        // Reset pulse
        #20 rst = 0;

        // Simulate noisy button press (bouncing)
        #50 noisy_in = 1;
        #30 noisy_in = 0;
        #30 noisy_in = 1;
        #20 noisy_in = 0;
        #20 noisy_in = 1;  // real press begins
        #1000;            // hold high long enough to be debounced

        // Simulate button release with bounce
        #20 noisy_in = 0;
        #30 noisy_in = 1;
        #30 noisy_in = 0;
        #1000;            // hold low

        #50 $finish;
    end

endmodule
