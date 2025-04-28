module sr_latch_tb();
reg enable,s,r;
wire q,qb;
sr_latch dut(.s(s),.r(r),.enable(enable),.q(q),.qb(qb));
initial begin
        enable = 0; s = 0; r = 0; #10;
        //SET
        enable = 1; s = 1; r = 0; #10;
        //  HOLD
        s = 0; r = 0; #10;
        // RESET
        s = 0; r = 1; #10;
        //  HOLD
        s = 0; r = 0; #10;
        // INVALID
        s = 1; r = 1; #10;
        // Enable = 0 => HOLD (No matter what s and r are)
        s=0;r=0;#10;
        //enable = 0; s = 1; r = 0; #10;
        //enable = 0; s = 0; r = 1; #10;

        $finish;
    end
endmodule
