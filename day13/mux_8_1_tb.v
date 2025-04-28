module mux8_1_tb();
    reg s0, s1, s2;
    reg i0, i1, i2, i3, i4, i5, i6, i7;
    wire y;
    integer i;

    mux8_1 dut(y,s0,s1,s2,i0,i1,i2,i3,i4,i5,i6,i7);

    initial begin
        {i7,i6,i5,i4,i3,i2,i1,i0} = 8'b1001_1100;
    end

    initial begin
        $monitor("Time = %0t | s2s1s0 = %b | y = %b", $time, {s2,s1,s0}, y);
        for(i=0;i<8;i=i+1) begin
            {s2,s1,s0} = i;
            #10;
        end
        #100 $finish;
    end
endmodule
