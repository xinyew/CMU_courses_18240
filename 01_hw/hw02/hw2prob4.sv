`default_nettype none
module hw2prob4
  (input  logic a, b, c, d, e,
   output logic m, n);

  assign m = a ^ (b + c & (~d));
  always_comb
    case ({a, b, c, d, e})
      5'd0: n = 0;
      5'd1: n = 0;
      5'd2: n = 0;
      5'd3: n = 0;
      5'd5: n = 0;
      5'd9: n = 0;
      5'd16: n = 0;
      5'd17: n = 0;
      5'd22: n = 0;
      5'd25: n = 0;
      5'd27: n = 0;
      default: n = 1;
    endcase

endmodule : hw2prob4

module hw2prob4_test;
  logic [4:0] vector;
  logic m, n;

  hw2prob4 DUT (.a(vector[4]),
                .b(vector[3]),
                .c(vector[2]),
                .d(vector[1]),
                .e(vector[0]),
                .m(m),
                .n(n));

  initial begin
    $monitor($time,,
      "a = %b, b = %b, c = %b, d = %b, e = %b, m = %b, n = %b",
      vector[4], vector[3], vector[2], vector[1], vector[0], m, n);
    for (vector = 5'b00000; vector < 5'b11111; vector++)
      #1;
    #1 $finish;
  end

endmodule : hw2prob4_test
