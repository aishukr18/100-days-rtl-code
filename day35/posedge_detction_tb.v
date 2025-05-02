module pos_edge_det_tb();
reg clk,sig_a;
wire out;
pos_edge_det dut(.clk(clk),.sig_a(sig_a),.out(out));
initial begin
clk=1'b0;
sig_a=0;
end 
always #10 clk = ~clk;
task in(input a);
begin
sig_a = a;
end
endtask
initial begin

       #20;
        in(1); // Rising edge expected
        #100 $finish;
end
endmodule
