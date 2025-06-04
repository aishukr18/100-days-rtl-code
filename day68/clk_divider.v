module clk_divider(clk_40_40,clk_20_20,clk_20_40, src_clk,reset);
    input src_clk, reset;
    output clk_40_40,clk_20_20,clk_20_40;
    reg[2:0]count_posedge;
    reg a1,a2,a3;
    always@(posedge src_clk)
        begin
            if(reset)
                count_posedge <= 0;
            else
                begin
                    if(count_posedge == 4)
                        count_posedge <= 0;
                    else
                        count_posedge <= count_posedge + 1;
                end
        end
    always@(posedge src_clk)
        begin
            if(count_posedge == 0)
                a1 <= 1;
            else
                a1 <= 0;
        end
    always@(negedge src_clk)
        begin
            if(count_posedge == 3)
                a2 <= 1;
            else
                a2 <= 0;
        end
    always@(posedge src_clk)
        begin
            if(count_posedge == 0 ||count_posedge == 1)
                a3 <= 1;
                else
                a3 <= 0;
         end 
    assign clk_40_40 = a1 | a2;
    assign clk_20_20 = a1;
    assign clk_20_40 = a3;
endmodule
