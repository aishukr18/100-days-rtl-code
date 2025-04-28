module universal_shift_reg(input clk,rst,
                           input [3:0] din,
                           input s0,s1,s_right_din,s_left_din,
                           output [3:0] dout );
                           
                           wire w0,w1,w2,w3;
                           mux m0(.s0(s0),.s1(s1),.y0(dout[0]),.y1(dout[1]),.y2(s_left_din),.y3(din[0]),.out(w0));
                           mux m1(.s0(s0),.s1(s1),.y0(dout[1]),.y1(dout[2]),.y2(dout[0]),.y3(din[1]),.out(w1));
                           mux m2(.s0(s0),.s1(s1),.y0(dout[2]),.y1(dout[3]),.y2(dout[1]),.y3(din[2]),.out(w2));
                           mux m3(.s0(s0),.s1(s1),.y0(dout[3]),.y1(s_right_din),.y2(dout[2]),.y3(din[3]),.out(w3));
                           d_ff d0(.clk(clk),.clr(rst),.d(w0),.q(dout[0]));
                           d_ff d1(.clk(clk),.clr(rst),.d(w1),.q(dout[1]));
                           d_ff d2(.clk(clk),.clr(rst),.d(w2),.q(dout[2]));
                           d_ff d3(.clk(clk),.clr(rst),.d(w3),.q(dout[3]));
endmodule
