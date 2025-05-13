`define SIZE 8
module fa_generate_for(
    input[(`SIZE -1) : 0]a,
    input[(`SIZE -1) : 0]b,
    input cin,
    output[(`SIZE -1) : 0]sum,
    output cout);

wire[(`SIZE -2) : 0]w;
genvar i;
fulladder fa1(a[0],b[0],cin,sum[0],w[0]);
generate for(i=1;i<(`SIZE-1);i=i+1)
begin:full_adder
    fulladder fa2(a[i],b[i],w[(i-1)],sum[i],w[i]);
end
endgenerate 
fulladder fa3(a[`SIZE -1],b[`SIZE-1],w[`SIZE-2],sum[`SIZE -1],cout);

endmodule
