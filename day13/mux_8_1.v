module mux8_1(output y, input s0,s1,s2,i0,i1,i2,i3,i4,i5,i6,i7);
    wire w0,w1,w2,w3,w4,w5,w6,w7;

    decoder3_8 d1(.d0(w0),.d1(w1),.d2(w2),.d3(w3),.d4(w4),.d5(w5),.d6(w6),.d7(w7),.s0(s0),.s1(s1),.s2(s2));
    
    bufif1 (y, i0, w0);
    bufif1 (y, i1, w1);
    bufif1 (y, i2, w2);
    bufif1 (y, i3, w3);
    bufif1 (y, i4, w4);
    bufif1 (y, i5, w5);
    bufif1 (y, i6, w6);
    bufif1 (y, i7, w7);
endmodule
