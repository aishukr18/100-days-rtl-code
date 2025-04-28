module counter_asynch_4bit(
    input clk,
    input reset,
    output [3:0] q
);
reg [3:0] q_reg;
always @(posedge clk or posedge reset) begin
    if (reset)
        q_reg[0] <= 0;
    else
        q_reg[0] <= ~q_reg[0]; // Toggle on every clock
end

always @(negedge q_reg[0] or posedge reset) begin
    if (reset)
        q_reg[1] <= 0;
    else
        q_reg[1] <= ~q_reg[1];
end

always @(negedge q_reg[1] or posedge reset) begin
    if (reset)
        q_reg[2] <= 0;
    else
        q_reg[2] <= ~q_reg[2];
end

always @(negedge q_reg[2] or posedge reset) begin
    if (reset)
        q_reg[3] <= 0;
    else
        q_reg[3] <= ~q_reg[3];
end

assign q = q_reg;

endmodule
