module mux_10_1(input y0,y1,y2,y3,y4,y5,y6,y7,y8,y9, input s0,s1,s2,s3, output out );
    wire w1, w2, w3;

    mux_4_1 m1(.out(w1), .y0(y0), .y1(y1), .y2(y2), .y3(y3), .s0(s0), .s1(s1));
    mux_4_1 m2(.out(w2), .y0(y4), .y1(y5), .y2(y6), .y3(y7), .s0(s0), .s1(s1));
    mux_4_1 m3(.out(w3), .y0(1'b0), .y1(1'b0), .y2(y8), .y3(y9), .s0(s0), .s1(s1));
    mux_4_1 m4(.out(out), .y0(w1), .y1(w2), .y2(w3), .y3(1'b0), .s0(s2), .s1(s3));
endmodule
