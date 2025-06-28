module async_fifo_tb;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4; // FIFO depth = 16

    reg wr_clk, rd_clk, rst;
    reg wr_en, rd_en;
    reg [DATA_WIDTH-1:0] din;
    wire [DATA_WIDTH-1:0] dout;
    wire full, empty;

    // Instantiate DUT
    async_fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) fifo_inst (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    // Asynchronous clocks
    always #5 wr_clk = ~wr_clk;  // 100 MHz
    always #7 rd_clk = ~rd_clk;  // ~71 MHz

    initial begin
        $dumpfile("fifo_wave.vcd");
        $dumpvars(0, async_fifo_tb);

        // Initial state
        wr_clk = 0;
        rd_clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        din = 0;

        // Reset
        #20 rst = 0;

        // === WRITE 4 DATA ===
        repeat (4) begin
            @(posedge wr_clk);
            wr_en = 1;
            din = din + 8'h11;  // Incrementing pattern: 11, 22, 33, 44
        end
        @(posedge wr_clk);
        wr_en = 0;

        // Wait a bit
        #30;

        // === READ 4 DATA ===
        repeat (4) begin
            @(posedge rd_clk);
            rd_en = 1;
            @(posedge rd_clk);
            rd_en = 0;
        end

        // End simulation
        #40 $finish;
    end

endmodule
