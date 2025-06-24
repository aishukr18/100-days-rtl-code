
module memory_controller (
    input clk,
    input reset,
    input [2:0] req,               // 3 requestors
    output reg [2:0] grant,        // One-hot grant output
    output reg [1:0] arbiter_state // Debug: current FSM state
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // On reset: go to initial state and clear grants
            arbiter_state <= 2'b00;
            grant <= 3'b000;
        end else begin
            case (arbiter_state)
                // --------------------------
                // State 00: Initial / Idle
                // Priority order: Req0 > Req1 > Req2
                // --------------------------
                2'b00: begin
                    if (req[0]) begin
                        grant <= 3'b001;
                        arbiter_state <= 2'b01; // Move to Req0 granted state
                    end else if (req[1]) begin
                        grant <= 3'b010;
                        arbiter_state <= 2'b10;
                    end else if (req[2]) begin
                        grant <= 3'b100;
                        arbiter_state <= 2'b11;
                    end else begin
                        grant <= 3'b000;
                    end
                end

                // --------------------------
                // State 01: Last granted Req0
                // Priority: Req1 > Req2 > Req0
                // --------------------------
                2'b01: begin
                    if (req[1]) begin
                        grant <= 3'b010;
                        arbiter_state <= 2'b10;
                    end else if (req[2]) begin
                        grant <= 3'b100;
                        arbiter_state <= 2'b11;
                    end else if (req[0]) begin
                        grant <= 3'b001;
                        arbiter_state <= 2'b01;
                    end else begin
                        grant <= 3'b000;
                        arbiter_state <= 2'b00;
                    end
                end

                // --------------------------
                // State 10: Last granted Req1
                // Priority: Req2 > Req0 > Req1
                // --------------------------
                2'b10: begin
                    if (req[2]) begin
                        grant <= 3'b100;
                        arbiter_state <= 2'b11;
                    end else if (req[0]) begin
                        grant <= 3'b001;
                        arbiter_state <= 2'b01;
                    end else if (req[1]) begin
                        grant <= 3'b010;
                        arbiter_state <= 2'b10;
                    end else begin
                        grant <= 3'b000;
                        arbiter_state <= 2'b00;
                    end
                end

                // --------------------------
                // State 11: Last granted Req2
                // Priority: Req0 > Req1 > Req2
                // --------------------------
                2'b11: begin
                    if (req[0]) begin
                        grant <= 3'b001;
                        arbiter_state <= 2'b01;
                    end else if (req[1]) begin
                        grant <= 3'b010;
                        arbiter_state <= 2'b10;
                    end else if (req[2]) begin
                        grant <= 3'b100;
                        arbiter_state <= 2'b11;
                    end else begin
                        grant <= 3'b000;
                        arbiter_state <= 2'b00;
                    end
                end

                default: begin
                    grant <= 3'b000;
                    arbiter_state <= 2'b00;
                end
            endcase
        end
    end

endmodule
