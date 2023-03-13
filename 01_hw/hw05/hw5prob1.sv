`default_nettype none

module DflipflopPR
  (input  logic D,
   input  logic clock, preset_L, reset_L,
   output logic Q);

  always_ff @(posedge clock, negedge reset_L, negedge preset_L)
    if (~reset_L && ~preset_L)
      Q <= 1'bx;
    else if (~reset_L)
      Q <= 1'b0;
    else if (~preset_L)
      Q <= 1'b1;
    else
      Q <= D;

endmodule : DflipflopPR

module DflipflopPR_test();

  logic clock, reset_L, preset_L, D, Q;
  DflipflopPR dut(.D(D),
                  .Q(Q),
                  .clock(clock),
                  .reset_L(reset_L),
                  .preset_L(preset_L));

  // clock wave
  initial begin
        clock = 1'b0;
    #10 clock = ~clock;
    #20 clock = ~clock;
    #20 clock = ~clock;
    #10 clock = ~clock;
    #10 clock = ~clock;
    #10 clock = ~clock;
    #10 clock = ~clock;
  end

  // reset_L wave
  initial begin
        reset_L = 1'b0;
    #5  reset_L = ~reset_L;
    #15 reset_L = ~reset_L;
    #5  reset_L = ~reset_L;
    #30 reset_L = ~reset_L;
    #5  reset_L = ~reset_L;
    #5  reset_L = ~reset_L;
    #15 reset_L = ~reset_L;
  end

  // preset_L wave
  initial begin
        preset_L = 1'b1;
    #35 preset_L = ~preset_L;
    #5  preset_L = ~preset_L;
    #45 preset_L = ~preset_L;
  end

  // D wave
  initial begin
    $monitor($time,, "D = %b, Q = %b, reset_L = %b, preset_L = %b",
             D, Q, reset_L, preset_L);
    // initial values
    D = 1'b0;
    // waveform
    #5  D = ~D;
    #10 D = ~D;
    #5  D = ~D;
    #5  D = ~D;
    #10 D = ~D;
    #10 D = ~D;
    #10 D = ~D;
    #20 D = ~D;
    #10 D = ~D;
    #10 D = ~D;
    #5  $finish;
  end
endmodule : DflipflopPR_test
