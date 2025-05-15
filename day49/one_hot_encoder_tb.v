module one_hot_encoder_tb();

    reg  [2:0] bin_in;            // Input to decoder
    wire [7:0] one_hot_out;       // Output from decoder, input to encoder
    wire [2:0] bin_out;           // Output from encoder

    // Instantiate the decoder
    one_hot_decoder uut_decoder (
        .bin_in(bin_in),
        .one_hot(one_hot_out)
    );

    // Instantiate the encoder
    one_hot_encoder uut_encoder (
        .one_hot_in(one_hot_out),
        .bin_out(bin_out)
    );

    initial begin
        $display("Time\tbin_in\t\tone_hot_out\tbin_out");
        $monitor("%0t\t%03b\t\t%b\t%03b", $time, bin_in, one_hot_out, bin_out);

        // Test all possible 3-bit binary inputs
        bin_in = 3'b000; #10;
        bin_in = 3'b001; #10;
        bin_in = 3'b010; #10;
        bin_in = 3'b011; #10;
        bin_in = 3'b100; #10;
        bin_in = 3'b101; #10;
        bin_in = 3'b110; #10;
        bin_in = 3'b111; #10;

        $finish;
    end

endmodule
