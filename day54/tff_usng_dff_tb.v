module tff_using_dff_tb();
    reg clk;
    reg rst_n;
    reg T;
    wire Q;

    tff_using_dff dut (.clk(clk),.rst_n(rst_n),.T(T),.Q(Q));

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        rst_n = 0;
        T = 0;

        #12;
        rst_n = 1;
        
        #10 T = 0;  // No toggle, Q stays the same
        #10 T = 1;  // Toggle
        #10 T = 1;  // Toggle again
        #10 T = 0;  // No toggle
        #10 T = 1;  // Toggle
        #10 T = 0;
        #10 T = 1;

        #20 $finish;
    end
endmodule
