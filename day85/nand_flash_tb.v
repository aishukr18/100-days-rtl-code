module testbench;

    reg clk;
    reg we;
    reg re;
    reg erase;
    reg [7:0] address;
    reg [7:0] data_in;
    wire [7:0] data_out;

    nand_flash_memory uut (
        .clk(clk),
        .we(we),
        .re(re),
        .erase(erase),
        .address(address),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    task write(input [7:0] addr, input [7:0] data);
    begin
        @(posedge clk);
        we = 1; re = 0; erase = 0;
        address = addr;
        data_in = data;
        @(posedge clk);
        we = 0;
    end
    endtask

    task read(input [7:0] addr);
    begin
        @(posedge clk);
        re = 1; we = 0; erase = 0;
        address = addr;
        @(posedge clk);
        $display("Read from address %h: %h", addr, data_out);
        re = 0;
    end
    endtask

    task erase_memory();
    begin
        @(posedge clk);
        erase = 1; we = 0; re = 0;
        @(posedge clk);
        erase = 0;
        $display("Memory erased!");
    end
    endtask

    task read_write_same_cycle(input [7:0] addr, input [7:0] data);
    begin
        @(posedge clk);
        we = 1; re = 1; erase = 0;
        address = addr;
        data_in = data;
        @(posedge clk);
        we = 0; re = 0;
        $display("Simultaneous Read/Write at address %h: wrote %h, read %h", addr, data, data_out);
    end
    endtask

    initial begin
        clk = 0;
        we = 0;
        re = 0;
        erase = 0;
        address = 0;
        data_in = 0;

        #5;

        // Write and read operations
        write(8'h01, 8'hAB);
        read(8'h01);
        write(8'h02, 8'hCD);
        read(8'h02);
        write(8'h03, 8'hEF);
        read(8'h03);
      
        erase_memory();

        // Read after erase (should be zero)
        read(8'h01);
        read(8'h02);

        // Simultaneous read and write
        read_write_same_cycle(8'h04, 8'h55);
        read(8'h04); // Check if write happened

        $display("Testbench completed.");
        #10 $finish;
    end

endmodule
