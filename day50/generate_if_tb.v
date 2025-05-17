module generate_if_tb();

  // Parameters
  parameter N = 4;
  reg [N-1:0] a;
  reg [N-1:0] b;
  reg cin;
  wire [N-1:0] sum_rca, sum_cla;
  wire cout_rca, cout_cla;

  generate_if #(N, 0) uut_rca (.a(a),.b(b),.cin(cin),.sum(sum_rca),.cout(cout_rca));

  // Instantiate CLA version (USE_CLA = 1)
  generate_if #(N, 1) uut_cla (.a(a),.b(b),.cin(cin),.sum(sum_cla),.cout(cout_cla));

  initial begin
    $display("Time\t a\t b\t cin | sum_rca cout_rca | sum_cla cout_cla");

    a = 4'b0001; b = 4'b0010; cin = 0; #10;
    $display("%0t\t%b\t%b\t%b   |  %b\t   %b   |  %b\t   %b", $time, a, b, cin, sum_rca, cout_rca, sum_cla, cout_cla);

    a = 4'b0111; b = 4'b0001; cin = 0; #10;
    $display("%0t\t%b\t%b\t%b   |  %b\t   %b   |  %b\t   %b", $time, a, b, cin, sum_rca, cout_rca, sum_cla, cout_cla);

    a = 4'b1111; b = 4'b0001; cin = 1; #10;
    $display("%0t\t%b\t%b\t%b   |  %b\t   %b   |  %b\t   %b", $time, a, b, cin, sum_rca, cout_rca, sum_cla, cout_cla);

    a = 4'b1010; b = 4'b0101; cin = 1; #10;
    $display("%0t\t%b\t%b\t%b   |  %b\t   %b   |  %b\t   %b", $time, a, b, cin, sum_rca, cout_rca, sum_cla, cout_cla);

    $finish;
  end

endmodule
