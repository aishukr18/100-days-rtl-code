module dutycycle_75_tb();
    reg clk;
    reg rst_n;
    wire out;
    dutycycle_75 uut (.clk(clk),.rst_n(rst_n),.out(out));
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        rst_n = 0;
        #20;
        rst_n = 1;  // Release reset

        #200;

        $finish;
    end

    initial begin
        $monitor("Time = %0t | clk = %b | rst_n = %b | out = %b", 
                 $time, clk, rst_n, out);
    end

endmodule
