module piso(
    input clk,input reset,
    input load,            // Load control signal
    input [3:0] data_in,
    output reg data_out
);

reg [3:0] shift_reg; 

always @(posedge clk or posedge reset) begin
    if (reset) begin
        shift_reg <= 4'b0000;
        data_out <= 1'b0;
    end else if (load) begin
        shift_reg <= data_in;  
    end else begin
        data_out <= shift_reg[3];    // Output the MSB (can be LSB if desired)
        shift_reg <= shift_reg << 1; // Shift left
    end
end
endmodule
