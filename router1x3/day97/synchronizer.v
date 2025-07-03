module synchronizer(input rst,clk,detect_add,
                          read_enb_0,read_enb_1,read_enb_2,
                          full_0,full_1,full_2,
                          empty_0,empty_1,empty_2,
                          write_enb_reg,
                          input [1:0] data_in,
                    output vld_out_0,vld_out_1,vld_out_2,
                         output reg sft_rst_0,sft_rst_1,sft_rst_2,
                            fifo_full,
                    output reg [2:0] write_enb);
            reg [1:0] address;
            reg [7:0] count_0,count_1,count_2;
                 wire flag_0,flag_1,flag_2;
            always@(posedge clk)
            begin
                    if(rst==1'b0)
                            address<=2'bzz;
                    else if(detect_add==1'b1)
                            address<=data_in;
            end
            always@(*)
            begin
                    if(write_enb_reg==1'b1)
                         begin
                            case(address)
                                    2'b00:write_enb=3'b001;
                                    2'b01:write_enb=3'b010;
                                    2'b10:write_enb=3'b100;
                                    default : write_enb=3'b000;
                    endcase
                         end
                    else
                            write_enb=3'b000;
            end
            always@(*)
            begin
                    case(address)
                            2'b00:fifo_full=full_0;
                            2'b01:fifo_full=full_1;
                            2'b10:fifo_full=full_2;
                            default:fifo_full=1'b0;
            endcase
    end
    assign vld_out_0= ~empty_0;
    assign vld_out_1= ~empty_1;
    assign vld_out_2= ~empty_2;
    assign flag_0=(count_0==8'd29);
    assign flag_1=(count_1==8'd29);
    assign flag_2=(count_2==8'd29);

    always@(posedge clk)
    begin
            if(rst==1'b0)
            begin
                    count_0<=0;
                    sft_rst_0<=1'b0;
            end
            else if(vld_out_0==1'b0)
            begin
                    count_0<=0;
                    sft_rst_0<=1'b0;
            end
            else if(read_enb_0==1'b1)
            begin
                    count_0<=8'b0;
                    sft_rst_0<=1'b0;
            end
            else
            begin
                    if(flag_0)
                            begin
                                    count_0<=0;
                                    sft_rst_0<=1'b1;
                            end
                    else
                            count_0<=count_0+1;
            end
    end
         always@(posedge clk)
    begin
            if(rst==1'b0)
            begin
                    count_1<=0;
                    sft_rst_1<=1'b0;
            end
            else if(vld_out_1==1'b0)
            begin
                    count_1<=0;
                    sft_rst_1<=1'b0;
            end
            else if(read_enb_1==1'b1)
            begin
                    count_1<=8'b0;
                    sft_rst_1<=1'b0;
            end
            else
            begin
                    if(flag_1)
                            begin
                                    count_1<=0;
                                    sft_rst_1<=1'b1;
                            end
                    else
                            count_1<=count_1+1;
            end
    end
         always@(posedge clk)
    begin
            if(rst==1'b0)
            begin
                    count_2<=0;
                    sft_rst_2<=1'b0;
            end
            else if(vld_out_2==1'b0)
            begin
                    count_2<=0;
                    sft_rst_2<=1'b0;
            end
            else if(vld_out_2==1'b0)
            begin
                    count_2<=0;
                    sft_rst_2<=1'b0;
            end
            else if(read_enb_2==1'b1)
            begin
                    count_2<=1'b0;
                    sft_rst_2<=1'b0;
            end
            else
            begin
                    if(flag_2)
                            begin
                                    count_2<=0;
                                    sft_rst_2<=1'b1;
                            end
                    else
                            count_2<=count_2+1;
            end
    end
    endmodule
