module hw2prob3
  (input logic a, b, c, d,
  output logic l_assign, l_assign_min, l_case, l_casez);

  assign l_assign = {a, b, c, d} == 4'd0 || {a, b, c, d} == 4'd2 || {a, b, c, d} == 4'd4
          || {a, b, c, d} == 4'd6 || {a, b, c, d} == 4'd7 || {a, b, d, d} == 4'd10
          || {a, b, c, d} == 4'd13 || {a, b, c, d} == 4'd5 || {a, b, c, d} == 4'd8
          || {a, b, c, d} == 4'd15;

  assign l_assign_min = {b, d} == 2'b11 || {a, d} == 2'b00 || {a, b, d} == 3'b100;

  always_comb
    unique case ({a, b, c, d})
      4'd0: l_case = 1;
      4'd2: l_case = 1;
      4'd4: l_case = 1;
      4'd6: l_case = 1;
      4'd7: l_case = 1;
      4'd10: l_case = 1;
      4'd13: l_case = 1;
      default: l_case = 0;
    endcase
  
  always_comb
    unique casez ({a, b, c, d})
      4'b?1?1: l_casez = 1;
      4'b0??0: l_casez = 1;
      4'b10?0: l_casez  = 1;
      default: l_casez = 0;
    endcase

endmodule : hw2prob3

module hw2prob3_test;
  logic [3:0] vector;
  logic l_assign, l_assign_min, l_case, l_casez;

  hw2prob3 DUT (.a(vector[3]),
                .b(vector[2]),
                .c(vector[1]),
                .d(vector[0]),
                .l_assign(l_assign),
                .l_assign_min(l_assign_min),
                .l_case(l_case),
                .l_casez(l_casez));

  initial begin
    $monitor($time,,
      "a = %b, b = %b, c = %b, d = %b, l1 = %b, l2 = %b, l3 = %b, l4 = %b",
      vector[3], vector[2], vector[1], vector[0], l_assign, l_assign_min, l_case, l_casez);
    for (vector = 4'b0000; vector < 4'b1111; vector++)
      #1;
    #1 $finish;
  end

endmodule : hw2prob3_test
