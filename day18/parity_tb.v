module parity_tb();
    reg [3:0] data;
    wire parity;
    wire error;

    parity_generator pg (
        .data_in(data),
        .parity_bit(parity)
    );

    parity_checker pc (
        .data_in(data),
        .parity_bit(parity),
        .error(error)
    );

    initial begin
        $display("Data\tParity\tError");
        
        data = 4'b1010; #10;
        $display("%b\t%b\t%b", data, parity, error);
        
        data = 4'b1110; #10;
        $display("%b\t%b\t%b", data, parity, error);

        data = 4'b0001; #10;
        $display("%b\t%b\t%b", data, parity, error);

        data = 4'b1001; #10;
        $display("%b\t%b\t%b", data, parity, error);

        $finish;
    end
endmodule
