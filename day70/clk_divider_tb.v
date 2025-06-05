module divider_tb;
    reg clk,reset;
    wire derv_clk;
    
    divider DUT(clk,reset,derv_clk);
    
    initial
        begin
            clk = 0;
            forever
            #2 clk = ~clk;
        end
    initial
        begin
            reset = 1;
            @(negedge clk);
            reset = 0;
            #100;
            $finish;
        end
endmodule
