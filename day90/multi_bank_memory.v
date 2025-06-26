module multi_bank_memory #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4,
    parameter NUM_BANKS  = 4
)(
    input  wire                     clk,
    input  wire                     rst,       // Synchronous reset
    input  wire                     we,        // Write enable
    input  wire [ADDR_WIDTH-1:0]    addr,      // Address within bank
    input  wire [DATA_WIDTH-1:0]    din,       // Data input
    input  wire [$clog2(NUM_BANKS)-1:0] bank_sel, // Bank select
    output reg  [DATA_WIDTH-1:0]    dout       // Data output
);

    reg [DATA_WIDTH-1:0] mem [NUM_BANKS-1:0][2**ADDR_WIDTH-1:0];

    integer i, j;
    initial begin
        dout = 0;
        for (i = 0; i < NUM_BANKS; i = i + 1) begin
            for (j = 0; j < 2**ADDR_WIDTH; j = j + 1) begin
                mem[i][j] = 0;
            end
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            dout <= 0;
        end else begin
            if (we) begin
                mem[bank_sel][addr] <= din;
                dout <= din;  // Immediate update to dout to avoid read-after-write hazard
            end else begin
                dout <= mem[bank_sel][addr];
            end
        end
    end

endmodule
