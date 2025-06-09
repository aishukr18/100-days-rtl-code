module fifo_16x8_tb;
    reg clk, we, re, rst;
    reg [3:0] w_addr, r_addr;
    reg [7:0] data_in;
    wire [7:0] data_out;
    
    integer i;
    
    fifo_16x8 dut (
        .clk(clk),
        .rst(rst),
        .we(we),
        .re(re),
        .w_addr(w_addr),
        .r_addr(r_addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    // Reset task
    task rst_dut();
        begin
            @(negedge clk);
            rst = 1;
            we = 0; re = 0;
            @(negedge clk);
            rst = 0;
        end
    endtask

    // Data write task
    task data_write(input [7:0] val, input [3:0] addr);
        begin
            @(negedge clk);
            data_in = val;
            w_addr = addr;
            we = 1;
            @(negedge clk);
            we = 0;
        end
    endtask

    // Data read task with check
    task data_read_and_check(input [3:0] addr, input [7:0] expected);
        begin
            @(negedge clk);
            r_addr = addr;
            re = 1;
            @(negedge clk);  // Wait for output to settle on next posedge clk
            re = 0;

            @(posedge clk);  // Allow time for data_out to latch

            if (data_out === expected)
                $display("✅ PASS: Addr = %0d, Data = %0h", addr, data_out);
            else
                $display(" FAIL: Addr = %0d, Expected = %0h, Got = %0h", addr, expected, data_out);
        end
    endtask

    // Test sequence
    initial begin
        // Initialize all signals
        rst = 0; we = 0; re = 0;
        w_addr = 0; r_addr = 0;
        data_in = 0;

        rst_dut();  // Reset the design

        // Write: Store each address as the data
        for (i = 0; i < 16; i = i + 1) begin
            data_write(i[7:0], i[3:0]);
        end

        // Read and check
        for (i = 0; i < 16; i = i + 1) begin
            data_read_and_check(i[3:0], i[7:0]);
        end

        #20;
        $display("Test completed.");
        $finish;
    end

endmodule
