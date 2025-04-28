module full_adder(input a, b, c, output s, cout);

    assign s = a ^ b ^ c;
    assign cout = (a & b) | (b & c) | (a & c);

endmodule
