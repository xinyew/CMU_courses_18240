`default_nettype none
module hw1prob2
  (output logic f,
   input logic a, b, c);

  logic f1, f2, f3, f4, f5, f6, f5_not, c_not;

  and  (f, f1, f2, f3), (f5, a, c);
  or   (f1, b, f4),
       (f3, b, f5_not),
       (f2, b, f6);
  nand (f4, c_not, c_not);
  not  (c_not, c),
       (f5_not, f5);
  xnor (f6, a, c);

endmodule: hw1prob2
