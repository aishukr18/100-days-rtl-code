module pwm_tb();
    reg clk;
    reg reset;
    reg [7:0] duty;
    wire pwm_out;
    wire [7:0] counter;
    pwm dut (.clk(clk),.reset(reset),.duty(duty),.pwm_out(pwm_out),.counter(counter));

    always #5 clk = ~clk;
    initial begin
        clk = 0;
        reset = 1;
        duty = 0;
 $monitor("Time=%0t | clk=%b | reset=%b | duty=%d | counter=%d | pwm_out=%b", 
                 $time, clk, reset, duty, counter, pwm_out);
        // Reset pulse
        #20;
        reset = 0;

        // Test 25% duty cycle
        duty = 8'd64;
        #3000;

        // Test 50% duty cycle
        duty = 8'd128;
        #3000;

        // Test 75% duty cycle
        duty = 8'd192;
        #3000;

        // Test 100% duty cycle
        duty = 8'd255;
        #3000;

        // Test 0% duty cycle
        duty = 8'd0;
        #3000;

        $finish;
    end

endmodule
