module LIFO_16_8(input clock, reset, write_en,read_en,
                 input [7:0] data_in,
                 output empty, full,
                 output reg [7:0]data_out);
    reg [4:0] ptr;
    reg [4:0]lifo_counter;
    reg [7:0] memory [15:0];
    integer i;
    
    assign empty = (lifo_counter==5'b0)?1'b1:1'b0;
    assign full = (lifo_counter > 5'b01111);
    
    always @(posedge clock, negedge reset)
        begin
            if( !reset )
                lifo_counter <= 0;
            else if( !full && write_en )
                lifo_counter <= lifo_counter + 1;
            else if( !empty && read_en )
                lifo_counter <= lifo_counter - 1'b1;
        end
        
    always @(posedge clock, negedge reset)
        begin
            if( !reset )
                begin
                    for(i = 0; i< 16; i=i+1)
                        begin
                            memory[i] <= 0;
                            ptr <= 4'b0;
                        end
                end
            else if((write_en==1'b1) && (full==1'b0))
                begin
                    memory[ptr] <= data_in;
                    ptr <= ptr+1;
                end
        end
    always @(posedge clock, negedge reset)
        begin
            if( !reset )
                begin
                    data_out <= 8'b0;
                end
            else if((read_en==1'b1) && (empty==1'b0)) //reading data
                begin
                    data_out <= memory[ptr-1'b1];
                    ptr <= ptr-1'b1;
                end
        end
endmodule
