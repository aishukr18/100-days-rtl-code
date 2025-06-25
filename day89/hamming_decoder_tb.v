module tb_hamming_code;
    reg [3:0] data_in;
    wire [6:0] encoded_data;
    reg [6:0] faulty_data;
    wire [3:0] decoded_data;
    wire error_detected;

    // Instantiate encoder and decoder
    hamming_encoder encoder (
        .data_in(data_in),
        .encoded_data(encoded_data)
    );

    hamming_decoder decoder (
        .encoded_data(faulty_data),
        .data_out(decoded_data),
        .error_detected(error_detected)
    );

    integer i, err_bit;
    reg [3:0] input_patterns [0:7];

    initial begin
        // ✅ Initialize err_bit to avoid 'X'
        err_bit = 0;

        // Define different input data patterns
        input_patterns[0] = 4'b0000;
        input_patterns[1] = 4'b0001;
        input_patterns[2] = 4'b0011;
        input_patterns[3] = 4'b0101;
        input_patterns[4] = 4'b1001;
        input_patterns[5] = 4'b1111;
        input_patterns[6] = 4'b1010;
        input_patterns[7] = 4'b1100;


        $display("------ No Error Cases ------");
        for (i = 0; i < 8; i = i + 1) begin
            data_in = input_patterns[i]; #10;
            faulty_data = encoded_data; #10;
            $display("Data In: %b | Encoded: %b | Decoded: %b | Error Detected: %b",
                     data_in, faulty_data, decoded_data, error_detected);
        end

        $display("\n------ Error Injection Cases ------");
        for (i = 0; i < 7; i = i + 1) begin
            data_in = 4'b1010; #10;
            faulty_data = encoded_data;

            err_bit = i; // ✅ assign bit index for error
            faulty_data[err_bit] = ~faulty_data[err_bit]; #10;

            $display("Injected Error at Bit %0d -> Faulty: %b | Decoded: %b | Error Detected: %b",
                     err_bit, faulty_data, decoded_data, error_detected);
        end

        $finish;
    end
endmodule
