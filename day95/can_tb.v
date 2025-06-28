module can_controller_tb;
    reg clk;
    reg reset;
    reg [7:0] data_in;
    reg tx_req;
    wire [7:0] data_out;
    wire tx_done;
    wire can_tx;
    reg can_rx;

    can_controller uut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .tx_req(tx_req),
        .data_out(data_out),
        .tx_done(tx_done),
        .can_tx(can_tx),
        .can_rx(can_rx)
    );

    // Clock: 100MHz -> 10ns period
    always #5 clk = ~clk;

    initial begin

        // === Initial Setup ===
        clk = 0;
        reset = 1;
        tx_req = 0;
        data_in = 8'h00;
        can_rx = 1;  // Idle state

        #20 reset = 0;

        @(posedge clk);
        data_in = 8'hA5;
        tx_req = 1;
        @(posedge clk);
        tx_req = 0;

        repeat (8) begin
            @(posedge clk);
            can_rx = can_tx; // Loopback simulation
        end

        #20;

        data_in = 8'h3C;
        tx_req = 1;
        @(posedge clk);
        tx_req = 0;

        repeat (8) begin
            @(posedge clk);
            can_rx = can_tx;
        end

        #20;

        data_in = 8'hFF;
        tx_req = 1;
        @(posedge clk);
        tx_req = 0;

        repeat (4) begin
            @(posedge clk);
            can_rx = can_tx;
        end

        data_in = 8'h00;
        tx_req = 1;
        @(posedge clk);
        tx_req = 0;

        repeat (4) begin
            @(posedge clk);
            can_rx = can_tx;
        end

        #30;

        can_rx = 0; // unexpected low
        repeat (4) @(posedge clk);
        can_rx = 1;
        repeat (4) @(posedge clk);

        #50;
        $finish;
    end

    always @(posedge clk) begin
        $display("Time=%0t | TX_DONE=%b | CAN_TX=%b | CAN_RX=%b | DATA_OUT=%h", 
                  $time, tx_done, can_tx, can_rx, data_out);
    end
endmodule
