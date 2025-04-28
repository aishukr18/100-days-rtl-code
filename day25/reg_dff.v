module reg_dff(
    input clk,
    input rst,
    input [3:0] d,
    output [3:0] q
);

    d_ff dff0 (.clk(clk), .rst(rst), .d(d[0]), .q(q[0]));
    d_ff dff1 (.clk(clk), .rst(rst), .d(d[1]), .q(q[1]));
    d_ff dff2 (.clk(clk), .rst(rst), .d(d[2]), .q(q[2]));
    d_ff dff3 (.clk(clk), .rst(rst), .d(d[3]), .q(q[3]));

endmodule
