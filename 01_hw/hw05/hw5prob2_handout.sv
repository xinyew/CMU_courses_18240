`default_nettype none
/* A FSM that does something nonsensical */
module hw5prob2
  (input  logic hue, value,
   input  logic clock, reset_n,
   output logic water);

  enum {Gold, Red, Blue, Green, Pink} state, nextState;

  always_ff @(posedge clock, negedge reset_n)
    if (~reset_n)
      state <= Red;
    else
      state <= nextState;

  // next state generator
  always_comb 
    case (state)
      Gold: nextState = Green;
      Blue: nextState = Blue;
      Pink: if ({hue, value} == 2'b00)
              nextState = Blue;
            else
              nextState = Green;
      Green: nextState = (hue == 1'b1) ? Green : Red;
      default: case ({hue, value})
                 2'b01 : nextState = Gold;
                 2'b10 : nextState = Blue;
                 default : nextState = Pink;
               endcase
    endcase
  
  // Output Generator
  assign water = (state == Blue) || (state == Green);

endmodule : hw5prob2

