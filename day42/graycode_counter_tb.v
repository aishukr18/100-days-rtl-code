module graycode_counter_tb();
    reg clk;
    reg reset;
    reg enable;
    wire [3:0] gray; 
    graycode_counter uut (.clk(clk),.reset(reset),.enable(enable),.gray(gray));
    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        reset = 1;
        enable = 0;
        // Hold reset high for a few cycles
        #20;
        reset = 0;
        // Enable counting
        enable = 1;
        #160; // Allow for 16 clock cycles
        // Disable counting
        enable = 0;
        #20;
        // Re-enable counting again
        enable = 1;
        #40;
        $stop;
    end
    // Monitor changes
    initial begin
        $display("Time\tReset\tEnable\tGray");
        $monitor("%0t\t%b\t%b\t%04b", $time, reset, enable, gray);
    end
endmodule
