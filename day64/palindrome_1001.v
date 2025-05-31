module fsm_1001(
    input clk,
    input rst,
    input data_in,
    output y
);
    
    parameter s0 = 3'b000,  // Initial state
              s1 = 3'b001,  
              s2 = 3'b010,
              s3 = 3'b011,
              s4 = 3'b100;  // Got '10'

    reg [2:0] state, next_state;
    
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
            s2: if(data_in == 0)
                next_state = s3 ;
                else
                next_state = s1;
            s3: if(data_in == 1)
                next_state = s4 ;
                else
                next_state = s0;
            s4: if(data_in == 1)
                next_state = s1 ;
                else
                next_state = s2;
        endcase
    end

assign y = (state = s4 );

endmodule
