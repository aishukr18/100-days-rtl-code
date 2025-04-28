module universal_shift_reg_tb();
    reg clk, rst;
    reg [3:0] din;
    reg s0, s1, s_right_din, s_left_din;
    wire [3:0] dout;

    universal_shift_reg uut(.clk(clk),.rst(rst),.din(din),.s0(s0),.s1(s1),.s_right_din(s_right_din),.s_left_din(s_left_din),.dout(dout));

    initial begin
        clk = 0;
    end
    always #5 clk = ~clk; 

    initial begin
        // Initialize inputs
        rst = 1;
        s0 = 0; s1 = 0;
        din = 4'b0000;
        s_right_din = 0;
        s_left_din = 0;

        #15; // hold reset for a while
        rst = 0; // Release reset

        // Parallel load (s1s0 = 11)
        #3; // Small delay before changing inputs
        s1 = 1; s0 = 1;
        din = 4'b1011; // din_3=1, din_2=0, din_1=1, din_0=1
        #10; // Wait one clock

        // Hold (s1s0 = 00)
        #3;
        s1 = 0; s0 = 0;
        #10;

        // Shift right (s1s0 = 01)
        #3;
        s1 = 0; s0 = 1;
        s_right_din = 1; // Serial input for right shift
        #10;

        // Shift left (s1s0 = 10)
        #3;
        s1 = 1; s0 = 0;
        s_left_din = 0; // Serial input for left shift
        #10;

        // Shift right again
        #3;
        s1 = 0; s0 = 1;
        s_right_din = 0;
        #10;

        $finish; // End simulation
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | rst=%b | s1s0=%b%b | din=%b | dout=%b",
                  $time, rst, s1, s0, din, dout);
    end
endmodule
