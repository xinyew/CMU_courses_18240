`default_nettype none

module hw1prob5
  (input  logic A, B, C,
   output logic Fsop, Gsop, Fpos, Gpos);

   logic notA, notB, notC;
   logic notA_and_notC, A_and_notB_and_C, A_and_notB_and_notC;
   logic notA_and_notB_and_C, A_and_B_and_C, notA_and_B_and_notC;
   logic A_or_notC, notA_or_C, notB_or_notC, A_or_B_or_C;
   logic notA_or_B_or_notC, A_or_notB_or_notC, notA_or_notB_or_C;

   not    g1(notA, A);
   not    g2(notB, B);
   not    g3(notC, C);

   and #2 g4(notA_and_notC, notA, notC);
   and #2 g5(A_and_notB_and_C, A, notB, C);
   and #2 g6(A_and_notB_and_notC, A, notB, notC);
   and #2 g7(notA_and_notB_and_C, notA, notB, C);
   and #2 g8(A_and_B_and_C, A, B, C);
   and #2 g9(notA_and_B_and_notC, notA, B, notC);

   or  #2 g12(A_or_notC, A, notC);
   or  #2 g13(notA_or_C, notA, C);
   or  #2 g14(notB_or_notC, notB, notC);
   or  #2 g15(A_or_B_or_C, A, B, C);
   or  #2 g16(notA_or_B_or_notC, notA, B, notC);
   or  #2 g17(A_or_notB_or_notC, A, notB, notC);
   or  #2 g18(notA_or_notB_or_C, notA, notB, C);

   or  #2 g10(Fsop, notA_and_notC, A_and_notB_and_C);
   or  #2 g11(Gsop, A_and_notB_and_notC, notA_and_notB_and_C, A_and_B_and_C, notA_and_B_and_notC);

   and #2 g19(Fpos, A_or_notC, notA_or_C, notB_or_notC);
   and #2 g20(Gpos, A_or_B_or_C, notA_or_B_or_notC, A_or_notB_or_notC,notA_or_notB_or_C);

endmodule: hw1prob5
