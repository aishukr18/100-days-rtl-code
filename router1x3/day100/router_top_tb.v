module router_tb();
reg clk,rst,read_enb_0,read_enb_1,read_enb_2,pkt_valid;
reg [7:0] data_in;
wire vld_out_0,vld_out_1,vld_out_2,err,busy;
wire [7:0] data_out_0,data_out_1,data_out_2;
integer i;
router dut(clk,rst,read_enb_0,read_enb_1,read_enb_2,pkt_valid,data_in,vld_out_0,vld_out_1,vld_out_2,err,busy,data_out_0,data_out_1,data_out_2);
        task initialize;
                begin
                        clk=1'b0;
                        rst=1'b0;
                        read_enb_0=1'b0;
                        read_enb_1=1'b0;
                        read_enb_2=1'b0;
                        data_in=0;
                end
        endtask
        initial begin
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

//for payload 14
        task pkt_gen_14;
                reg [7:0] payload_data,parity,header;
                reg [5:0] payload_len;
                reg [1:0] addr;
                        begin
                                @(negedge clk)
                                wait(~busy)
                                @(negedge clk)
                                payload_len=6'd14;
                                addr=2'b00;
                                header={payload_len,addr};
                                parity=1'b0;
                                data_in=header;
                                pkt_valid=1'b1;
                                parity=parity^header;
                                @(negedge clk);
                                wait(~busy)
                        for(i=0;i<payload_len;i=i+1)
                                begin
                                        @(negedge clk);
                                        wait(~busy)
                                        payload_data={$random}%256;
                                        data_in=payload_data;
                                        parity=parity^payload_data;

                                end
                                        @(negedge clk);
                                        wait(~busy)
                                        pkt_valid=1'b0;
                                        data_in=parity;
                end
        endtask

//payload less than 14
        task pkt_gen_14_lt;
                reg [7:0] payload_data,parity,header;
                reg [5:0] payload_len;
                reg [1:0] addr;
                        begin
                                @(negedge clk)
                                wait(~busy)
                                @(negedge clk)
                                payload_len=6'd12;
                                addr=2'b01;
                                header={payload_len,addr};
                                parity=1'b0;
                                data_in=header;
                                pkt_valid=1'b1;
                                parity=parity^header;
                                @(negedge clk);
                                wait(~busy)
                        for(i=0;i<payload_len;i=i+1)
                                begin
                                        @(negedge clk);
                                        wait(~busy)
                                        payload_data={$random}%256;
                                        data_in=payload_data;
                                        parity=parity^payload_data;
                                        //if(i==4'd2)
                                        //read_enb_0=1'b1;
                                end
                                @(negedge clk);
                                wait(~busy)
                                pkt_valid=1'b0;
                                data_in=parity;
                        end
        endtask

//for 16
        task pkt_gen_16;
                reg [7:0] payload_data,parity,header;
                reg [5:0] payload_len;
                reg [1:0] addr;
                        begin
                                @(negedge clk)
                                wait(~busy)
                                @(negedge clk)
                                payload_len=6'd16;
                                addr=2'b10;
                                header={payload_len,addr};
                                parity=1'b0;
                                data_in=header;
                                pkt_valid=1'b1;
                                parity=parity^header;
                                @(negedge clk);
                                wait(~busy)
                        for(i=0;i<payload_len;i=i+1)
                                begin
                                        @(negedge clk);
                                        wait(~busy)
                                        payload_data={$random}%256;
                                        data_in=payload_data;
                                        parity=parity^payload_data;
                                end
                                @(negedge clk);
                                wait(~busy)
                                pkt_valid=1'b0;
                                data_in=parity;
                                end
endtask

event e1;

//random
        task pkt_random;
                reg [7:0] payload_data,parity,header;
                reg [5:0] payload_len;
                reg [1:0] addr;
                        begin
                        -> e1;
                                @(negedge clk)
                                wait(~busy)
                                @(negedge clk)
                                payload_len={$random}%63;
                                addr=2'b00;
                                header={payload_len,addr};
                                parity=1'b0;
                                data_in=header;
                                pkt_valid=1'b1;
                                parity=parity^header;
                                //-> e1;

                                @(negedge clk);
                                wait(~busy)
                        for(i=0;i<payload_len;i=i+1)
                                begin
                                        @(negedge clk);
                                        wait(~busy)
                                        payload_data={$random}%256;
                                        data_in=payload_data;
                                        parity=parity^payload_data;
                                end
                                @(negedge clk);
                                wait(~busy)
                                pkt_valid=1'b0;
                                data_in=parity;
                        end
        endtask
        event e2;
        //named event grt 17
        task pkt_grt_17;
                reg [7:0] payload_data,parity,header;
                reg [5:0] payload_len;
                reg [1:0] addr;
                        begin
                        -> e2;
                                @(negedge clk)
                                wait(~busy)
                                @(negedge clk)
                                payload_len=6'd19;
                                addr=2'b10;
                                header={payload_len,addr};
                                parity=1'b0;
                                data_in=header;
                                pkt_valid=1'b1;
                                parity=parity^header;
                        //      -> e2;

                                @(negedge clk);
                                wait(~busy)
                        for(i=0;i<payload_len;i=i+1)
                                begin
                                        @(negedge clk);
                                        wait(~busy)
                                        payload_data={$random}%256;
                                        data_in=payload_data;
                                        parity=parity^payload_data;
                                end
                                @(negedge clk);
                                wait(~busy)
                                pkt_valid=1'b0;
                                data_in=parity;
                        end
        endtask

        initial begin
        initialize;
        rst_dut;
        //for 14
        repeat(3)@(negedge clk);
        pkt_gen_14;
        repeat(2)@(negedge clk);
        read_enb_0=1'b1;
        wait(~vld_out_0)
        @(negedge clk);
        read_enb_0=1'b0;

        rst_dut;
        //less than 14
        repeat(3)@(negedge clk);
        pkt_gen_14_lt;
        repeat(2)@(negedge clk);
        read_enb_1=1'b1;
        wait(~vld_out_1)
        @(negedge clk);
        read_enb_1=1'b0;
   //for 16
        rst_dut;
        repeat(3)@(negedge clk);
        pkt_gen_16;
        //repeat(2)
        @(negedge clk);
        read_enb_2=1'b1;
        wait(~vld_out_2)
        @(negedge clk);
        read_enb_2=1'b0;
        rst_dut;
        pkt_random;
        @(negedge clk);
        @(negedge clk);
        rst_dut;
        pkt_grt_17;
        //#200 $finish ;
        end
        //random
        initial begin
        @(e1)
        repeat(5)@(negedge clk);
        read_enb_0=1'b1;
        wait(~vld_out_0)
        @(negedge clk);
        read_enb_0=1'b0;
        //#200 $finish ;
        end
        initial begin
        @(e2)
        repeat(7)@(negedge clk);
        read_enb_2=1'b1;
        wait(~vld_out_2)
        @(negedge clk);
        read_enb_2=1'b0;
        #200 $finish;
        end
endmodule
