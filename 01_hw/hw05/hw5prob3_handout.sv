`default_nettype none
module hw5prob3
  (input  logic gym, trainer,
   input  logic clock, reset,
   output logic got_em_all);

  enum {Grotle, Ekans, Snivy} state, nextState;

  always_ff @(posedge clock, posedge reset)
    if (reset)
      state <= Grotle;
    else
      state <= nextState;

  // next state generator
  always_comb 
    case (state)
      Ekans: nextState = Snivy;
      Snivy: nextState = (gym == 1'b0) ? Grotle : Snivy;
      default: nextState = (gym == trainer) ? Snivy : Ekans;
    endcase
  
  // Output Generator
  always_comb 
    case (state)
      Ekans: got_em_all = 1'b0;
      Snivy: got_em_all = ~gym;
      default: got_em_all = trainer;
    endcase

endmodule : hw5prob3

