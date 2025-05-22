module dutycycle_50_tb();
    reg clk;
    reg reset;
    wire clk_out;

    dutycycle_50 #(.DIVISOR(10)) dut (.clk(clk),.reset(reset),.clk_out(clk_out));

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        #15;
        reset = 0;

        // Run simulation for enough cycles to see a few output toggles
        #200;

        $finish;
    end

    initial begin
        $display("Time\tclk\treset\tclk_out");
        $monitor("%g\t%b\t%b\t%b", $time, clk, reset, clk_out);
    end

endmodule
