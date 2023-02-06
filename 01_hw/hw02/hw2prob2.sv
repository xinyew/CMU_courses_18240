module hw2prob2
  (input  logic a, b ,c , d,
    output logic f, g, h);

  always_comb
    case ({a, b, c})
      3'd1: f = 1;
      3'd3: f = 1;
      3'd4: f = 1;
      default: f = 0;
    endcase

  always_comb begin
    if ({a, b, c, d} == 4'd1 || {a, b, c, d} == 4'd3
     || {a, b, c, d} == 4'd5 || {a, b, c, d} == 4'd12)
      g = 0;
    else
      g = 1;
  end

  assign h = ({b, d} == 2'b11 || {c, d} == 2'b01 || {a, b, c} == 3'b000
           || {a, b, c} == 3'b011 || {b, c, d} == 3'b010) | 0;

endmodule : hw2prob2

module hw2prob2_test;
  logic [3:0] vector;
  logic f, g, h;

  hw2prob2 DUT (.a(vector[3]),
                .b(vector[2]),
                .c(vector[1]),
                .d(vector[0]),
                .f(f),
                .g(g),
                .h(h));

  initial begin
    $monitor($time,,
      "a = %b, b = %b, c = %b, d = %b, f = %b, g = %b, h = %b",
      vector[3], vector[2], vector[1], vector[0], f, g, h);
    for (vector = 4'b0000; vector < 4'b1111; vector++)
      #1;
    #1 $finish;
  end

endmodule : hw2prob2_test
