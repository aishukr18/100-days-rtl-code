module JK_flipflop_using_SR_tb();
    reg clk;
    reg rst;
    reg J;
    reg K;
    wire Q;

    JK_flipflop_using_SR uut (.clk(clk),.rst(rst),.J(J),.K(K),.Q(Q));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1; J = 0; K = 0;
        #10;

        // Release reset
        rst = 0; #10;

        // 1. Hold (J=0, K=0)
        J = 0; K = 0; #10;

        // 2. Set (J=1, K=0)
        J = 1; K = 0; #10;

        // 3. Hold again
        J = 0; K = 0; #10;

        // 4. Reset (J=0, K=1)
        J = 0; K = 1; #10;

        // 5. Toggle (J=1, K=1)
        J = 1; K = 1; #10;

        // 6. Toggle again
        J = 1; K = 1; #10;

        // 7. Hold (J=0, K=0)
        J = 0; K = 0; #10;

        // 8. Reset system again
        rst = 1; #10;
        rst = 0; #10;

        // 9. Final toggle
        J = 1; K = 1; #10;

        // End simulation
        $finish;
    end
endmodule
