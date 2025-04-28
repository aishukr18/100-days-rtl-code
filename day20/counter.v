module counter(input clk, rst, load, mode, input [3:0] din, output reg [3:0] dout);

always @(posedge clk)
begin
    if (rst)
        dout <= 0;
    else if (load)
        dout <= din;
    else begin
        case (mode)
            1'b1: begin
                if (dout % 2 == 0)
                    dout <= dout + 2;
                else if (dout % 2 != 0)
                    dout <= dout + 3;
            end
            1'b0: begin
                if (dout % 2 != 0)
                    dout <= dout + 2;
                else if (dout % 2 == 0)
                    dout <= dout + 3;
            end
            default: dout <= 0;
        endcase
    end
end
endmodule
