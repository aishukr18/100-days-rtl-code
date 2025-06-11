module ram_8x16(
    input we,          
    input en,          
    input [2:0] addr,  
    inout [15:0] data  // Bidirectional 16-bit data bus
);
    
    reg [15:0] mem [0:7];  // 8 locations of 16-bit memory
    
    integer i;
    initial begin
        for(i = 0; i < 8; i = i + 1)
            mem[i] = 16'b0;
    end
    
    always @(we or en or addr or data) begin
        if(we && en)         // Conventional active-high for both enables
            mem[addr] <= data;
    end
    
    // Read operation
    assign data = (!we && en) ? mem[addr] : 16'bz;
    
endmodule
