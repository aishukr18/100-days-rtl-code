module barrel_shifter(
    input [3:0] data_in,
    input [1:0] shift_amt,      // 2-bit shift amount (0 to 3)
    input [1:0] shift_type,
    output reg [3:0] data_out
);

always @(*) begin
    case (shift_type)
        2'b00: data_out = data_in << shift_amt;                                // Logical Shift Left
        2'b01: data_out = data_in >> shift_amt;                                // Logical Shift Right
        2'b10: data_out = (data_in << shift_amt) | (data_in >> (4 - shift_amt)); // Rotate Left
        2'b11: data_out = (data_in >> shift_amt) | (data_in << (4 - shift_amt)); // Rotate Right
        default: data_out = data_in;
    endcase
end

endmodule
