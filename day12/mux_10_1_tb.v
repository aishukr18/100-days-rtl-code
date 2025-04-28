module mux_10_1_tb();
    reg y0,y1,y2,y3,y4,y5,y6,y7,y8,y9;
    reg s0,s1,s2,s3;
    wire out;
    integer i;

    mux_10_1 dut (y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,s0,s1,s2,s3,out);

    initial begin
        {y9,y8,y7,y6,y5,y4,y3,y2,y1,y0} = 10'b00_0000_1111;
    end

    initial begin
        for(i = 0; i < 10; i = i + 1) begin
            {s0,s1,s2,s3} = i;
            #10;
        end
        $finish;
    end
endmodule
