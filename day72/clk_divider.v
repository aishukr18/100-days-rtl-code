module divider(input freq_src_clk, reset, output freq_new_clk);
    reg [3:0] count_posedge;
    reg a1, a2;

    always @(posedge freq_src_clk)
    begin
        if (reset)
            count_posedge <= 0;
        else
        begin
            if (count_posedge == 8)
                count_posedge <= 0;
            else
                count_posedge <= count_posedge + 1;
        end
    end

    always @(posedge freq_src_clk)
    begin
        if (count_posedge == 0 || count_posedge == 1)
            a1 <= 1;
        else
            a1 <= 0;
    end

    always @(negedge freq_src_clk)
    begin
        if (count_posedge == 5 || count_posedge == 6)
            a2 <= 1;
        else
            a2 <= 0;
    end

    assign freq_new_clk = a1 | a2;
endmodule
