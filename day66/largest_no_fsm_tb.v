module largest_no_fsm_tb();
    reg clk,rst;
    reg [1:0]data_in;
    wire [1:0] y;
    largest_no_fsm dut( clk,rst,data_in,y);
    initial begin
        clk=1'b0;
    end
    always #10 clk= ~clk;
    
    task reset();
        begin
            @(negedge clk);
            rst=1'b1;
            @(negedge clk);
            rst=1'b0;
        end
    endtask
    
    task din(input [1:0]a);
        begin
            @(negedge clk);
            data_in=a;
        end
    endtask
    
    initial 
        begin
            reset;
                $monitor("Time=%0t | clk=%b rst=%b data_in=%b y=%b", $time, clk, rst, data_in, y);
                din(2'd0);
                din(2'd0);
                din(2'd1);
                din(2'd0);
                din(2'd2);
                din(2'd1);
                din(2'd3);
                #100;
                $finish;
        end
endmodule
