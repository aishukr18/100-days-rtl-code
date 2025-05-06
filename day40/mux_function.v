module mux_function( input [3:0] i,input [1:0] sel,output reg y);
function mux(input [3:0]k,input [1:0]m);
begin
case(m)
2'b00:mux=k[0];
2'b01:mux=k[1];
2'b10:mux=k[2];
2'b11:mux=k[3];
endcase
end
endfunction
always@(sel,i)
y=mux(i,sel);
endmodule
