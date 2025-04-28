module decoder_24_tb();
    reg [1:0] d;
    reg enable;
    wire [3:0] y;

    decoder_24 dut (d, enable, y);

    initial begin
        enable = 1'b0;
        #10;
        enable = 1'b1;
        d = 2'b00; #10;
        d = 2'b01; #10;
        d = 2'b10; #10;
        d = 2'b11; #10;
        $finish;
    end
endmodule
