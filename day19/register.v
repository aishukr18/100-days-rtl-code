module register(
    input clk, rst, en,
    input [7:0] D,
    output reg [7:0] Q
);

always @(posedge clk or posedge rst) begin
    if (rst)
        Q <= 8'b0;
    else if (en)
        Q <= D;
end

endmodule
