module parity_checker(
    input [3:0] data_in,
    input parity_bit,
    output error
);

// If XOR of all bits including parity bit is 0, no error (even parity)
assign error = data_in[0] ^ data_in[1] ^ data_in[2] ^ data_in[3] ^ parity_bit;

endmodule
