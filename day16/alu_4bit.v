module alu_4bit(
    input [3:0] a,
    input [3:0] b,
    input [2:0] sel,
    output reg [4:0] result,
    output reg zero
);

always @(*) begin
    case (sel)
        3'b000: result = a + b;      // addition
        3'b001: result = a - b;      // subtraction
        3'b010: result = a & b;      // and
        3'b011: result = a | b;      // or
        3'b100: result = a ^ b;      // xor
        3'b101: result = ~a;         // not a
        3'b110: result = a + 1;      // increment a
        3'b111: result = a - 1;      // decrement a
        default: result = 5'b00000;  // default to 0
    endcase

    zero = (result == 5'b00000);     // zero flag
end
endmodule
