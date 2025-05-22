module d_from_t_tb;

    reg clk;
    reg reset;
    reg D;
    wire Q;

    d_from_t dut (.clk(clk),.reset(reset),.D(D),.Q(Q));

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        D = 0;

        // Apply reset
        #10;
        reset = 0;

        // Test 1: Set D = 1, expect Q = 1 after rising edge
        #10; D = 1;
        #10;

        // Test 2: Hold D = 1, expect Q = 1 (no toggle)
        #10; D = 1;
        #10;

        // Test 3: Set D = 0, expect Q = 0
        #10; D = 0;
        #10;

        // Test 4: Hold D = 0, expect Q = 0
        #10; D = 0;
        #10;

        // Test 5: Toggle D a few times
        #10; D = 1;
        #10; D = 0;
        #10; D = 1;
        #10; D = 0;

        $finish;
    end

    // Print wave info to console
    initial begin
        $display("Time\tclk\treset\tD\tQ");
        $monitor("%g\t%b\t%b\t%b\t%b", $time, clk, reset, D, Q);
    end

    
endmodule
