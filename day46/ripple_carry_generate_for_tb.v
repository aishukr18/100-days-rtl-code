module fa_generate_for_tb();

reg [7:0] a, b;        // 8-bit inputs
reg cin;               // Carry-in input
wire [7:0] sum;        // 8-bit sum output
wire cout;             // Carry-out output

fa_generate_for #(.SIZE(8)) uut (.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));

initial begin
    a = 8'b00000000; 
    b = 8'b00000000;
    cin = 0;
    
    #10;
    $display("Test Case 1: a = %b, b = %b, cin = %b => sum = %b, cout = %b", a, b, cin, sum, cout);
    
    a = 8'b00001111;    // Test case 2: a = 15, b = 10, cin = 0
    b = 8'b00001010;
    cin = 0;
   
    #10;
    $display("Test Case 2: a = %b, b = %b, cin = %b => sum = %b, cout = %b", a, b, cin, sum, cout);
    

    a = 8'b11110000;    // Test case 3: a = 240, b = 1, cin = 1
    b = 8'b00000001;
    cin = 1;
    
   
    #10;
    $display("Test Case 3: a = %b, b = %b, cin = %b => sum = %b, cout = %b", a, b, cin, sum, cout);
    
    a = 8'b11111111;    // Test case 4: a = 255, b = 1, cin = 0
    b = 8'b00000001;
    cin = 0;

    #10;
    $display("Test Case 4: a = %b, b = %b, cin = %b => sum = %b, cout = %b", a, b, cin, sum, cout);

    a = 8'b11111111;    // Test case 5: a = 255, b = 255, cin = 1
    b = 8'b11111111;
    cin = 1;

    #10;
    $display("Test Case 5: a = %b, b = %b, cin = %b => sum = %b, cout = %b", a, b, cin, sum, cout);
   
    $finish;
end

endmodule
