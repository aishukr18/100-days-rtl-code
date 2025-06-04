module seq_det(clk,rst,w,z);
input clk,rst,w;
output z;
parameter IDLE=4'b0000,
S0=4'b0001,
S1=4'b0010,
S00=4'b0011,
S01=4'b0100,
S10=4'b0101,
S11=4'b0110,
S001=4'b0111,
S010=4'b1000,
S100=4'b1001,
S111=4'b1010;
reg [3:0]state,ns;
always@(posedge clk)
begin
if(rst)
state <= IDLE;
else
state <= ns;
end
always@(*)
begin
ns = IDLE;
case(state)
IDLE : begin
if(w)
ns=S1;
else
ns=S0;
end
S0 : begin
if(w)
ns=S01;
else
ns=S00;
end
S1 : begin
if(w)
ns=S11;
else
ns=S10;
end
S00 : begin
if(w)
ns=S001;
else
ns=S00;
end
S01 : begin
if(w)
ns=S11;
else
ns=S010;
end
S10 : begin
if(w)
ns=S01;
else
ns=S100;
end
S11 : begin
if(w)
ns=S111;
else
ns=S10;
end
S001 : begin
if(w)
ns=S11;
else
ns=S010;
end
S010 : begin
if(w)
ns=S01;
else
ns=S100;
end
S100 : begin
if(w)
ns=S001;
else
ns=S00;
end
S111 : begin
if(w)
ns=S111;
else
ns=S10;
end
endcase
end
assign
z=(state==S001|state==S010|state==S100|state==S111)?1'b1:1'b0;
endmodule
