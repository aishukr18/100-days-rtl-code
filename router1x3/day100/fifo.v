 module fifo1(input clk,rst,sft_rst,read_enb,write_enb,lfd_state,input [7:0] data_in,output reg[7:0] data_out,output empty,full);
reg [8:0]mem[0:15];
reg [4:0] w_ptr,r_ptr;
reg lfd_t;
integer i;
reg [5:0]temp;

always@(posedge clk)
begin
        if(rst==1'b0)
        begin
                w_ptr<=5'b0;
                for(i=0;i<16;i=i+1)
                begin
                        mem[i]<=9'b0;
                end
        end
        else if(sft_rst)
        begin
                w_ptr<=5'b0;
                for(i=0;i<16;i=i+1)
                begin
                        mem[i]<=9'b0;

                end
        end
        else if(write_enb && !full)
        begin
                mem[w_ptr[3:0]]<={lfd_t,data_in};
                w_ptr<=w_ptr+1'b1;
        end
        else
                        w_ptr<=w_ptr;
end
always@(posedge clk)
begin
        if(rst==1'b0)
        begin
                r_ptr<=5'b0;
                data_out<=8'b0;
                //r_ptr<=5'b0;
        end
        else if(empty==0 && read_enb==1'b1)
        begin
                data_out<=mem[r_ptr[3:0]];
                r_ptr<=r_ptr+1'b1;
                //temp<=temp-1;
                //if(temp==0)
                        //data_out<=8'bz;
        end
        else if(sft_rst==1'b1)
        begin
                data_out<=8'bz;
        end

        else if(temp==0)
                        data_out<=8'bz;
end
always@(posedge clk)
begin
        if(rst==1'b0)
        begin
                lfd_t<=0;
        end
        else if(sft_rst==1'b1)
                lfd_t<=0;
        else
                lfd_t<=lfd_state;
end
always@(posedge clk)
begin
        if(rst==0)
                temp<=0;
        else if(sft_rst)
                temp<=0;
        else if(empty==0 && read_enb)
        begin
                if(mem[r_ptr[3:0]][8]==1)
                temp<=mem[r_ptr[3:0]][7:2]+1'b1;
                else if(temp!=0)
           temp<=temp-1'b1;
                end

end
assign full=(w_ptr==5'd16 && r_ptr==5'd0)?1'b1:1'b0;
assign empty=(r_ptr==w_ptr)?1'b1:1'b0;

endmodule
