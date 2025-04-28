module sub_4bit(input [3:0] a, b, input cin, output [3:0] s, output carry);

wire c0, c1, c2;
wire w0, w1, w2, w3;

xor x0(w0, cin, b[0]);
xor x1(w1, cin, b[1]);
xor x2(w2, cin, b[2]);
xor x3(w3, cin, b[3]);

full_adder fa1 (.a(a[0]), .b(w0), .c(cin), .s(s[0]), .cout(c0));
full_adder fa2 (.a(a[1]), .b(w1), .c(c0), .s(s[1]), .cout(c1));
full_adder fa3 (.a(a[2]), .b(w2), .c(c1), .s(s[2]), .cout(c2));
full_adder fa4 (.a(a[3]), .b(w3), .c(c2), .s(s[3]), .cout(carry));

endmodule
