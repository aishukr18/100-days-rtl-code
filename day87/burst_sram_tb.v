module tb_burst_mode_sram;

    reg clk;
    reg cs;
    reg we;
    reg [3:0] addr;
    reg [3:0] burst_len;
    reg [7:0] data_in;
    wire [7:0] data_out;

    // Instantiate DUT
    burst_mode_sram uut (
        .clk(clk),
        .cs(cs),
        .we(we),
        .addr(addr),
        .burst_len(burst_len),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Task for burst write
    task burst_write(input [3:0] start_addr, input [3:0] len, input [7:0] base_data);
        integer i;
        begin
            addr = start_addr;
            burst_len = len;
            data_in = base_data;
            cs = 1;
            we = 1;
            @(posedge clk);  // Start burst
            cs = 1;
            we = 1;
            for (i = 0; i < len; i = i + 1) begin
                @(posedge clk);
            end
            cs = 0;
            we = 0;
            @(posedge clk);
        end
    endtask

    // Task for burst read
    task burst_read(input [3:0] start_addr, input [3:0] len);
        integer i;
        begin
            addr = start_addr;
            burst_len = len;
            cs = 1;
            we = 0;
            @(posedge clk);  // Start burst
            cs = 1;
            we = 0;
            for (i = 0; i < len; i = i + 1) begin
                @(posedge clk);
                $display("Read [%0d] = %h", start_addr + i, data_out);
            end
            cs = 0;
            @(posedge clk);
        end
    endtask

    initial begin
        // Initialize
        clk = 0; cs = 0; we = 0; addr = 0; burst_len = 0; data_in = 0;

        #10;

        // Test Case 1: Burst write of 4 bytes with value 0xA0
        burst_write(4'd2, 4'd4, 8'hA0);
        burst_read(4'd2, 4'd4);

        // Test Case 2: Burst write of 3 bytes with value 0xB1
        burst_write(4'd6, 4'd3, 8'hB1);
        burst_read(4'd6, 4'd3);

        // Test Case 3: Burst write of 1 byte with value 0xC2
        burst_write(4'd10, 4'd1, 8'hC2);
        burst_read(4'd10, 4'd1);

        // Test Case 4: Burst write of 5 bytes with value 0xD3
        burst_write(4'd0, 4'd5, 8'hD3);
        burst_read(4'd0, 4'd5);

        // Test Case 5: Burst write of 6 bytes with value 0xE4
        burst_write(4'd9, 4'd6, 8'hE4);
        burst_read(4'd9, 4'd6);

        $finish;
    end
endmodule
