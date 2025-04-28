module bi_dir_buffer(inout a, b, input ctrl);

bufif0 b1(b, a, ctrl);
bufif1 b2(a, b, ctrl);

endmodule
