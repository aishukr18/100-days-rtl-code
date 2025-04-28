module mux_2_1_case_tb();
    reg i0, i1, sel;
    wire y;

    mux_2_1_case dut(.i0(i0), .i1(i1), .sel(sel), .y(y));

    initial begin
        i0 = 0; i1 = 1;
        sel = 0; #10;
        sel = 1; #10;

        i0 = 1; i1 = 0; sel = 0; #10;
        sel = 1; #10;

        i0 = 0; i1 = 0; sel = 0; #10;
        sel = 1; #10;

        i0 = 1; i1 = 1; sel = 0; #10;
        sel = 1; #10;

        $finish;
    end
endmodule
