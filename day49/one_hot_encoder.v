module one_hot_decoder (
    input  [2:0] bin_in,     // 3-bit input
    output reg [7:0] one_hot // 8-bit one-hot output
);
    always @(*) begin
        one_hot = 8'b00000000; // default
        one_hot[bin_in] = 1'b1;
    end
endmodule


module one_hot_encoder(
    input  [7:0] one_hot_in,
    output reg [2:0] bin_out
);
    always @(*) begin
        case (one_hot_in)
            8'b00000001: bin_out = 3'b000;
            8'b00000010: bin_out = 3'b001;
            8'b00000100: bin_out = 3'b010;
            8'b00001000: bin_out = 3'b011;
            8'b00010000: bin_out = 3'b100;
            8'b00100000: bin_out = 3'b101;
            8'b01000000: bin_out = 3'b110;
            8'b10000000: bin_out = 3'b111;
            default:     bin_out = 3'bxxx; // invalid one-hot
        endcase
    end
endmodule
