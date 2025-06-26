module tb_multi_bank_memory;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;
    parameter NUM_BANKS  = 4;

    reg clk;
    reg rst;
    reg we;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] din;
    reg [$clog2(NUM_BANKS)-1:0] bank_sel;
    wire [DATA_WIDTH-1:0] dout;

    multi_bank_memory #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .NUM_BANKS(NUM_BANKS)
    ) uut (
        .clk(clk),
        .rst(rst),
        .we(we),
        .addr(addr),
        .din(din),
        .bank_sel(bank_sel),
        .dout(dout)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        we = 0;
        addr = 0;
        din = 0;
        bank_sel = 0;

        #10 rst = 0;

        // Write to different banks at the same address
        repeat (NUM_BANKS) begin
            we = 1;
            addr = 4'hA;
            din = $random;
            bank_sel = bank_sel + 1;
            #10;
        end

        // Read from those same banks at addr A
        we = 0;
        bank_sel = 0;
        repeat (NUM_BANKS) begin
            addr = 4'hA;
            #10;
            bank_sel = bank_sel + 1;
        end

        // Write at lowest and highest addresses
        we = 1; addr = 4'h0; din = 8'h11; bank_sel = 0; #10;
        we = 1; addr = 4'hF; din = 8'hFF; bank_sel = 0; #10;

        // Read back from boundaries
        we = 0; addr = 4'h0; bank_sel = 0; #10;
        addr = 4'hF; #10;

        // Overwrite same location and verify update
        we = 1; addr = 4'h5; din = 8'hAA; bank_sel = 1; #10;
        we = 0; addr = 4'h5; bank_sel = 1; #10;
        we = 1; addr = 4'h5; din = 8'h55; bank_sel = 1; #10;
        we = 0; addr = 4'h5; bank_sel = 1; #10;

        // Repeated reads for stability
        addr = 4'h5; bank_sel = 1; #10;
        #10;
        #10;

        // Simultaneous writes to same address in different banks (should isolate)
        we = 1; addr = 4'h8;
        din = 8'hDE; bank_sel = 0; #10;
        din = 8'hAD; bank_sel = 1; #10;
        din = 8'hBE; bank_sel = 2; #10;
        din = 8'hEF; bank_sel = 3; #10;

        // Read back from all
        we = 0;
        bank_sel = 0; addr = 4'h8; #10;
        bank_sel = 1; #10;
        bank_sel = 2; #10;
        bank_sel = 3; #10;

        #20 $finish;
    end

    initial begin
        $monitor("Time = %0t | WE = %b | RST = %b | Bank = %0d | Addr = %h | Din = %h | Dout = %h",
                 $time, we, rst, bank_sel, addr, din, dout);
    end

endmodule
