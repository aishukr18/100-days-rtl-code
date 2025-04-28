module deco_4_16(
    input [3:0] d,
    input en,
    output [15:0] y
);

assign y[0]  = en & ~d[3] & ~d[2] & ~d[1] & ~d[0];
assign y[1]  = en & ~d[3] & ~d[2] & ~d[1] &  d[0];
assign y[2]  = en & ~d[3] & ~d[2] &  d[1] & ~d[0];
assign y[3]  = en & ~d[3] & ~d[2] &  d[1] &  d[0];
assign y[4]  = en & ~d[3] &  d[2] & ~d[1] & ~d[0];
assign y[5]  = en & ~d[3] &  d[2] & ~d[1] &  d[0];
assign y[6]  = en & ~d[3] &  d[2] &  d[1] & ~d[0];
assign y[7]  = en & ~d[3] &  d[2] &  d[1] &  d[0];
assign y[8]  = en &  d[3] & ~d[2] & ~d[1] & ~d[0];
assign y[9]  = en &  d[3] & ~d[2] & ~d[1] &  d[0];
assign y[10] = en &  d[3] & ~d[2] &  d[1] & ~d[0];
assign y[11] = en &  d[3] & ~d[2] &  d[1] &  d[0];
assign y[12] = en &  d[3] &  d[2] & ~d[1] & ~d[0];
assign y[13] = en &  d[3] &  d[2]
