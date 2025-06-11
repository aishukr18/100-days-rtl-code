module ram_8x16_tb();
    reg we, en;
    reg [2:0] addr;
    wire [15:0] data;
    reg [15:0] temp;
    reg [15:0] expected_data;

    ram_8x16 dut(.we(we), .en(en), .addr(addr), .data(data));

    assign data = (we && en) ? temp : 16'bz;

    initial begin
        $monitor("Time=%0t: addr=%b we=%b en=%b data=%h", 
                 $time, addr, we, en, data);
    end

    task write(input [2:0] a, input [15:0] data_temp);
        begin
            we = 1'b1;
            en = 1'b1;
            addr = a;
            temp = data_temp;
            #10;
            we = 1'b0;      // Deassert write
            temp = 16'bz;   // Release data bus
            #5;
            $display("Write: addr=%h, data=%h", a, data_temp);
        end
    endtask

    // Read task with verification
    task read(input [2:0] a, input [15:0] expected);
        begin
            we = 1'b0;
            en = 1'b1;
            addr = a;
            expected_data = expected;
            #10;
            if (data === expected)
                $display("Read PASS: addr=%h, got=%h, expected=%h", 
                         a, data, expected);
            else
                $display("Read FAIL: addr=%h, got=%h, expected=%h", 
                         a, data, expected);
        end
    endtask

   
    initial begin
        we = 0;
        en = 0;
        addr = 0;
        temp = 16'bz;

        // Test 1: Write then read same location
        write(3'b111, 16'h1234);
        read(3'b111, 16'h1234);

        // Test 2: Write different values
        write(3'b010, 16'hABCD);
        read(3'b010, 16'hABCD);

        // Test 3: Read uninitialized location
        read(3'b000, 16'h0000);

        #10 $finish;
    end
endmodule
