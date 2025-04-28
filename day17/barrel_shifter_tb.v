module barrel_shifter_tb();
    reg [3:0] data_in;
    reg [1:0] shift_amt;
    reg [1:0] shift_type;
    wire [3:0] data_out;

    barrel_shifter uut (.data_in(data_in), .shift_amt(shift_amt), .shift_type(shift_type), .data_out(data_out));

    initial begin
        data_in = 4'b1011; shift_amt = 2'b01; shift_type = 2'b00; #10; // Logical Shift Left
        data_in = 4'b1011; shift_amt = 2'b01; shift_type = 2'b01; #10; // Logical Shift Right
        data_in = 4'b1011; shift_amt = 2'b01; shift_type = 2'b10; #10; // Rotate Left
        data_in = 4'b1011; shift_amt = 2'b01; shift_type = 2'b11; #10; // Rotate Right
        data_in = 4'b1100; shift_amt = 2'b10; shift_type = 2'b00; #10; // Shift Left by 2
        data_in = 4'b1001; shift_amt = 2'b10; shift_type = 2'b11; #10; // Rotate Right by 2

        $finish;
    end
endmodule
