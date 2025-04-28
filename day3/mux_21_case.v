module mux_2_1_case(input i0, i1, sel, output reg y);
    always @(sel)
    begin
        case (sel)
            1'b0: y = i0;
            1'b1: y = i1;
        endcase
    end
endmodule
