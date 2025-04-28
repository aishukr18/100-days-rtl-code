`timescale 1ns / 1ps

module tb_mux4to1;
    reg [3:0] in;
    reg [1:0] sel;
    wire out;

    mux4to1 uut (.in(in), .sel(sel), .out(out));

    initial begin
        $monitor("Time=%0t | sel=%b | in=%b | out=%b", $time, sel, in, out);

        in = 4'b1110;
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;

        $stop;
    end
endmodule
