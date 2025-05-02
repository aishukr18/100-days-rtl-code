module johnson_counter_tb();
    reg clk;
    reg rst;
    wire [3:0] q;
    johnson_counter dut (.clk(clk),.rst(rst),.q(q));
    always #5 clk = ~clk; // 10 ns clock period
    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0; 
        #200 $finish; // Run long enough to see full sequence
    end

    initial begin
        $monitor("Time=%0t | q=%b", $time, q);
    end
endmodule
