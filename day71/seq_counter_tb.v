odule seq_counter_tb();
    reg clk;
    reg rst;
    wire [2:0] out;

    seq_counter dut (.clk(clk),.rst(rst),.out(out));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        #10;
        rst = 0;

        #100;

        $finish;
    end
    always @(posedge clk) begin
        $display("Time = %0t | Output = %b", $time, out);
    end

endmodule
