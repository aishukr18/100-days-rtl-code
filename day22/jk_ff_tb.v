module jk_ff_tb();
reg clk,rst,j,k;
wire q,qb;
jk_ff dut(clk,rst,j,k,q,qb);
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
task jk_in(input a,b);
begin
@(negedge clk);
j=a;
k=b;
end
endtask
initial begin
    $monitor("Time=%0t | clk=%b rst=%b j=%b k=%b => q=%b qb=%b",
              $time, clk, rst, j, k, q, qb);
  end

initial begin
reset;
jk_in(1'b0,1'b0);
jk_in(1'b0,1'b1);
jk_in(1'b1,1'b0);
jk_in(1'b1,1'b1);
#100 $finish;
end
endmodule
