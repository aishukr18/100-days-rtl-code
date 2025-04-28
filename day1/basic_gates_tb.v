module basic_gates_tb();
    reg a, b;
    wire y_and, y_or, y_not_a, y_nand, y_nor, y_xor, y_xnor;

    // Instantiate the basic_gates module
    basic_gates uut (
        .a(a),
        .b(b),
        .y_and(y_and),
        .y_or(y_or),
        .y_not_a(y_not_a),
        .y_nand(y_nand),
        .y_nor(y_nor),
        .y_xor(y_xor),
        .y_xnor(y_xnor)
    );

    initial begin
        $monitor("Time=%0t a=%b b=%b and=%b or=%b not_a=%b nand=%b nor=%b xor=%b xnor=%b", 
                  $time, a, b, y_and, y_or, y_not_a, y_nand, y_nor, y_xor, y_xnor);
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        $finish;
    end
endmodule
