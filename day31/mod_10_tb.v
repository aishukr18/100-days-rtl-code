module mod_10_tb();
reg clk;
reg reset;
wire [3:0] q;
mod_10 uut (.clk(clk),.reset(reset),.q(q));
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    reset = 1;
    #10;
    reset = 0;
    
    #200; 
    $stop;
end
endmodule
