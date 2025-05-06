module mux4_1_task_tb();
reg [3:0] in;
reg [1:0] sel;
wire yout;
mux4_1_task dut (.in(in),.sel(sel),.yout(yout));
initial begin
$monitor("Time=%0t | in=%b | sel=%b | yout=%b",$time,in,sel,yout); 
in=4'b1101;
sel=2'b00;
#10;
sel=2'b01;
#10;
sel=2'b10;
#10;
sel=2'b11;
#20 $finish;
end
endmodule
