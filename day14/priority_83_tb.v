module priority8_3_tb();
    reg [7:0] din;
    wire [2:0] dout;

    priority8_3 dut (.din(din), .dout(dout));

    initial begin
        $display("Time\t din           -> dout");
        $monitor("%0dns\t %b -> %b", $time, din, dout);

        // Test input with each bit set one at a time
        din = 8'b00000001; #10;
        din = 8'b00000010; #10;
        din = 8'b00000100; #10;
        din = 8'b00001000; #10;
        din = 8'b00010000; #10;
        din = 8'b00100000; #10;
        din = 8'b01000000; #10;
        din = 8'b10000000; #10;

        // Test multiple bits set (priority check)
        din = 8'b11000000; #10;
        din = 8'b00111100; #10;
        din = 8'b00000111; #10;
        din = 8'b00000000; #10;

        $finish;
    end
endmodule
