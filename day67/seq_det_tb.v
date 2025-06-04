module tb();
reg clk,rst,in;
wire out;
seq_det s1(clk,rst,in,out);
initial
begin
clk=0;
forever
#10 clk=~clk;
end
task rst_ip();
begin
#10;
rst=1;
#10;
rst=0;
end
endtask
task ip(input in1);
begin
@(negedge clk);
in=in1;
end
endtask
initial
begin
rst_ip;
ip(1);
ip(0);
ip(1);
ip(1);
#20;
ip(0);
ip(0);
ip(1);
ip(1);
end
initial
$monitor("clk=%b, rst=%b, in=%b,out=%b",clk,rst,in,out);
initial
#200 $stop;

