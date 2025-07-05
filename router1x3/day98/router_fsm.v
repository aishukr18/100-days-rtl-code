module fsm(input clk,rst,pkt_valid,parity_done,
                 sft_rst_0,sft_rst_1,sft_rst_2,
                 fifo_full,low_pkt_valid,
                 fifo_empty_0,fifo_empty_1,fifo_empty_2,
           input [1:0] data_in,
           output busy,detect_add,ld_state,laf_state,full_state,write_enb_reg,rst_int_reg,lfd_state);

parameter decoder_address=3'b000,
               load_first_data=3'b001,
               wait_till_empty=3'b010,
                         load_data=3'b011,
                    load_parity=3'b100,
               check_parity_error=3'b101,
               fifo_full_state=3'b110,
               load_after_full=3'b111;

  reg [2:0] state,next_state;
/*  reg [1:0] addr;
  always@(posedge clk)
  begin
  if(rst==1'b0)
        addr<=2'bzz;
        else
        addr<=data_in;
  end*/
  always@(posedge clk)begin
          if(rst==1'b0)
                  state<= decoder_address;
                else if(sft_rst_0 ||sft_rst_1 || sft_rst_2)
                        state<= decoder_address;
          else
                  state<=next_state;
  end
  always@(*)
       begin
               next_state=decoder_address;
               case(state)
                      //0
                                decoder_address:if((pkt_valid &&(data_in[1:0]==0)&& fifo_empty_0)||
                                               (pkt_valid &&(data_in[1:0]==1)&& fifo_empty_1)||
                                                         (pkt_valid &&(data_in[1:0]==2)&& fifo_empty_2))
                                                                                  begin
                                                                                                next_state=load_first_data;
                                                                                  end

                                        else if((pkt_valid &&(data_in[1:0]==0)&& !fifo_empty_0)||
                                                            (pkt_valid &&(data_in[1:0]==1)&& !fifo_empty_1)||
                                                            (pkt_valid &&(data_in[1:0]==2)&& !fifo_empty_2))
                                                                                  begin
                                                                                                next_state=wait_till_empty;
                                end
                                                                         else
                                                                                                next_state=decoder_address;
                                //1
                       load_first_data:next_state=load_data;
                                 //2
                                 wait_till_empty:if((fifo_empty_0  && (data_in[1:0]==0)) ||
                                                                                   (fifo_empty_1 && (data_in[1:0]==1)) ||
                                                          (fifo_empty_2 && (data_in[1:0]==2)) )

                                                                                        next_state= load_first_data;

                                                                         else
                                                                                        next_state=wait_till_empty;
                                 //3
                       load_data:if((!fifo_full) && (!pkt_valid))

                                                                        next_state=load_parity;

                                                          else if(fifo_full)

                                                                        next_state=fifo_full_state;
                                                          else
                                                                        next_state=load_data;
                                        //4
                                load_parity:next_state=check_parity_error;
                                //5
                                check_parity_error:if(!fifo_full)

                                                                                                next_state=decoder_address;
                                                                                 else if(fifo_full)

                                                                                                next_state=fifo_full_state;
                                //6
                                fifo_full_state:if(!fifo_full)
                                                next_state=load_after_full;
                                        else
                                                next_state=fifo_full_state;
                                //7
                                load_after_full:if(!parity_done && !low_pkt_valid)
                                           next_state=load_data;
                                        else if(!parity_done && low_pkt_valid)

                                                                        next_state=load_parity;

                                                  else if(parity_done)
                                                                        next_state=decoder_address;
                                                  else
                                                                        next_state=load_after_full;
                endcase
        end

assign busy=((state==load_first_data) ||(state==load_parity)||(state==fifo_full_state) ||(state==load_after_full) ||(state== wait_till_empty) || (state==check_parity_error));
assign detect_add= (state==decoder_address);
assign ld_state= (state==load_data);
assign laf_state= (state==load_after_full);
assign full_state= (state==fifo_full_state);
assign write_enb_reg=(state==load_parity) ||(state==load_data) ||(state==load_after_full) ;
assign rst_int_reg=(state==check_parity_error);
assign lfd_state=(state==load_first_data);

endmodule
