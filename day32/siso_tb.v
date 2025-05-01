module siso_tb();
    reg clk,rst,sin;
    wire sout;
    siso dut( .clk(clk),.rst(rst),.sin(sin),.sout(sout));
    initial begin
    clk=1'b0;
    sin=0;
    rst=0;
    forever #10 clk= ~clk;
    end
    //always #10 clk= ~clk;
    task rst_dut();
    begin
    @(negedge clk);
    rst=1'b1;
    @(negedge clk);
    rst=1'b0;
    end
    endtask
    task s_in(input a);
    begin
    @(negedge clk);
    sin=a;
    end
    endtask
    initial begin
    rst_dut();
    s_in(1);
    s_in(0);
    s_in(1);
    s_in(1);
    s_in(0);
    #100 $finish;
    end
endmodule
