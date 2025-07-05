module router_reg(input clock,resetn,pkt_valid,fifo_full,rst_int_reg,detect_add,ld_state,laf_state,full_state,lfd_state,
                  input [7:0]data_in,
                  output reg parity_done,low_pkt_valid,err,
                  output reg [7:0]dout);
  reg [7:0]header;
  reg [7:0]internal_parity;
  reg [7:0]packet_parity;
  reg [7:0]fifo_full_byte;
  always@(posedge clock)
  begin
          if(!resetn) 
            begin
                  dout<=8'b0;
                  fifo_full_byte<=0;
                  end
          else if(detect_add && pkt_valid && data_in[1:0]!=2'd3)
                  dout<=dout;
          else if(lfd_state)
                  dout<=header;
          else if(ld_state && ~fifo_full)
                  dout<=data_in;
          else if(ld_state && fifo_full)
                   dout<=dout;
          else if(laf_state)
                  dout<=fifo_full_byte;
          else
                  dout<=dout;
  end

  // fifo_full_byte_logic
  always @ (posedge clock)
  begin
        if (resetn == 1'b0)
                fifo_full_byte <= 8'b0;
        else if (ld_state && fifo_full)
                fifo_full_byte <= data_in;
        else
                fifo_full_byte <= fifo_full_byte;
  end

  //header_logic
  always@(posedge clock)
  begin
          if(resetn==1'b0)
                  header<=8'b0;
          else if(detect_add && data_in[1:0]!=3)
                  header<=data_in;
          else
                  header<=header;
  end
  //internal_parity_logic
  always@(posedge clock)
  begin
          if(resetn==1'b0)
                  internal_parity<=8'b0;
          else if(detect_add)
                  internal_parity<=8'b0;
          else if(lfd_state)
                  internal_parity<=internal_parity^header;
          else if(pkt_valid && ld_state && ~full_state)
                  internal_parity<=internal_parity^data_in;
          else
                  internal_parity<=internal_parity;
  end
  //parity_calculation
  always@(posedge clock)
  begin
          if(resetn==1'b0)
                    packet_parity<=8'b0;
          else if(detect_add)
                    packet_parity<=8'b0;
          else if(ld_state && ~pkt_valid)
          packet_parity<=data_in;
          else
                    packet_parity<=packet_parity;
  end
  //low_pkt_valid
  always@(posedge clock)
  begin
     if(resetn==1'b0)
             low_pkt_valid<=1'b0;
                else if(rst_int_reg)
                  low_pkt_valid<=1'b0;
     else if(ld_state && !pkt_valid)
             low_pkt_valid<=1'b1;
          else
        low_pkt_valid<=1'b0;
        end
  //parity_done
  always@(posedge clock)
  begin
    if(resetn==1'b0)
            parity_done <= 1'b0;
    else if((ld_state && !fifo_full && !pkt_valid)||(laf_state && low_pkt_valid && !parity_done))
       parity_done <= 1'b1;
    else if(detect_add)
       parity_done <= 1'b0;
  end
  //err
  always@(posedge clock)
  begin
      if(resetn==1'b0)
                err<=1'b0;
                else if(parity_done)
                                begin
                                        if(packet_parity != internal_parity)
                                                err<=1'b1;
                                        else
                                        err<=1'b0;
                                        end

  end
  endmodule
