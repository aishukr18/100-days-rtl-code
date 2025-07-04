module ROM_16x16 (
    input  [3:0] address,
    output reg [15:0] data
);

always @(*) begin
    case (address)
        4'd0:  data = 16'b0000000000000001;
        4'd1:  data = 16'b0000000000000010;
        4'd2:  data = 16'b0000000000000100;
        4'd3:  data = 16'b0000000000001000;
        4'd4:  data = 16'b0000000000010000;
        4'd5:  data = 16'b0000000000100000;
        4'd6:  data = 16'b0000000001000000;
        4'd7:  data = 16'b0000000010000000;
        4'd8:  data = 16'b0000000100000000;
        4'd9:  data = 16'b0000001000000000;
        4'd10: data = 16'b0000010000000000;
        4'd11: data = 16'b0000100000000000;
        4'd12: data = 16'b0001000000000000;
        4'd13: data = 16'b0010000000000000;
        4'd14: data = 16'b0100000000000000;
        4'd15: data = 16'b1000000000000000;
        default: data = 16'b0000000000000000;
    endcase
end

endmodule
