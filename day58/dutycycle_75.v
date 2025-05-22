module dutycycle_75(
    input wire clk,       // input clock
    input wire rst_n,     // active-low reset
    output reg out        // 75% duty cycle output
);
    reg [1:0] count; 

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 2'b00;
        else
            count <= (count == 2'b11) ? 2'b00 : count + 1;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            out <= 0;
        else begin
            // High for count = 0,1,2 (75% time), low at count = 3 (25%)
            if (count < 3)
                out <= 1;
            else
                out <= 0;
        end
    end

endmodule
