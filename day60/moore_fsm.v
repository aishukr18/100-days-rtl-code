odule moore_fsm( input clk,rst,data_in,output y);
parameter s0 = 2'b00,
          s1 = 2'b01,
          s2 = 2'b10,
          s3 = 2'b11;
reg [1:0] state, next_state;
always@(posedge clk )
if(rst)
    state<=s0;
else
    state<= next_state;
always@(state or data_in)
begin
    next_state = s0;
    case(state)
    s0:if(data_in == 1) 
        next_state = s1;
       else
        next_state =s0;
    s1:if(data_in == 0) 
        next_state = s2;
       else
        next_state =s1;
    s2:if(data_in == 1) 
        next_state = s3;
       else
        next_state =s0;
    s3:if(data_in == 1) 
        next_state = s1;
       else
        next_state =s2; 
    endcase 
    end
    assign y=(state ==s3);
    endmodule  
