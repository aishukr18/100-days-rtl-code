module tb_page_mode_dram;

    reg clk;
    reg cs;
    reg we;
    reg [3:0] row;
    reg [3:0] col;
    reg [7:0] data_in;
    wire [7:0] data_out;

    page_mode_dram uut (
        .clk(clk),
        .cs(cs),
        .we(we),
        .row(row),
        .col(col),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $display("Starting Page Mode DRAM Testbench...");
        $dumpfile("page_mode_dram.vcd");
        $dumpvars(0, tb_page_mode_dram);

        clk = 0;
        cs = 0;
        we = 0;
        row = 0;
        col = 0;
        data_in = 0;

        // ---------- Test Case 1 ----------
        #10 cs = 1; we = 1; row = 4'd3; col = 4'd2; data_in = 8'hA5;
        @(posedge clk); #1;
        cs = 0;

        #10 cs = 1; we = 0; row = 4'd3; col = 4'd2;
        @(posedge clk); #1;
        cs = 0;
        #2;
        if (data_out != 8'hA5)
            $display("Test Case 1 FAILED: Expected A5, Got %h", data_out);
        else
            $display("Test Case 1 PASSED: Got %h", data_out);

        // ---------- Test Case 2 ----------
        #10 cs = 1; we = 1; row = 4'd5; col = 4'd10; data_in = 8'hB6;
        @(posedge clk); #1;
        cs = 0;

        #10 cs = 1; we = 0; row = 4'd5; col = 4'd10;
        @(posedge clk); #1;
        cs = 0;
        #2;
        if (data_out != 8'hB6)
            $display("Test Case 2 FAILED: Expected B6, Got %h", data_out);
        else
            $display("Test Case 2 PASSED: Got %h", data_out);

        // ---------- Test Case 3 ----------
        #10 cs = 1; we = 1; row = 4'd0; col = 4'd0; data_in = 8'hC7;
        @(posedge clk); #1;
        cs = 0;

        #10 cs = 1; we = 0; row = 4'd0; col = 4'd0;
        @(posedge clk); #1;
        cs = 0;
        #2;
        if (data_out != 8'hC7)
            $display("Test Case 3 FAILED: Expected C7, Got %h", data_out);
        else
            $display("Test Case 3 PASSED: Got %h", data_out);

        // ---------- Test Case 4 ----------
        #10 cs = 1; we = 1; row = 4'd15; col = 4'd15; data_in = 8'hD8;
        @(posedge clk); #1;
        cs = 0;

        #10 cs = 1; we = 0; row = 4'd15; col = 4'd15;
        @(posedge clk); #1;
        cs = 0;
        #2;
        if (data_out != 8'hD8)
            $display("Test Case 4 FAILED: Expected D8, Got %h", data_out);
        else
            $display("Test Case 4 PASSED: Got %h", data_out);

        // ---------- Test Case 5 ----------
        #10 cs = 1; we = 1; row = 4'd8; col = 4'd8; data_in = 8'hE9;
        @(posedge clk); #1;
        cs = 0;

        #10 cs = 1; we = 0; row = 4'd8; col = 4'd8;
        @(posedge clk); #1;
        cs = 0;
        #2;
        if (data_out != 8'hE9)
            $display("Test Case 5 FAILED: Expected E9, Got %h", data_out);
        else
            $display("Test Case 5 PASSED: Got %h", data_out);

        $display("All test cases completed.");
        $stop;
    end

endmodule
