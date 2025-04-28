module t_ff_tb();
    reg clk,rst,t;
    wire q,qb ;
    t_ff dut (clk,rst,t,q,qb);
    initial begin 
        clk=1'b0;
    end
    always #5 clk = ~clk;
    task rst_dut();
        begin
            @(posedge clk);
            rst=1'b1;
            @(posedge clk);
            rst=1'b0;
        end
    endtask
    task tin(input a);
        begin
            @(posedge clk);
            t=a;
        end
     endtask
     initial begin
        rst_dut();
        tin(0);
        tin(1);
        tin(1);
        tin(0);
        #10;
        $finish;
      end
endmodule
