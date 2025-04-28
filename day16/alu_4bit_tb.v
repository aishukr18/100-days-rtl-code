module alu_4bit_tb();
    reg [3:0] a;
    reg [3:0] b;
    reg [2:0] sel;
    wire [4:0] result;
    wire zero;

    alu_4bit uut (.a(a), .b(b), .sel(sel), .result(result), .zero(zero));

    initial begin
        $display("time\ta\tb\tsel\tresult\tzero");
        $monitor("%g\t%b\t%b\t%b\t%b\t%b", $time, a, b, sel, result, zero);

        a = 4'b0011; b = 4'b0101; sel = 3'b000;  // addition 3 + 5 = 8
        #10;
        a = 4'b0110; b = 4'b0011; sel = 3'b001;  // subtraction 6 - 3 = 3
        #10;
        a = 4'b1010; b = 4'b1100; sel = 3'b010;  // AND 1010 & 1100 = 1000
        #10;
        a = 4'b1010; b = 4'b1100; sel = 3'b011;  // OR 1010 | 1100 = 1110
        #10;
        a = 4'b1010; b = 4'b1100; sel = 3'b100;  // XOR 1010 ^ 1100 = 0110
        #10;
        a = 4'b0111; b = 4'b0000; sel = 3'b101;  // NOT A 0111 -> 10000
        #10;
        a = 4'b1111; b = 4'b0000; sel = 3'b110;  // increment A 1111 + 1 = 10000
        #10;
        a = 4'b0001; b = 4'b0000; sel = 3'b111;  // decrement A 0001 - 1 = 00000
        #10;
        a = 4'b0000; b = 4'b0000; sel = 3'bzzz;  // default case
        #10;

        $finish;
    end
endmodule
