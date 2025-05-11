module universal_shift_reg(
    input clk,
    input reset,
    input [1:0] mode,       // Mode control: 00 - hold, 01 - shift right, 10 - shift left, 11 - parallel load
    input [3:0] data_in,    // Parallel input
    input serial_in_left,   // Serial input for shift left
    input serial_in_right,  // Serial input for shift right
    output reg [3:0] data_out // Current state of register
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        data_out <= 4'b0000;
    end else begin
        case (mode)
            2'b00: data_out <= data_out;                             // Hold
            2'b01: data_out <= {serial_in_right, data_out[3:1]};     // Shift right
            2'b10: data_out <= {data_out[2:0], serial_in_left};      // Shift left
            2'b11: data_out <= data_in;                              // Parallel load
            default: data_out <= data_out;
        endcase
    end
end

endmodule
