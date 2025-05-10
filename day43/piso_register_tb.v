module piso_tb();
    reg clk;
    reg reset;
    reg load;
    reg [3:0] data_in;
    wire data_out;

    piso dut (.clk(clk),.reset(reset),.load(load),.data_in(data_in),.data_out(data_out));

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        load = 0;
        data_in = 4'b0000;

        #10;
        reset = 0;

        // Load a value
        #10;
        data_in = 4'b1101;
        load = 1;

        #10;
        load = 0;

        // Observe serial output over next few clocks
        #50;

        // Load another value
        data_in = 4'b1010;
        load = 1;

        #10;
        load = 0;

        #50;

        $finish;
    end

endmodule
