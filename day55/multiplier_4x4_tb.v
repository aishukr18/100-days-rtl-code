module multiplier_4x4_tb();

    reg  [3:0] A, B;
    wire [7:0] P;

    multiplier_4x4 uut (.A(A),.B(B),.P(P));

    initial begin
        // Test case 1: 3 x 2 = 6
        A = 4'd3; B = 4'd2;
        #5;
        $display("A=%d, B=%d, P=%d (Expected=6)", A, B, P);

        // Test case 2: 5 x 5 = 25
        A = 4'd5; B = 4'd5;
        #5;
        $display("A=%d, B=%d, P=%d (Expected=25)", A, B, P);

        // Test case 3: 15 x 15 = 225
        A = 4'd15; B = 4'd15;
        #5;
        $display("A=%d, B=%d, P=%d (Expected=225)", A, B, P);

        // Test case 4: 0 x 10 = 0
        A = 4'd0; B = 4'd10;
        #5;
        $display("A=%d, B=%d, P=%d (Expected=0)", A, B, P);

        // Test case 5: 7 x 1 = 7
        A = 4'd7; B = 4'd1;
        #5;
        $display("A=%d, B=%d, P=%d (Expected=7)", A, B, P);

        $finish;
    end

endmodule
