`default_nettype none

// button debouncing circuit
module hw5prob6
  (input  logic button,
   input  logic clock, reset,
   output logic debounced);

  // enum of all 14 states
  enum logic [3:0] {
                    SAW0 = 4'd0, STABLE1_01 = 4'd1, STABLE1_02 = 4'd2,
                    STABLE1_03 = 4'd3, STABLE1_04 = 4'd4, STABLE1_05 = 4'd5,
                    STABLE1_06 = 4'd6, STABLE1_07 = 4'd7, STABLE1_08 = 4'd8,
                    STABLE1_09 = 4'd9, STABLE1_10 = 4'd10, STABLE1_11 = 4'd11,
                    STABLE1_12 = 4'd12, FINAL_STABLE1 = 4'd13
  } state, nextState;

  // async reset FF block
  always_ff @(posedge clock, posedge reset)
    if (reset)
      state <= SAW0;
    else
      state <= nextState;

  // next state logic
  always_comb
    unique case (state)
      SAW0:           nextState = (button) ? STABLE1_01 : SAW0;
      STABLE1_01:     nextState = STABLE1_02;
      STABLE1_02:     nextState = STABLE1_03;
      STABLE1_03:     nextState = STABLE1_04;
      STABLE1_04:     nextState = STABLE1_05;
      STABLE1_05:     nextState = STABLE1_06;
      STABLE1_06:     nextState = STABLE1_07;
      STABLE1_07:     nextState = STABLE1_08;
      STABLE1_08:     nextState = STABLE1_09;
      STABLE1_09:     nextState = STABLE1_10;
      STABLE1_10:     nextState = STABLE1_11;
      STABLE1_11:     nextState = STABLE1_12;
      STABLE1_12:     nextState = FINAL_STABLE1;
      FINAL_STABLE1:  nextState = (button) ? FINAL_STABLE1 : SAW0;
    endcase

  // output logic
  always_comb
    case (state)
      SAW0:    debounced = 0;
      default: debounced = 1;
    endcase

endmodule : hw5prob6
