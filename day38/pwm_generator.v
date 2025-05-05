module pwm(input clk,reset,
        input [7:0] duty,    // Duty cycle input (0 to 255)
        output reg pwm_out,
        output reg [7:0] counter  
);
    always @(posedge clk) begin
        if (reset) begin
            counter <= 8'd0;
            pwm_out <= 1'b0;
        end else begin
            counter <= counter + 8'd1; 

            // Compare counter with duty cycle to set output
            if (counter < duty)
                pwm_out <= 1'b1;
            else
                pwm_out <= 1'b0;
        end
    end
endmodule

