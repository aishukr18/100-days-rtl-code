module basic_gates(input wire a, b,
                   output wire y_and, y_or, y_not_a, y_nand, y_nor, y_xor, y_xnor);

    assign y_and  = a & b;   // AND Gate
    assign y_or   = a | b;   // OR Gate
    assign y_not_a= ~a;      // NOT Gate
    assign y_nand = ~(a & b);// NAND Gate
    assign y_nor  = ~(a | b);// NOR Gate
    assign y_xor  = a ^ b;   // XOR Gate
    assign y_xnor = ~(a ^ b);// XNOR Gate

endmodule
