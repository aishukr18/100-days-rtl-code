module digital_clk_tb();
    reg clk,reset,load;
    reg [3:0] load_ms_hr,load_ms_min,load_ls_hr,load_ls_min;
    wire [3:0] time_ms_hr,time_ms_min,time_ls_hr,time_ls_min;
    
    digital_clk dut(clk,reset,load,load_ms_hr,load_ms_min,load_ls_hr,load_ls_min,time_ms_hr,time_ms_min,time_ls_hr,time_ls_min);
    initial
        begin
            clk=1'b0;
            forever #5 clk=~clk;
        end 
    task rsr_dut;
        begin
            @(negedge clk)
            reset = 1;
            @(negedge clk)
            reset = 0;
        end
    endtask
    task load_dut(input [3:0]ms_hr,ls_hr,ms_min,ls_min);
        begin
            @(negedge clk)
            load = 1;
            load_ms_hr=ms_hr;
            load_ms_min=ms_min;
            load_ls_hr=ls_hr;
            load_ls_min=ls_min;
            @(negedge clk)
            load = 0;
        end
    endtask
    initial
        begin
            rsr_dut;
            load_dut(4'd1,4'd5,4'd2,4'd6);
            #2000 $finish;
        end
endmodule
