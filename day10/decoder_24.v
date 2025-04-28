module decoder_24( 
    input [1:0] d,
    input enable,
    output reg [3:0] y
);

always@(*)
begin
    if (enable == 1)
    begin
        case (d)
            2'b00: y = 4'b0001;
            2'b01: y = 4'b0010;
            2'b10: y = 4'b0100;
            2'b11: y = 4'b1000;
            default: y = 4'b0000;
        endcase
    end
    else
        y = 4'b0000;
end

endmodule
