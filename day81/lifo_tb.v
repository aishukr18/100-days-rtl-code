module LIFO_16_8_tb();

    reg clock, reset, write_en, read_en;
    wire empty, full;
    reg [7:0] data_in;
    wire [7:0] data_out;
    
    LIFO_16_8 DUT(clock, reset, write_en,read_en, data_in, empty, full,data_out);
    task initialize();
        begin
            clock = 1'b0;
            reset = 1'b0;
            write_en = 1'b0;
            read_en = 1'b0;
        end
    endtask
    
    always #10 clock = ~clock;
    
    task reset_dut();
        begin
            @(negedge clock);
            reset = 1'b0;
            @(negedge clock);
            reset = 1'b1;
        end
    endtask
    
    task write_LIFO(input [7:0] data);
        begin
            @(negedge clock)
            write_en = 1'b1;
            data_in = data;
        end
    endtask
    
    task read_LIFO();
        begin
            @(negedge clock)
            read_en = 1'b1;
            end
        endtask
    task delay();
        begin
            #50;
        end
    endtask
        
    initial
        begin
            initialize;
            delay;
            reset_dut;
            repeat(17) //repeating to write all locations
            write_LIFO({$random}%8);
            write_en = 1'b0;
            repeat(17) //repeating to read all locations
            read_LIFO();
            read_en = 1'b0;
            repeat (16)
            write_LIFO({$random}%256);
            $finish;
        end 
    initial
    $monitor("data_in = %0d, data_out = %0d", data_in, data_out);
endmodule
