`default_nettype none

module dFlipFlop(
  output logic q,
  input  logic d, clock, reset);

  always_ff @(posedge clock)
    if (reset == 1'b1)
      q <= 0;
    else
      q <= d;

endmodule : dFlipFlop

//  --------------------------------------------------------
// |        |  Q1  Q0  |  desciption
// | -------|----------|------------------------------------
// | State1 |   0   0  |  computer #5
// | State2 |   0   1  |  computer #1, #5;     human #6
// | State3 |   1   0  |  computer #1, #3, #5; human #6, #9
// | State4 |   1   1  |  computer win
//  --------------------------------------------------------

module myExplicitFSM(
  output logic [3:0] cMove,
  output logic       win,
  output logic       q0, q1, q2,
  input  logic [3:0] hMove,
  input  logic       clock, reset);

  logic d1, d2;

  // flip-flops instantiation
  dFlipFlop ff0(.d(d0)),
            ff1(.d(d1));

  // next state generation
  assign d0 = ;
  assign d1 = ;

  // output logic generation
  assign cMove = ;
  assign win = d0 & d1;

endmodule : myExplicitFSM

