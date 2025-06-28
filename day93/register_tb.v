module Dual_port_register_file_tb;

    reg clk;
    reg reset;
    reg we;
    reg [4:0] ra1, ra2, wa;
    reg [31:0] wd;
    wire [31:0] rd1, rd2;

    Dual_port_register_file uut (
        .clk(clk),
        .reset(reset),
        .we(we),
        .ra1(ra1),
        .ra2(ra2),
        .wa(wa),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2)
    );

    always #5 clk = ~clk;

    initial begin

        $display("Time | we wa wd           | ra1 rd1         | ra2 rd2");
        $monitor("%4t | %b  %02d %h | %02d  %h | %02d  %h",
                  $time, we, wa, wd, ra1, rd1, ra2, rd2);

        clk = 0;
        reset = 1;
        we = 0;
        wa = 0;
        wd = 0;
        ra1 = 0;
        ra2 = 0;

        #12 reset = 0;

        // === Write and read from several registers ===
        // Write to reg[1]
        #10 we = 1; wa = 5'd1; wd = 32'hDEADBEEF;
        // Write to reg[2]
        #10 wa = 5'd2; wd = 32'hCAFEBABE;
        // Write to reg[5]
        #10 wa = 5'd5; wd = 32'hFACEFACE;
        #10 we = 0;

        // Read reg[1] and reg[5]
        #10 ra1 = 5'd1; ra2 = 5'd5;

        // === Test read from written + unwritten reg ===
        #10 ra1 = 5'd2; ra2 = 5'd10; // reg[10] not written, should be 0

        // === Overwrite reg[1] and re-read ===
        #10 we = 1; wa = 5'd1; wd = 32'h11111111;
        #10 we = 0; ra1 = 5'd1;

        // === Test reg[0] write protection ===
        #10 we = 1; wa = 5'd0; wd = 32'hFFFFFFFF;
        #10 we = 0; ra1 = 5'd0; // Should still read 0

        // === Access high-numbered registers ===
        #10 we = 1; wa = 5'd31; wd = 32'hABCD1234;
        #10 wa = 5'd28; wd = 32'h12345678;
        #10 we = 0; ra1 = 5'd31; ra2 = 5'd28;

        // === Final Read Check ===
        #10 ra1 = 5'd5; ra2 = 5'd2;

        #20 $finish;
    end

endmodule
