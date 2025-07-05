module router_reg_tb;

        // Inputs
        reg clock;
        reg resetn;
        reg pkt_valid;
        reg fifo_full;
        reg rst_int_reg;
        reg detect_add;
        reg ld_state;
        reg laf_state;
        reg full_state;
        reg lfd_state;
        reg [7:0] data_in;

        // Outputs
        wire parity_done;
        wire low_pkt_valid;
        wire err;
        wire [7:0] dout;

        // Instantiate the Unit Under Test (UUT)
        router_reg dut (
                .clock(clock),
                .resetn(resetn),
                .pkt_valid(pkt_valid),
                .fifo_full(fifo_full),
                .rst_int_reg(rst_int_reg),
                .detect_add(detect_add),
                .ld_state(ld_state),
                .laf_state(laf_state),
                .full_state(full_state),
                .lfd_state(lfd_state),
                .data_in(data_in),
                .parity_done(parity_done),
                .low_pkt_valid(low_pkt_valid),
                .err(err),
                .dout(dout));

        initial
         begin
                // Initialize Inputs
                clock = 0;
                resetn = 0;
                pkt_valid = 0;
                fifo_full = 0;
                rst_int_reg = 0;
                detect_add = 0;
                ld_state = 0;
                laf_state = 0;
                full_state = 0;
                lfd_state = 0;
                data_in = 0;
    end
         always #5clock=~clock;
  task reset();
        begin
           @(negedge clock)
           resetn=1'b0;
           @(negedge clock)
           resetn=1'b1;
        end
  endtask
  task packet_generation;
    reg [7:0]payload_data;
    reg [5:0]payload_len;
    reg [1:0]addr;
         reg [7:0]header;
         reg [7:0]parity;
         integer i;
   begin
      @(negedge clock)
                payload_len=6'd16;
                addr=2'b10;
                pkt_valid=1'b1;
                detect_add=1'b1;
                header={payload_len,addr};
                parity=8'h00^header;
                data_in=header;
                @(negedge clock)
                detect_add=1'b0;
                header={payload_len,addr};
                parity=8'h00^header;
                data_in=header;
                @(negedge clock)
                detect_add=1'b0;
                lfd_state=1'b1;
                //full_state=1'b0;
                //fifo_full=1'b1;
                laf_state=1'b0;
                for(i=0;i<payload_len;i=i+1)
                    begin
                           @(negedge clock)
                                  lfd_state=1'b0;
                                  ld_state=1'b1;
                                  payload_data={$random}%256;
                                  data_in=payload_data;
                                  parity=parity^data_in;
                                  if(i==15&&pkt_valid)
                                   fifo_full=1;
                                        else fifo_full=0;
                         end
                @(negedge clock)
                //fifo_full=1;
      pkt_valid=1'b0;
      //data_in=parity;
                data_in=8'd7;
      @(negedge clock)
      ld_state=1'b0;
end
endtask
initial
    begin
        reset;
        packet_generation;
    end
endmodule
