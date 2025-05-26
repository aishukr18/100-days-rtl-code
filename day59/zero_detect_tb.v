module zero_detect_tb();
    reg  [7:0] data_in;
    wire  is_nonzero;
    zero_detect dut (.data_in(data_in),.is_nonzero(is_nonzero));
    initial begin
        $display("Time\tdata_in\tis_nonzero");
        $monitor("%0t\t%b\t%b", $time, data_in, is_nonzero);

        data_in = 8'b00000000; #10;  // Expected: 0
        data_in = 8'b00000001; #10;  // Expected: 1
        data_in = 8'b10101010; #10;  // Expected: 1
        data_in = 8'b00010000; #10;  // Expected: 1
        data_in = 8'b11111111; #10;  // Expected: 1
        $finish;
    end
endmodule
