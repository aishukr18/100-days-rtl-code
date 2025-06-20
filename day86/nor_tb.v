module testbench;

    reg clk;
    reg we;
    reg re;
    reg [7:0] address;
    reg [7:0] data_in;
    wire [7:0] data_out;

    // DUT instantiation
    nor_flash_memory uut (
        .clk(clk),
        .we(we),
        .re(re),
        .address(address),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Task: Write data to memory
    task write(input [7:0] addr, input [7:0] data);
    begin
        we = 1; re = 0;
        address = addr;
        data_in = data;
        #10;
        we = 0;
    end
    endtask

    // Task: Read data from memory and display
    task read(input [7:0] addr);
    begin
        we = 0; re = 1;
        address = addr;
        #10;
        $display("Read from address %h = %h", addr, data_out);
        re = 0;
    end
    endtask

    // Test sequence
    initial begin
        clk = 0;
        we = 0;
        re = 0;
        address = 8'h00;
        data_in = 8'h00;

        // Write-Read Sequence
        write(8'h01, 8'hAB); read(8'h01);
        write(8'h02, 8'hCD); read(8'h02);
        write(8'h03, 8'hEF); read(8'h03);
        write(8'h04, 8'h12); read(8'h04);
        write(8'h05, 8'h34); read(8'h05);
        write(8'h06, 8'h56); read(8'h06);
        write(8'h07, 8'h78); read(8'h07);

        $display("NOR Flash Test Completed.");
        #10 $finish;
    end

endmodule
