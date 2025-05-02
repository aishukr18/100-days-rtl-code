module pos_edge_det(output out,input clk,sig_a);
reg sig_dely_a;
wire w1;
always@(posedge clk)
begin
    sig_dely_a<=sig_a;
end
not n1(w1,sig_dely_a);
and a1(out,sig_a,w1);
endmodule
