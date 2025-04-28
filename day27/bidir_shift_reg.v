module bidir_shift_reg(
    input clk,                  
    input reset,                
    input load,                
    input shift_dir,          
    input [3:0] data_in,        
    output reg [3:0] data_out   
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        data_out <= 4'b0000; 
    end else if (load) begin
        data_out <= data_in; 
    end else begin
        case (shift_dir)
            1'b0: data_out <= {data_out[0], data_out[3:1]}; // Shift right
            1'b1: data_out <= {data_out[2:0], data_out[3]}; // Shift left
        endcase
    end
end
endmodule
