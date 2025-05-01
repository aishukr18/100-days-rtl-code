module moore_fsm1011_tb();
reg clk,rst,din;
wire dout;
moore_fsm1011 dut(.clk(clk),.rst(rst),.din(din),.dout(dout));
initial begin
clk=1'b0;
forever #10 clk = ~clk;
end
task rst_dut();
begin
@(negedge clk);
rst=1'b1;
@(negedge clk);
rst=1'b0;
end
endtask
task d_in(input a);
begin
@(negedge clk);
din=a;
end
endtask
initial begin
rst_dut();
d_in(1);
d_in(0);
d_in(1);
d_in(1);
d_in(0);
d_in(1);
d_in(0);
d_in(1);
d_in(1);
#50 $finish;
end
endmodule
