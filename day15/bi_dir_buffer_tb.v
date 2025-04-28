module bi_dir_buffer_tb();
    reg ctrl;
    reg a_dir, b_dir;
    wire a, b;

    assign a = (ctrl == 0) ? a_dir : 1'bz;
    assign b = (ctrl == 1) ? b_dir : 1'bz;

    bi_dir_buffer uut (.a(a), .b(b), .ctrl(ctrl));

    initial begin
        $monitor("Time = %0t | ctrl = %b | a = %b | b = %b", $time, ctrl, a, b);

        // Case 1: Drive from a to b (ctrl = 0)
        ctrl = 0;
        a_dir = 1;
        b_dir = 1'bz;
        #10;
        a_dir = 0;
        #10;

        // Case 2: Drive from b to a (ctrl = 1)
        ctrl = 1;
        a_dir = 1'bz;
        b_dir = 1;
        #10;
        b_dir = 0;
        #10;

        // Case 3: Disable both drivers (Z-state)
        ctrl = 0;
        a_dir = 1'bz;
        b_dir = 1'bz;
        #10;

        $finish;
    end
endmodule
