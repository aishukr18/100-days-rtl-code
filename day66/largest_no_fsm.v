module largest_no_fsm(input clk,rst,
                      input [1:0] data_in,
                      output reg[1:0]y);
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
    y = 2'd0;
    case(state)
    s0:if(data_in == 2'd1) 
        begin
            y = 2'd1;
            next_state = s1;
        end
       else if(data_in == 2'd2)
        begin
            y = 2'd2;  
            next_state = s2;
        end
       else if(data_in == 2'd3)
        begin
            y = 2'd3; 
            next_state = s3;
        end
       else
        begin
            y = 2'd0;
            next_state =s0;
        end
    s1: if(data_in == 2'd2)
         begin
            y = 2'd2; 
            next_state = s2;
         end
        else if(data_in == 2'd3) 
         begin
            y = 2'd3;
            next_state = s3;
         end
       else
        begin
            y = 2'd1;
            next_state =s1;
        end
    s2:if(data_in == 2'd3)
        begin
            y = 2'd3; 
            next_state = s3;
        end
       else
        begin
            y = 2'd2;
            next_state =s2;
        end
    s3:begin
        y = 2'd3;
        next_state =s3;
       end 
    endcase 
    end
    endmodule 
