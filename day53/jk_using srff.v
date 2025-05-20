module JK_flipflop_using_SR(

    input clk,
    input rst,   // synchronous reset
    input J,
    input K,
    output reg Q
);
    wire S, R;

    assign S = J & ~Q;
    assign R = K & Q;

    always @(posedge clk) begin
        if (rst)
            Q <= 1'b0;
        else begin
            case ({S, R})
                2'b10: Q <= 1;      // Set
                2'b01: Q <= 0;      // Reset
                2'b00: Q <= Q;      // Hold
                2'b11: Q <= 1'bx;   // Invalid (should not happen in JK)
            endcase
        end
    end
endmodule
