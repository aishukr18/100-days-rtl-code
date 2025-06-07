module seq_counter(
    input clk,
    input rst,
    output reg [2:0] out
);

    parameter S0 = 3'b000,
              S1 = 3'b010,
              S2 = 3'b011,
              S3 = 3'b101,
              S4 = 3'b110;

    reg [2:0] state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S0;
            default: next_state = S0;
        endcase
    end

    always @(*) begin
        case (state)
            S0: out = 3'b000;
            S1: out = 3'b010;
            S2: out = 3'b011;
            S3: out = 3'b101;
            S4: out = 3'b110;
            default: out = 3'b000;
        endcase
    end

endmodule
