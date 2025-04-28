module register_tb();
    reg clk;
    reg rst;
    reg en;
    reg [7:0] D;
    wire [7:0] Q;

    register uut (.clk(clk), .rst(rst), .en(en), .D(D), .Q(Q));

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        en = 0;
        D = 8'b10000000;
        
        // Apply reset
        rst = 1;
        #10 rst = 0;
        
        // Try to load data without enabling
        D = 8'b01010101;
        #10;
        
        // Enable and load data
        en = 1;
        #10;
        
        // Change data and check if it loads again
        D = 8'b11110000;
        #10;
        
        // Disable enable and change data again (should not load)
        en = 0;
        D = 8'b00001111;
        #10;
        
        // Enable again
        en = 1;
        #10;
        
        // Apply reset again
        rst = 1;
        #10;
        
        $finish;
    end
endmodule
