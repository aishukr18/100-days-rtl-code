module d_flipflop(q, d , clk , clear);
    input d, clk, clear;
    output reg q;
    always@(posedge clk , posedge clear)
        begin
            if(clear)
                q <= 1'b0;
            else
                q <= d;
        end
endmodule

module mux_4_to_1(mux_out, s, in0 , in1 , in2 , in3);
    output reg mux_out;
    input [1:0] s;
    input in0 , in1 , in2 , in3 ;
    always@(*)
        begin
            case(s)
                2'b00 : mux_out = in0;
                2'b01 : mux_out = in1;
                2'b10 : mux_out = in2;
                2'b11 : mux_out = in3;
            endcase
        end
endmodule

module universal_shift_reg(out, clk,clear, s,i ,sir, sil);
    input clk, clear, sir, sil;
    input [1 : 0] s ;
    input [3 : 0] i;
    output [3 : 0] out;
    wire [3 : 0] d_temp;
    
    mux_4_to_1 inst1(d_temp[0], s,out[0],sir,out[1],i[0]);
    mux_4_to_1 inst2(d_temp[1], s,out[1],out[0],out[2],i[1]);
    mux_4_to_1 inst3(d_temp[2], s,out[2],out[1],out[3],i[2]);
    mux_4_to_1 inst4(d_temp[3], s,out[3],out[2],sil,i[3]);
    
    d_flipflop D_inst1(out[0] , d_temp[0] , clk , clear);
    d_flipflop D_inst2(out[1] , d_temp[1] , clk , clear);
    d_flipflop D_inst3(out[2] , d_temp[2] , clk , clear);
    d_flipflop D_inst4(out[3] , d_temp[3] , clk , clear);
endmodule
