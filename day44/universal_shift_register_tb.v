module universal_shift_reg_tb();
    reg clk;
    reg reset;
    reg [1:0] mode;
    reg [3:0] data_in;
    reg serial_in_left;
    reg serial_in_right;
    wire [3:0] data_out;

    universal_shift_reg dut (
        .clk(clk),
        .reset(reset),
        .mode(mode),
        .data_in(data_in),
        .serial_in_left(serial_in_left),
        .serial_in_right(serial_in_right),
        .data_out(data_out)
    );
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        mode = 2'b00;
        data_in = 4'b0000;
        serial_in_left = 0;
        serial_in_right = 0;

        // Release reset
        #10;
        reset = 0;

        // Parallel load 1010
        #10;
        data_in = 4'b1010;
        mode = 2'b11;  // Parallel load

        #10;
        mode = 2'b00;  // Hold
        #10;

        // Shift right (insert 1 on left)
        serial_in_right = 1;
        mode = 2'b01;
        #10;
        mode = 2'b01;
        #10;

        // Shift left (insert 0 on right)
        serial_in_left = 0;
        mode = 2'b10;
        #10;
        mode = 2'b10;
        #10;

        // Hold
        mode = 2'b00;
        #10;

        $finish;
    end

endmodule
