//top
`timescale 1ps/1fs
module router(input clk,rst,
                                                read_enb_0,read_enb_1,read_enb_2,pkt_valid,
                                                input [7:0] data_in,
                                                output vld_out_0,vld_out_1,vld_out_2,err,busy,
                                                output [7:0] data_out_0,data_out_1,data_out_2);
//fifo_instance
wire [2:0] write_enb;
wire [7:0] dout;
//wire sft_rst_0,sft_rst_1,sft_rst_2;
//wire lfd_state,fifo_empty_0,fifo_empty_1,fifo_empty_2;
//wire full_0,full_1,full_2;

fifo1 F0(.clk(clk),.rst(rst),.write_enb(write_enb[0]),.sft_rst(sft_rst_0),.read_enb(read_enb_0),.data_in(dout),.lfd_state(lfd_state),.empty(fifo_empty_0),.data_out(data_out_0),.full(full_0));
//fifo1 FIFO1(.clk(clk),.rst(rst),.write_enb(write_enb[1]),.sft_rst(sft_rst_1),.read_enb(read_enb_1),.data_in(dout),.lfd_state(lfd_state),.empty(fifo_empty_1),.data_out(data_out_1),.full(full_1));
fifo1 F1(.clk(clk),.rst(rst),.write_enb(write_enb[1]),.sft_rst(sft_rst_1),.read_enb(read_enb_1),.data_in(dout),.lfd_state(lfd_state),.empty(fifo_empty_1),.data_out(data_out_1),.full(full_1));
fifo1 F3(.clk(clk),.rst(rst),.write_enb(write_enb[2]),.sft_rst(sft_rst_2),.read_enb(read_enb_2),.data_in(dout),.lfd_state(lfd_state),.empty(fifo_empty_2),.data_out(data_out_2),.full(full_2));


//synchronizer
//wire detect_add;
//wire write_enb_reg,fifo_full;
synchronizer synch1(.detect_add(detect_add),.data_in(data_in[1:0]),.clk(clk),.rst(rst),.write_enb_reg(write_enb_reg),
                                         .read_enb_0(read_enb_0),.read_enb_1(read_enb_1),.read_enb_2(read_enb_2),
                                         .empty_0(fifo_empty_0),.empty_1(fifo_empty_1),.empty_2(fifo_empty_2),
                                         .full_0(full_0),.full_1(full_1),.full_2(full_2),
                                         .vld_out_0(vld_out_0),.vld_out_1(vld_out_1),.vld_out_2(vld_out_2),
                                         .sft_rst_0(sft_rst_0),.sft_rst_1(sft_rst_1),.sft_rst_2(sft_rst_2),
                                         .fifo_full(fifo_full),.write_enb(write_enb));


//fsm
//wire parity_done;
//wire low_pkt_valid,ld_state,laf_state;
//wire full_state,rst_int_reg;
fsm fsm1(.clk(clk),.rst(rst),.pkt_valid(pkt_valid),
       .parity_done(parity_done),
            .sft_rst_0(sft_rst_0),.sft_rst_1(sft_rst_1),.sft_rst_2(sft_rst_2),
            .fifo_full(fifo_full),.low_pkt_valid(low_pkt_valid),
                 .fifo_empty_0(fifo_empty_0),.fifo_empty_1(fifo_empty_1),.fifo_empty_2(fifo_empty_2),
            .data_in(data_in[1:0]),
            .busy(busy),.detect_add(detect_add),.ld_state(ld_state),.laf_state(laf_state),.full_state(full_state),
                 .write_enb_reg(write_enb_reg),.rst_int_reg(rst_int_reg),.lfd_state(lfd_state));


//register
register r1(.clk(clk),.rst(rst),.pkt_valid(pkt_valid),.fifo_full(fifo_full),
                                .rst_int_reg(rst_int_reg),.detect_add(detect_add),.ld_state(ld_state),.laf_state(laf_state),
                                .full_state(full_state),.lfd_state(lfd_state),.data_in(data_in),
                                .parity_done(parity_done),.low_pkt_valid(low_pkt_valid),.err(err),.dout(dout));

endmodule
