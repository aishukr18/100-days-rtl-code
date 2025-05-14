module ring_counter_tb();
    reg clk, rst;
    wire [3:0] ring_out;

    ring_counter uut (.clk(clk),.rst(rst),.ring_out(ring_out));

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        rst = 1;
        #10 rst = 0;

        #100 $stop;
    end

    initial begin
        $monitor("Time: %0t | Ring Out = %b", $time, ring_out);
    end
endmodule
