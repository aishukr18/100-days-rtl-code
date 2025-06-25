module hamming_encoder (
    input [3:0] data_in,
    output [6:0] encoded_data
);
    assign encoded_data[0] = data_in[0] ^ data_in[1] ^ data_in[3]; // p1
    assign encoded_data[1] = data_in[0] ^ data_in[2] ^ data_in[3]; // p2
    assign encoded_data[2] = data_in[0];                          // d1
    assign encoded_data[3] = data_in[1] ^ data_in[2] ^ data_in[3]; // p4
    assign encoded_data[4] = data_in[1];                          // d2
    assign encoded_data[5] = data_in[2];                          // d3
    assign encoded_data[6] = data_in[3];                          // d4
endmodule

// Hamming Decoder (7,4)
module hamming_decoder (
    input [6:0] encoded_data,
    output reg [3:0] data_out,
    output reg error_detected
);
    wire [2:0] syndrome;
    reg [6:0] corrected_data;

    // Syndrome calculation
    assign syndrome[0] = encoded_data[0] ^ encoded_data[2] ^ encoded_data[4] ^ encoded_data[6]; // p1 check
    assign syndrome[1] = encoded_data[1] ^ encoded_data[2] ^ encoded_data[5] ^ encoded_data[6]; // p2 check
    assign syndrome[2] = encoded_data[3] ^ encoded_data[4] ^ encoded_data[5] ^ encoded_data[6]; // p4 check

    always @(*) begin
        error_detected = (syndrome != 3'b000);
        corrected_data = encoded_data;

        if (error_detected)
            corrected_data[syndrome - 1] = ~corrected_data[syndrome - 1]; // Flip the faulty bit

        data_out = {corrected_data[6], corrected_data[5], corrected_data[4], corrected_data[2]};
    end
endmodule
