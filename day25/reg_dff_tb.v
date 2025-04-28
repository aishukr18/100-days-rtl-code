module reg_dff_tb();
    reg clk, rst;
    reg [3:0] d;
    wire [3:0] q;
    reg_dff uut (.clk(clk),.rst(rst),.d(d),.q(q));
    initial begin
        clk = 0;
    end
    always #5 clk = ~clk;
    initial begin

        rst = 1;   d = 4'b0000; #10;

        rst = 0;   d = 4'b1010; #10;
                   d = 4'b1100; #10;
                   d = 4'b1111; #10;
        
        rst = 1; #10;

        rst = 0;    d = 4'b0011; #10;

        $finish;
    end

endmodule
