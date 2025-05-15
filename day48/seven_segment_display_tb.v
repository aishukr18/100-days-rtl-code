module seven_segment_tb;

    reg [3:0] bin_in;
    wire [6:0] seg_out;

    // Instantiate the Unit Under Test (UUT)
    seven_segment dut (
        .bin_in(bin_in),
        .seg_out(seg_out)
    );

    initial begin
        $display("Time\tbin_in\tseg_out");
        $monitor("%0t\t%b\t%b", $time, bin_in, seg_out);

        // Apply all 4-bit binary inputs (0 to 15)
        bin_in = 4'b0000; #10;
        bin_in = 4'b0001; #10;
        bin_in = 4'b0010; #10;
        bin_in = 4'b0011; #10;
        bin_in = 4'b0100; #10;
        bin_in = 4'b0101; #10;
        bin_in = 4'b0110; #10;
        bin_in = 4'b0111; #10;
        bin_in = 4'b1000; #10;
        bin_in = 4'b1001; #10;
        bin_in = 4'b1010; #10;  // Invalid input
        bin_in = 4'b1011; #10;  // Invalid input
        bin_in = 4'b1100; #10;  // Invalid input
        bin_in = 4'b1101; #10;  // Invalid input
        bin_in = 4'b1110; #10;  // Invalid input
        bin_in = 4'b1111; #10;  // Invalid input

        $finish;
    end

endmodule
