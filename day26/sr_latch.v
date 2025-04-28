module sr_latch(output q,qb,input enable,s,r);
wire s1,r1;
nand n1(s1,s,enable);
nand n2(r1,r,enable);
nand n3(q,s1,qb);
nand n4(qb,r1,q);
endmodule
