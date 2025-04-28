module bidir_shift_reg_tb();
reg clk, reset, load, shift_dir;
reg [3:0] data_in;
wire [3:0] data_out;

bidir_shift_reg uut (.clk(clk),.reset(reset),.load(load),.shift_dir(shift_dir),
                     .data_in(data_in),.data_out(data_out));

always #5 clk = ~clk;
initial begin
    clk = 0; reset = 1; load = 0; shift_dir = 0; data_in = 4'b0000;
    #10 reset = 0;

    // Load data
    #10 load = 1; data_in = 4'b1010;
    #10 load = 0;

    // Shift right
    shift_dir = 0;
    #20;

    // Shift left
    shift_dir = 1;
    #20;

    $stop;
end
endmodule
