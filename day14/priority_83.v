module priority8_3( output reg [2:0] dout, input [7:0] din );

always @(*) begin
    casex (din)
        8'b1xxxxxxx: dout = 3'b111;
        8'b01xxxxxx: dout = 3'b110;
        8'b001xxxxx: dout = 3'b101;
        8'b0001xxxx: dout = 3'b100;
        8'b00001xxx: dout = 3'b011;
        8'b000001xx: dout = 3'b010;
        8'b0000001x: dout = 3'b001;
        8'b00000001: dout = 3'b000;
        default:     dout = 3'b000;
    endcase
end

endmodule
