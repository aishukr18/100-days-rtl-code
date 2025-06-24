module memory_controller_tb;

    reg clk;
    reg reset;
    reg [2:0] req;
    wire [2:0] grant;
    wire [1:0] arbiter_state;

    memory_controller uut (
        .clk(clk),
        .reset(reset),
        .req(req),
        .grant(grant),
        .arbiter_state(arbiter_state)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("memory_controller_tb.vcd");
        $dumpvars(0, memory_controller_tb);

        // Initial values
        reset <= 1;
        req   <= 3'b000;
        #10 reset <= 0;

        // -------------------------------
        // Test 1: Only Req0 -> grant 0
        // -------------------------------
        #10 req <= 3'b001;
        #10;

        // -------------------------------
        // Test 2: Only Req1 -> grant 1
        // -------------------------------
        #10 req <= 3'b010;
        #10;

        // -------------------------------
        // Test 3: Only Req2 -> grant 2
        // -------------------------------
        #10 req <= 3'b100;
        #10;

        // -------------------------------
        // Test 4: Req0 + Req1 -> should rotate
        // -------------------------------
        #10 req <= 3'b011;
        #10;

        // -------------------------------
        // Test 5: Req1 + Req2 -> continue round robin
        // -------------------------------
        #10 req <= 3'b110;
        #10;

        // -------------------------------
        // Test 6: All requestors active
        // -------------------------------
        #10 req <= 3'b111;
        #10;

        // -------------------------------
        // Test 7: Only Req0 again
        // -------------------------------
        #10 req <= 3'b001;
        #10;

        // -------------------------------
        // Test 8: No requests
        // -------------------------------
        #10 req <= 3'b000;
        #10;

        #20 $finish;
    end

    initial begin
        $monitor("Time: %0t | clk: %b | reset: %b | req: %b | grant: %b | state: %b",
                 $time, clk, reset, req, grant, arbiter_state);
    end

endmodule
