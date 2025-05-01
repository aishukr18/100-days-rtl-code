module freq_divide_by4_tb();
    reg clk;        
    reg rst;        
    wire out;
    freq_divide_by4 uut (.clk(clk),.rst(rst),.out(out));
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        rst = 1;
        #10 rst = 0;
        #1000;
        $finish;
    end
    initial begin
        $monitor("Time = %0t, clk = %b, rst = %b, out = %b", $time, clk, rst, out);
    end
endmodule
