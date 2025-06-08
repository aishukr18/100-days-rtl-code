module fibonacci_tb();
    reg clock, reset;
    wire [31:0]value;
    
    fibonacci dut(clock, reset, value);
    initial
        begin
            reset=1;
            #10 reset=0;
        end
    initial
        begin
            clock=0;
            forever
            #10 clock=~clock;
        end
    initial
        begin
        #350 $finish;
    end
endmodule
