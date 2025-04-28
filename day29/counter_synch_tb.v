module counter_synch_tb();
    reg clk;
    reg rst;
    reg enable;
    wire [3:0] count;
    counter_synch uut (.clk(clk),.rst(rst),.enable(enable),.count(count));
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end
    initial begin
        rst = 1;
        enable = 0;
        #10;
        rst = 0;
        enable = 1;
        #150;
        //disable
        enable = 0;
        #20;
        enable = 1;
        #30;
        $finish;
    end
    initial begin
        $monitor("Time = %0t | rst = %b | enable = %b | count = %b", $time, rst, enable, count);
    end
endmodule
