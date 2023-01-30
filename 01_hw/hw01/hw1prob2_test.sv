`default_nettype none

module hw1prob2_test
  (output logic a, b, c,
   input logic out);

  initial begin
    $monitor($time,
      "a = %b, b = %b, c = %b, out = %b",
      a, b, c, out);
        a = 0;
        b = 0;
        c = 0;

     #10 c = 1;
     #10 b = 1;
     #10 a = 1;
     #10 c = 0;
     #10 b = 0;
     #10 c = 1;

     #10 a = 0;
         b = 1;
         c = 0;
     #10 $finish;
  end
endmodule: hw1prob2_test


module system();
  logic wire_a, wire_b, wire_c, test_out;

  hw1prob2 DUT (.a(wire_a),
                .b(wire_b),
                .c(wire_c),
                .f(test_out));

  hw1prob2_test mt (.a(wire_a),
                    .b(wire_b),
                    .c(wire_c),
                    .out(test_out));

endmodule: system
