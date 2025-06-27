module page_mode_dram (
    input wire clk,
    input wire cs, 
    input wire we, 
    input wire [3:0] row, 
    input wire [3:0] col, 
    input wire [7:0] data_in, 
    output reg [7:0] data_out 
);

    reg [7:0] memory [15:0][15:0]; 

    always @(posedge clk) begin
        if (cs) begin
            if (we) begin
                memory[row][col] <= data_in;
            end else begin
                data_out <= memory[row][col];
            end
        end else begin
            data_out <= 8'h00; // Clear data_out when chip is not selected
        end
    end

endmodule
