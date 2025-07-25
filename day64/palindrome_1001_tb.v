module fsm_1001_tb();
    reg clk,rst,data_in;
    wire y;
    fsm_1001 dut( clk,rst,data_in,y);
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
    task din(input a);
        begin
            @(negedge clk);
            data_in=a;
        end
    endtask
    initial 
        begin
            reset;
            $monitor("Time=%0t | clk=%b rst=%b data_in=%b y=%b", $time, clk, rst, data_in, y);
            din(1);
            din(0);
            din(0);
            din(1);
            din(0);
            din(0);
            din(1);
            #10;
            $finish;
    end
endmodule
