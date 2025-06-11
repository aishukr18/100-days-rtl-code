module rom_16x16_tb();
    reg [3:0] address;
    wire [15:0] data;

    // Instantiate the ROM module
    rom_16x16 dut (.address(address),.data(data));

    integer i;

    initial begin
        $display("=== ROM_16x16 Testbench Output ===");
        for (i = 0; i < 16; i = i + 1) begin
            address = i;
            #10;  // Small delay to observe changes
            $display("Address = %0d (%b), Data = %016b", address, address, data);
        end
        $finish;
    end

endmodule
