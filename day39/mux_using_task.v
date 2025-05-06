module mux4_1_task(in,sel,yout);
input [3:0] in;
input [1:0] sel;
output reg yout;
task mux_41task(input [3:0]i,input [1:0]s,output out);
begin
case(s)
2'b00:out=i[0];
2'b01:out=i[1];
2'b10:out=i[2];
2'b11:out=i[3];
endcase 
end
endtask
always@(sel,in)
begin
mux_41task(in,sel,yout);
end
endmodule
