module graycode_counter (input clk,reset,enable,output reg  [3:0] gray );
    reg [3:0] binary;

    always @(posedge clk) begin
        if (reset) begin
            binary <= 4'b0;
        end else if (enable) begin
            binary <= binary + 1;
        end
    end
    // Combinational block to convert binary to Gray code
    // Gray code is calculated as: binary XOR (binary shifted right by 1)
    always @(*) begin
        gray = binary ^ (binary >> 1);
    end
endmodule
