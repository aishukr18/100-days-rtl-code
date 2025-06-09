module fifo_16x8(input clk,rst,we,re,
                 input [3:0] w_addr,r_addr,
                 input [7:0] data_in,
                 output reg [7:0] data_out);
reg [7:0]mem[0:15];
integer i;
always@(posedge clk)
begin
        if(rst==1'b1)
        begin
                for(i=0;i<16;i=i+1)
                        mem[i]<=0;
        end
        else if(we==1'b1)
                mem[w_addr]<=data_in;
end
always@(posedge clk)
begin
        if(rst==1'b1)
        begin
                data_out<=0;
        end
        else if(re==1'b1)
                data_out<=mem[r_addr];
end
endmodule
