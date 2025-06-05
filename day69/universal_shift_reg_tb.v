module universal_shift_reg_tb;
    reg clk;
    reg clear;
    reg sir,sil;
    reg [1:0] s;
    reg [3:0] i;
    wire [3:0] out;
    
    universal_shift_reg dut(out,clk,clear,s,i,sir,sil);
    always #10 clk = ~clk ;
    task parallel_inputs(input [3:0]in);
        begin
            @(negedge clk)
            s = 2'b11;
            i = in;
        end
    endtask
    task shift_right_inputs(input sr);
        begin
            @(negedge clk)
            s = 2'b01;
            sir = sr;
        end
    endtask
    task shift_left_inputs(input sl);
        begin
            @(negedge clk)
            s = 2'b10;
            sil = sl;
        end
    endtask
    initial
        begin
            clk = 1'b0;
            clear = 1'b1;
            
            #10 clear = 1'b0;
            
            parallel_inputs(4'b1001);
            
            #20 clear = 1'b1;
            #50 clear = 1'b0;
            
            shift_right_inputs(1'b1);
            shift_right_inputs(1'b0);
            shift_right_inputs(1'b1);
            shift_right_inputs(1'b0);
            
            parallel_inputs(4'b1001);
            shift_left_inputs(1'b0);
            shift_left_inputs(1'b1);
            shift_left_inputs(1'b1);
            shift_left_inputs(1'b0);
            
            @(negedge clk)
            s = 2'b00;
            #20 $finish;
        end
endmodule
