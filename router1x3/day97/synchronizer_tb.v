module synchronizer_tb();
    reg rst,clk,detect_add,read_enb_0,read_enb_1,read_enb_2,
        full_0,full_1,full_2,empty_0,empty_1,empty_2,write_enb_reg;
    reg [1:0] data_in;
    wire vld_out_0,vld_out_1,vld_out_2,sft_rst_0,sft_rst_1,sft_rst_2,fifo_full;
    wire [2:0] write_enb;
    synchronizer dut(.rst(rst),.clk(clk),.detect_add(detect_add),.read_enb_0(read_enb_0),.read_enb_1(read_enb_1),.read_enb_2(read_enb_2),
        .full_0(full_0),.full_1(full_1),.full_2(full_2),.empty_0(empty_0),.empty_1(empty_1),.empty_2(empty_2),.write_enb_reg(write_enb_reg),.data_in(data_in),
         .vld_out_0(vld_out_0),.vld_out_1(vld_out_1),.vld_out_2(vld_out_2),.sft_rst_0(sft_rst_0),.sft_rst_1(sft_rst_1),.sft_rst_2(sft_rst_2),.fifo_full(fifo_full),
         .write_enb(write_enb));
    initial
        begin
            clk=1'b0;
            read_enb_0=1'b1;
            read_enb_1=1'b1;
            read_enb_2=1'b1;
            //vld_out_0=1'b0;
        end
    always #10 clk= ~ clk;
    
    task rst_dut();
        begin
            @(negedge clk)
            rst=1'b0;
            @(negedge clk)
            rst=1'b1;
        end
    endtask
    
    initial
        begin
            @(negedge  clk)
            @(negedge  clk)
            detect_add=1'b1;
            data_in=2'b01;
            
            @(negedge clk)
            detect_add=1'b0;
            write_enb_reg=1'b1;
            @(negedge clk)
            {full_0,full_1,full_2}=3'b011;
            @(negedge clk)
            {empty_0,empty_1,empty_2}=3'b000;
            @(negedge clk)
            {read_enb_0,read_enb_1,read_enb_2}=3'b010;
            //#1000;
        end
    initial begin
        rst_dut();
    end
endmodule
