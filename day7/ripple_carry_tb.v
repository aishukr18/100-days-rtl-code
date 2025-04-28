module ripple_carry_tb();
    reg [3:0] a, b;
    reg cin;
    wire [3:0] s;
    wire carry;

    ripple_carry dut (a, b, cin, s, carry);

    initial begin
        $monitor("Time=%0t a=%b b=%b cin=%b | s=%b carry=%b", $time, a, b, cin, s, carry);

        a = 4'b0000; b = 4'b0000; cin = 0; #10;
        a = 4'b0001; b = 4'b0010; cin = 0; #10;
        a = 4'b0011; b = 4'b0011; cin = 0; #10;
        a = 4'b0111; b = 4'b0001; cin = 0; #10;
        a = 4'b1111; b = 4'b1111; cin = 1; #10;

        $finish;
    end
endmodule
