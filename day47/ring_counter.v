// 2-bit counter module
module counter_2bit (
    input clk,
    input rst,
    output reg [1:0] count
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 2'b00;
        else
            count <= count + 1;
    end
endmodule

// 2-to-4 decoder module
module decoder_2to4 (
    input [1:0] in,
    output reg [3:0] out
);
    always @(*) begin
        case (in)
            2'b00: out = 4'b0001;
            2'b01: out = 4'b0010;
            2'b10: out = 4'b0100;
            2'b11: out = 4'b1000;
            default: out = 4'b0000;
        endcase
    end
endmodule

// Top module for Ring Counter
module ring_counter (
    input clk,
    input rst,
    output [3:0] ring_out
);
    wire [1:0] count;

    // Instantiate the 2-bit counter
    counter_2bit u1 (.clk(clk),.rst(rst),.count(count));

    // Instantiate the 2-to-4 decoder
    decoder_2to4 u2 (.in(count),.out(ring_out));
endmodule
