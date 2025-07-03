module router_fifo_tb();
    reg clock,resetn,soft_reset,write_enb,read_enb,lfd_state;
    reg [7:0]data_in;
    wire empty,full;
    wire [7:0]data_out;
    integer k;
    
    router_fifo dut(clock,resetn,soft_reset,write_enb,read_enb,lfd_state,data_in,empty,full,data_out);
    initial
        begin
            clock=1'b0;
        end
        
    always #5 clock=~clock;
    //reset task
    task reset;
        begin
            @(negedge clock)
            resetn=1'b0;
            @(negedge clock)
            resetn=1'b1;
        end
    endtask
    //soft reset task
    task soft_resetn;
        begin
            @(negedge clock)
            soft_reset=1'b1;
            @(negedge clock)
            soft_reset=1'b0;
        end
    endtask
    //write task
    task write;
        reg [7:0]payload_data,parity,header;
        reg [5:0]payload_len;
        reg [1:0]addr;
        begin
            @(negedge clock)
            payload_len=6'd14;
            addr=2'b01;
            header={payload_len,addr};
            data_in=header;
            lfd_state=1'b1;
            write_enb=1'b1;
            for(k=0;k<payload_len;k=k+1)
                begin
                    @(negedge clock)
                    lfd_state=1'b0;
                    payload_data={$random}%256;
                    data_in=payload_data;
                end
            @(negedge clock)
            parity={$random}%256;
            data_in=parity;
        end 
    endtask
    //read
    task read;
        begin
            @(negedge clock)
            read_enb=1'b0;
            @(negedge clock)
        begin
            read_enb=1'b1;
            write_enb=1'b0;
            end
        end
    endtask
    initial
        begin
            reset;
            soft_resetn;
            write;
            read;
        end
endmodule
