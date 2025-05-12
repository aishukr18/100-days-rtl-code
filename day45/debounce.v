module debounce(
    input clk,
    input rst,     
    input noisy_in,      // raw button input
    output reg clean_out // debounced output
);
    reg [15:0] count;
    reg sync_0, sync_1;
    reg debounced;

    // Synchronize the input to avoid metastability
    always @(posedge clk) begin
        sync_0 <= noisy_in;
        sync_1 <= sync_0;
    end

    // Debounce logic
    always @(posedge clk) begin
        if (rst) begin
            count <= 0;
            debounced <= 0;
        end else if (sync_1 == debounced) begin
            count <= 0;
        end else begin
            count <= count + 1;
            if (count == 16'hFFFF)
                debounced <= sync_1;
        end
    end

    always @(posedge clk) begin
        clean_out <= debounced;
    end

endmodule
