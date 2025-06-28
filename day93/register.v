module Dual_port_register_file (
    input clk,
    input reset,
    input we,
    input [4:0] ra1, ra2,       // Read addresses
    input [4:0] wa,             // Write address
    input [31:0] wd,            // Write data
    output [31:0] rd1, rd2      // Read data outputs
);
    reg [31:0] regs [31:0];     // 32 registers of 32-bit width
    integer i;

    // Asynchronous reads
    assign rd1 = regs[ra1];
    assign rd2 = regs[ra2];

    // Synchronous write and reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                regs[i] <= 32'b0;
        end else if (we && wa != 5'd0) begin
            // Protect register 0 (optional: RISC-V behavior)
            regs[wa] <= wd;
        end
    end

endmodule
