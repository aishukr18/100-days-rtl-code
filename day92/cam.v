module CAM #(parameter WIDTH = 8, DEPTH = 16) (
    input [WIDTH-1:0] data_in,
    input wr_en, clk, rst,
    output reg [DEPTH-1:0] match
);

    reg [WIDTH-1:0] memory [0:DEPTH-1];
    integer i;
    reg data_written;

    // Writing 
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < DEPTH; i = i + 1)
                memory[i] <= {WIDTH{1'b0}}; // Clear memory on reset
        end
        else if (wr_en) begin
            data_written <= 0;
            for (i = 0; i < DEPTH; i = i + 1) begin
                if (!data_written && memory[i] == {WIDTH{1'b0}}) begin
                    memory[i] <= data_in;
                    data_written <= 1;
                end
            end
        end
    end

    // Searching for data in CAM memory
    always @(*) begin
        match = {DEPTH{1'b0}}; // Default: no match
        for (i = 0; i < DEPTH; i = i + 1) begin
            if (memory[i] == data_in)
                match[i] = 1;
        end
    end

endmodule
