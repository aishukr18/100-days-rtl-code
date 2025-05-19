module T_using_SR_tb();
    reg clk;
    reg rst;
    reg T;
    wire Q;

    T_using_SR uut (.clk(clk),.rst(rst),.T(T),.Q(Q));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize inputs
        rst = 1;
        T = 0;
        #10;

        // Release reset
        rst = 0;
        #10;

        // T = 0 (hold state)
        T = 0; #10;

        // T = 1 (toggle)
        T = 1; #10;

        // T = 1 (toggle)
        T = 1; #10;

        // T = 0 (hold)
        T = 0; #10;

        // T = 1 (toggle)
        T = 1; #10;

        // Apply synchronous reset again
        rst = 1; #10;
        rst = 0; #10;

        // More toggles
        T = 1; #10;
        T = 0; #10;
        T = 1; #10;

        // End simulation
        $finish;
    end

endmodule
