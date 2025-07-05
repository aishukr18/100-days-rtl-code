module fsm_tb();

    reg  clk,rst,pkt_valid,parity_done,sft_rst_0,sft_rst_1,sft_rst_2,fifo_full,low_pkt_valid,fifo_empty_0,fifo_empty_1,fifo_empty_2;
    reg  [1:0] data_in;
    wire busy,detect_add,ld_state,laf_state,full_state,write_enb_reg,rst_int_reg,lfd_state;
    
    fsm dut( clk,rst,pkt_valid,parity_done,sft_rst_0,sft_rst_1,sft_rst_2,fifo_full,low_pkt_valid,fifo_empty_0,fifo_empty_1,fifo_empty_2,data_in,busy,detect_add,ld_state,laf_state,full_state,write_enb_reg,rst_int_reg,lfd_state);
    
    initial 
        begin
            clk=1'b0;
        end
    always #10 clk= ~clk;
    
    task rst_dut();
        begin
            @(negedge clk);
            rst=1'b0;
            @(negedge clk);
            rst=1'b1;
        end
    endtask
    //less than 14
    task t1;
        begin
            @(negedge clk);
            pkt_valid=1'b1;
            data_in=2'b01;
            fifo_empty_1=1'b1;
            @(negedge clk)
            @(negedge clk)
            fifo_full=1'b0;
            pkt_valid=1'b0;
            @(negedge clk)
            @(negedge clk)
            fifo_full=1'b0;
        end
    endtask
    // equal to 15 payload
    task  t2;
        begin
            @(negedge clk);
            pkt_valid=1'b1;
            data_in=2'b01;
            fifo_empty_1=1'b1;
            @(negedge clk)
            @(negedge clk)
            fifo_full=1'b1;
            @(negedge clk)
            parity_done=1'b0;
            low_pkt_valid=1'b1;
            @(negedge clk)
            @(negedge clk)
            fifo_full=1'b0;
        end
    endtask
    //greater than 15
    task t3;
        begin
            @(negedge clk);
            pkt_valid=1'b1;
            data_in=2'b01;
            fifo_empty_1=1'b1;
            @(negedge clk)
            @(negedge clk)
            fifo_full=1'b1;
            @(negedge clk);
            parity_done=1'b0;
            low_pkt_valid=1'b0;
            @(negedge clk)
            fifo_full=1'b0;
            pkt_valid=1'b0;
            @(negedge clk)
            @(negedge clk)
            fifo_full=1'b0;
        end
    endtask
    //
    task t4;
        begin
            @(negedge clk);
            pkt_valid=1'b1;
            data_in=2'b01;
            fifo_empty_1=1'b1;
            @(negedge clk)
            @(negedge clk)
            fifo_full=1'b0;
            pkt_valid=1'b0;
            @(negedge clk)
            @(negedge clk)
            fifo_full=1'b0;
            @(negedge clk);
            fifo_full=1'b1;
            @(negedge clk);
            fifo_full=1'b0;
        end
    endtask
    
    initial 
        begin
            rst_dut();
            t1;
            rst_dut();
            t2;
            rst_dut();
            t3;
            rst_dut();
            t4;
end
endmodule
