module tff_using_dff(
    input wire clk,
    input wire rst_n,  // active-low reset
    input wire T,
    output reg Q
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            Q <= 1'b0;
        else
            Q <= Q ^ T; 
    end

endmodule
