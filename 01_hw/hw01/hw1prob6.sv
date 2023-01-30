`default_nettype none
module circuit(
  input  logic a, b, c, d,
  output logic f);

  logic notB, notC, notD;
  logic f1, f2;

  not     g1(notB, b);
  not     g2(notC, c);
  not     g3(notD, d);

  and #2 g4(f1, b, notC, d),
         g5(f2, notB, notD);

  or  #2 g6(f, f1, f2, a);

endmodule: circuit


module testbench();
  logic f;
  logic [3:0] vector;

  circuit dut(.f(f),
              .a(vector[3]),
              .b(vector[2]),
              .c(vector[1]),
              .d(vector[0])
              );

  initial begin
    $monitor("A: %b B: %b C: %b D: %b F: %b at time %d", vector[3], vector[2], vector[1], vector[0], f, $time);
          vector[3] = 0;
          vector[2] = 0;
          vector[1] = 0;
          vector[0] = 0;

      #20 vector[3] = 0;
          vector[2] = 0;
          vector[1] = 0;
          vector[0] = 1;

      #20 vector[3] = 0;
          vector[2] = 0;
          vector[1] = 1;
          vector[0] = 0;

      #20 vector[3] = 0;
          vector[2] = 0;
          vector[1] = 1;
          vector[0] = 1;

      #20 vector[3] = 0;
          vector[2] = 1;
          vector[1] = 0;
          vector[0] = 0;

      #20 vector[3] = 0;
          vector[2] = 1;
          vector[1] = 0;
          vector[0] = 1;

      #20 vector[3] = 0;
          vector[2] = 1;
          vector[1] = 1;
          vector[0] = 0;

      #20 vector[3] = 0;
          vector[2] = 1;
          vector[1] = 1;
          vector[0] = 1;

      #20 vector[3] = 1;
          vector[2] = 0;
          vector[1] = 0;
          vector[0] = 0;

      #20 vector[3] = 1;
          vector[2] = 0;
          vector[1] = 0;
          vector[0] = 1;

      #20 vector[3] = 1;
          vector[2] = 0;
          vector[1] = 1;
          vector[0] = 0;

      #20 vector[3] = 1;
          vector[2] = 0;
          vector[1] = 1;
          vector[0] = 1;

      #20 vector[3] = 1;
          vector[2] = 1;
          vector[1] = 0;
          vector[0] = 0;

      #20 vector[3] = 1;
          vector[2] = 1;
          vector[1] = 0;
          vector[0] = 1;

      #20 vector[3] = 1;
          vector[2] = 1;
          vector[1] = 1;
          vector[0] = 0;

      #20 vector[3] = 1;
          vector[2] = 1;
          vector[1] = 1;
          vector[0] = 1;

      #20 $finish;
  end

endmodule: testbench
