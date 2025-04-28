module mux_2_1_if_tb();
    reg i0, i1, sel;
    wire y;

    mux_2_1_if dut(.i0(i0), .i1(i1), .sel(sel), .y(y));

    initial begin
        $monitor("Time=%0t sel=%b i0=%b i1=%b y=%b", $time, sel, i0, i1, y);

        // Test cases
        i0 = 0; i1 = 1;
        sel = 0; #10;  // Select i0
        sel = 1; #10;  // Select i1

        $finish;
    end
endmodule
