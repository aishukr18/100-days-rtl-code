module deco_4_16_tb();
    reg [3:0] d;
    reg en;
    wire [15:0] y;
    integer i;

    deco_4_16 uut (
        .d(d),
        .en(en),
        .y(y)
    );

    initial begin
        $display("Time | Enable | Input | Output");
        $monitor("%4t | %b | %b | %b", $time, en, d, y);

        en = 0;
        d = 4'b0000; #10;
        d = 4'b0011; #10;
        d = 4'b1111; #10;
        
        en = 1;
        for (i = 0; i < 16; i = i + 1) begin
            d = i;
            #10;
        end
        $finish;
    end
endmodule
