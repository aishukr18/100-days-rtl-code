module comp_4bit_tb();
    reg [3:0] a, b;
    wire a_gt_b, a_eq_b, a_lt_b;

    comp_4bit uut (.a(a), .b(b), .a_gt_b(a_gt_b), .a_eq_b(a_eq_b), .a_lt_b(a_lt_b));

    initial begin
        $display("a\tb\ta_gt_b\ta_eq_b\ta_lt_b");
        $monitor("Time=%0t a=%b b=%b | a_gt_b=%b a_eq_b=%b a_lt_b=%b", 
                  $time, a, b, a_gt_b, a_eq_b, a_lt_b);
        
        a = 4'b1000; b = 4'b0100; #10;
        a = 4'b0010; b = 4'b0010; #10;
        a = 4'b0100; b = 4'b1000; #10;
        a = 4'b1000; b = 4'b1000; #10;

        $finish;
    end
endmodule
