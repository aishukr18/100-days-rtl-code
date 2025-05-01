module moore_fsm1011(input clk,rst,din,output dout);
parameter s0=3'b000,
          s1=3'b001,
          s2=3'b010,
          s3=3'b011,
          s4=3'b100;
reg [2:0] state,next_state;
always@(posedge clk)
begin
    if(rst)
        state<=s0;
    else 
        state<=next_state;
end
always@(state,din)
begin
    next_state = s0;
    case(state)
    s0:if(din==1) next_state = s1;
       else next_state =s0;
    s1:if(din==0) next_state = s2;
       else next_state = s1;
    s2:if(din==1) next_state = s3;
       else next_state =s0;
    s3:if(din==1) next_state =s4;
       else     next_state = s2;
    s4:next_state = s0;
endcase
end
assign dout = (state==s4)?1:0;
endmodule
