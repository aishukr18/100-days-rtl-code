module meealy_101(
    input clk,
    input rst,
    input data_in,
    output reg y
);
    
    parameter s0 = 2'b00,  // Initial state
              s1 = 2'b01,  
              s2 = 2'b10;  // Got '10'

    reg [1:0] state, next_state;
    
    always @(posedge clk) 
    begin
        if (rst)
            state <= s0;
        else
            state <= next_state;
    end

    always @(state or data_in) 
    begin
    next_state = s0;
        case(state)
            s0: if(data_in == 1)
                next_state = s1 ;
                else
                next_state = s0;
            s1: if(data_in==0)
                next_state = s2;
                else 
                next_state = s1;
            s2: next_state = s0;
        endcase
    end

    always @(posedge clk) 
    begin
        if(rst)
            y<=0;
        else
            begin
            y<=0;
                case (state)
                s0 : y<=0;
                s1 : y<=0;
                s2 : y<= 1;
        endcase
        end
    end
endmodule
