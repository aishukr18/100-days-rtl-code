module siso(input clk,rst,sin,output sout);
    reg [2:0]temp;
    always@(posedge clk)
    begin
        if(rst)
            temp=3'b000;
        else
        begin
            temp[2]<=sin;
            temp[1]<=temp[2];
            temp[0]<=temp[1];
            end
    end
    assign sout=temp[0];
endmodule
