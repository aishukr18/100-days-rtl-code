module clk_gated_counter(input  clk, reset,enable,output reg [3:0] count);
    always @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000;
        end else if (enable) begin
            count <= count + 1;
        end
    end
endmodule
