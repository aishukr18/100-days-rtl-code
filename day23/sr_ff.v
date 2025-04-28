module sr_ff(input clk,rst,s,r,output reg q,output qb);
  always @(posedge clk or posedge rst) begin
    if (rst)
      q <= 1'b0;
    else begin
      case ({s, r})
        2'b00: q <= q;         // No change
        2'b01: q <= 1'b0;      // Reset
        2'b10: q <= 1'b1;      // Set
        2'b11: q <= 1'bx;      // Invalid state
      endcase
    end
  end
  assign qb = ~q;

endmodule
