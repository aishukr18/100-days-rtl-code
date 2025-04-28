module fulladder_tb();
    reg a, b, cin;
    wire sum, cout;
    integer i;

    fulladder dut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        {a, b, cin} = 0;
    end

    initial begin
        for (i = 0; i < 8; i = i + 1) begin
            {a, b, cin} = i;
            #10;
        end
        #100 $finish;
    end

    initial begin
        $monitor("values of a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
    end
endmodule
