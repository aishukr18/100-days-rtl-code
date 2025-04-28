module mux_4_1( input y0,y1,y2,y3, input s0,s1, output reg out );
    always@(*)
    begin
        case({s1,s0})
            2'b00: out = y0;
            2'b01: out = y1;
            2'b10: out = y2;
            2'b11: out = y3;
            default: out = 1'b0;
        endcase
    end
endmodule
