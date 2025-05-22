module multiplier_4x4(

    input  [3:0] A,     // 4-bit multiplicand
    input  [3:0] B,     // 4-bit multiplier
    output [7:0] P      // 8-bit product
);

    wire [7:0] pp0, pp1, pp2, pp3;  // Partial products
    wire [7:0] sum1, sum2;
    wire [7:0] carry1, carry2;

    // Partial Products (ANDing each bit of B with A)
    assign pp0 = {4'b0000, (A & {4{B[0]}})};                 // A * B[0]
    assign pp1 = {3'b000,  (A & {4{B[1]}}), 1'b0};           // A * B[1] << 1
    assign pp2 = {2'b00,   (A & {4{B[2]}}), 2'b00};          // A * B[2] << 2
    assign pp3 = {1'b0,    (A & {4{B[3]}}), 3'b000};         // A * B[3] << 3

    // Add partial products
    assign sum1 = pp0 + pp1;
    assign sum2 = sum1 + pp2;
    assign P    = sum2 + pp3;

endmodule
