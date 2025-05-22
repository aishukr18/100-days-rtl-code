module d_from_t (
    input wire clk,
    input wire reset,  // synchronous reset
    input wire D,
    output reg Q
);

    wire T;

    assign T = Q ^ D;  // Only toggle when Q ≠ D

    always @(posedge clk) begin
        if (reset)
            Q <= 1'b0;
        else if (T)
            Q <= ~Q;
        else
            Q <= Q;  // hold
    end

endmodule
