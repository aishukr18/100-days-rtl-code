module fibonacci(clock,reset,value);
    input clock,reset;
    output [31:0]value;
    
    reg [31:0]previous,current;
    
    always@(posedge clock,posedge reset)
        begin
            if (reset)
                begin
                    previous <= 32'd0;
                    current <=32'd1;
                end 
            else
                begin
                    current <= current + previous;
                    previous <= current;
                end
        end
   assign value=previous;
endmodule
