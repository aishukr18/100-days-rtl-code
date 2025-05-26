module zero_detect(
    input  [7:0] data_in,
    output is_nonzero
);
    assign is_nonzero = |data_in;  // OR reduction to detect non-zero

endmodule
