module mux_2_1_if(input i0, i1, sel, output reg y);
    always @(sel)
    begin
        if (sel == 0)
            y = i0;
        else
            y = i1;
    end
endmodule
