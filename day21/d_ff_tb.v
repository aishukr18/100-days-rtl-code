module d_ff_tb();
reg clk,rst,d;
wire q,qb;
d_ff dut( clk,rst,d,q,qb);
initial begin
clk=1'b0;
end
always #10 clk= ~clk;
task reset();
begin
@(negedge clk);
rst=1'b1;
@(negedge clk);
rst=1'b0;
end
endtask
task din(input a);
begin
@(negedge clk);
d=a;
end
endtask
initial begin
reset;
din(1);
din(0);
din(1);
din(0);
#10;
$finish;
end
endmodule
