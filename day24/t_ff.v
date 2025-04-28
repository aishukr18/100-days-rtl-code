module t_ff(input clk, rst, t, output reg q, output qb);
    always @(negedge clk) begin
        if (rst)
            q <= 0;
        else if (t)
            q <= ~q;
    end

    assign qb = ~q;
endmodule
