module sub_4bit_tb();
    reg [3:0] a, b;
    reg cin;
    wire [3:0] s;
    wire carry;

    sub_4bit dut (.a(a), .b(b), .cin(cin), .s(s), .carry(carry));

    initial begin
        $monitor("value a=%b, b=%b, cin=%b, s=%b, carry=%b", a, b, cin, s, carry);
        cin = 1'b1;

        a = 4'b0000; b = 4'b0000; #10;
        a = 4'b0001; b = 4'b0010; #10;
        a = 4'b0010; b = 4'b0011; #10;
        a = 4'b0110; b = 4'b0010; #10;
        a = 4'b0111; b = 4'b0001; #10;
        a = 4'b1100; b = 4'b0001; #10;
        a = 4'b1110; b = 4'b0001; #10;
        a = 4'b1101; b = 4'b0010; #10;
        a = 4'b1111; b = 4'b1000; #10;

        $stop;
    end
endmodule
