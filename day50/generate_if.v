//fulladder
module full_adder(
    input a, b, cin,
    output sum, cout
);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | (b & cin) | (a & cin);

endmodule


//RCA
module ripple_carry_adder #(parameter N = 8)(
    input [N-1:0] a,
    input [N-1:0] b,
    input cin,
    output [N-1:0] sum,
    output cout
);

wire [N:0] carry;
assign carry[0] = cin;

genvar i;
generate
  for (i = 0; i < N; i = i + 1) begin : fa_chain
    full_adder fa (
      .a(a[i]), 
      .b(b[i]), 
      .cin(carry[i]), 
      .sum(sum[i]), 
      .cout(carry[i+1])
    );
  end
endgenerate

assign cout = carry[N];

endmodule
//carry_lookahead_adder
module carry_lookahead_adder #(parameter N = 4)(
    input [N-1:0] a,
    input [N-1:0] b,
    input cin,
    output [N-1:0] sum,
    output cout
);

wire [N-1:0] p, g;
wire [N:0] c;

assign c[0] = cin;

assign p = a ^ b;   // propagate
assign g = a & b;   // generate

// Carry generation
assign c[1] = g[0] | (p[0] & c[0]);
assign c[2] = g[1] | (p[1] & c[1]);
assign c[3] = g[2] | (p[2] & c[2]);
assign c[4] = g[3] | (p[3] & c[3]);

// Sum bits
assign sum = p ^ c[N-1:0];
assign cout = c[N];

endmodule

//top module
module generate_if #(parameter N = 8, parameter USE_CLA = 0)(
    input [N-1:0] a,
    input [N-1:0] b,
    input cin,
    output [N-1:0] sum,
    output cout
);

generate
  if (USE_CLA) begin
    carry_lookahead_adder #(N) cla_inst (
      .a(a), .b(b), .cin(cin), .sum(sum), .cout(cout)
    );
  end else begin
    ripple_carry_adder #(N) rca_inst (
      .a(a), .b(b), .cin(cin), .sum(sum), .cout(cout)
    );
  end
endgenerate
endmodule
