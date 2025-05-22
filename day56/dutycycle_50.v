module dutycycle_50(
    input  wire clk,
    input  wire reset,
    output reg  clk_out);

    parameter DIVISOR = 10;
    reg [2:0] count;  // 3 bits can count up to 7; okay for DIVISOR/2 = 5

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count   <= 0;
            clk_out <= 0;
        end else begin
            if (count == (DIVISOR/2 - 1)) begin
                count   <= 0;
                clk_out <= ~clk_out;
            end else begin
                count <= count + 1;
            end
        end
    end

endmodule
