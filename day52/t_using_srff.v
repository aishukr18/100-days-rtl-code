module T_using_SR(
    input wire clk,
    input wire rst,   // synchronous reset
    input wire T,
    output reg Q
);
    wire S, R;

    // Derive S and R from T and current Q
    assign S = T & ~Q;
    assign R = T & Q;

    always @(posedge clk) begin
        if (rst)
            Q <= 1'b0; 
        else begin
            case ({S, R})
                2'b10: Q <= 1;     // Set
                2'b01: Q <= 0;     // Reset
                2'b00: Q <= Q;     // Hold
                2'b11: Q <= 1'bx;  // Invalid for SR
            endcase
        end
    end
endmodule
