module tb_CAM;

    parameter WIDTH = 8;
    parameter DEPTH = 16;

    reg [WIDTH-1:0] data_in;
    reg wr_en, clk, rst;
    wire [DEPTH-1:0] match;
    integer i;

    CAM #(WIDTH, DEPTH) cam_inst (
        .data_in(data_in),
        .wr_en(wr_en),
        .clk(clk),
        .rst(rst),
        .match(match)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        wr_en = 0;
        data_in = 0;

        #10 rst = 0;

        // Write unique data into CAM ===
        $display("\n=== Writing unique data to CAM ===");
        wr_en = 1;
        data_in = 8'h3F; #10;
        data_in = 8'h7A; #10;
        data_in = 8'hC3; #10;
        data_in = 8'h4B; #10;
        wr_en = 0;

        // Search for data written
        $display("\n=== Searching for stored data ===");
        data_in = 8'h3F; #10;
        data_in = 8'hC3; #10;
        data_in = 8'hAA; // Not stored
        #10;

        // Search when CAM is empty 
        $display("\n=== Searching in empty CAM ===");
        rst = 1; #10 rst = 0;
        data_in = 8'h77; #10;

        //  Writing duplicate data
        $display("\n=== Writing duplicate data ===");
        wr_en = 1;
        data_in = 8'h55; #10;
        data_in = 8'h55; #10;
        wr_en = 0;

        $display("\n=== Searching duplicate data ===");
        data_in = 8'h55; #10;

        //  Fill entire CAM 
        $display("\n=== Filling the entire CAM ===");
        wr_en = 1;
        for (i = 0; i < DEPTH; i = i + 1) begin
            data_in = i;
            #10;
        end
        wr_en = 0;

        //  Write after CAM is full
        $display("\n=== Writing after CAM is full ===");
        wr_en = 1;
        data_in = 8'hEE; #10;
        wr_en = 0;

        // Search value at last index 
        $display("\n=== Search for last value in CAM ===");
        data_in = DEPTH - 1; #10;

        #20 $finish;
    end

    initial begin
        $monitor("Time=%0t | wr_en=%b | data_in=%h | match=%b", 
                  $time, wr_en, data_in, match);
    end

endmodule
