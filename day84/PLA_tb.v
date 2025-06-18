module PLA_tb;

reg A, B, C, D;
wire F1, F2, F3, F4;

PLA uut (
    .A(A), .B(B), .C(C), .D(D),
    .F1(F1), .F2(F2), .F3(F3), .F4(F4)
);

initial begin

    // Group 1: A=1, B=1 --> F1 should be 1
    {A, B, C, D} = 4'b1100; #10; // F1=1
    {A, B, C, D} = 4'b1101; #10;
    {A, B, C, D} = 4'b1110; #10;
    {A, B, C, D} = 4'b1111; #10;

    // Group 2: A=1, B=0 --> F2 should be 1
    {A, B, C, D} = 4'b1000; #10; // F2=1
    {A, B, C, D} = 4'b1001; #10;
    {A, B, C, D} = 4'b1010; #10;
    {A, B, C, D} = 4'b1011; #10;

    // Group 3: A=0, B=1 --> F3 should be 1
    {A, B, C, D} = 4'b0100; #10; // F3=1
    {A, B, C, D} = 4'b0101; #10;
    {A, B, C, D} = 4'b0110; #10;
    {A, B, C, D} = 4'b0111; #10;

    // Group 4: A=0, B=0 --> F4 should be 1
    {A, B, C, D} = 4'b0000; #10; // F4=1
    {A, B, C, D} = 4'b0001; #10;
    {A, B, C, D} = 4'b0010; #10;
    {A, B, C, D} = 4'b0011; #10;

    // Optional: few random tests for variety
    {A, B, C, D} = 4'b0111; #10;
    {A, B, C, D} = 4'b1010; #10;
    {A, B, C, D} = 4'b1111; #10;
    {A, B, C, D} = 4'b0001; #10;

    #10 $finish;
end

initial begin
    $monitor("Time = %0t : A = %b, B = %b, C = %b, D = %b => F1 = %b, F2 = %b, F3 = %b, F4 = %b",
             $time, A, B, C, D, F1, F2, F3, F4);
end

endmodule
