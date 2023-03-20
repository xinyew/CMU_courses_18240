`default_nettype none

module MagComp_test();
  logic [3:0] A, B;
  logic AltB, AeqB, AgtB;

  MagComp #(4) DUT (.*);

  initial begin
    $monitor($time,, "A: %b | B: %b | AltB: %b | AeqB: %b | AgtB: %b",
             A, B, AltB, AeqB, AgtB);
    #0 A = 4'd15;
       B = 4'd0;
    #5 A = 4'd0;
    #5 B = 4'd15;
    #1 $finish;
  end

endmodule : MagComp_test

module Adder_test();
  logic cin, cout;
  logic [3:0] A, B, S;

  Adder #(4) DUT (.*);

  initial begin
    $monitor($time,, "A: %b | B: %b | cin: %b | S: %b | cout: %b",
             A, B, cin, S, cout);
    #0 A = 4'd10;
       B = 4'd2;
       cin = 1'd0;
    #5 B = 4'd5;
    #5 cin = 1'd1;
    #5 B = 4'd10;
    #1 $finish;
  end

endmodule : Adder_test

module Multiplexer_test();
  logic [3:0] I;
  logic [1:0] S;
  logic Y;

  Multiplexer #(4) DUT (.*);

  initial begin
    $monitor($time,, "I: %b | S: %b | Y: %b",
             I, S, Y);
    #0 I = 4'd10;
       S = 2'd0;
    #5 S = 2'd1;
    #5 S = 2'd2;
    #5 S = 2'd3;
    #1 $finish;
  end

endmodule : Multiplexer_test

module Mux2to1_test();
  logic[3:0] I0, I1, Y;
  logic S;

  Mux2to1 #(4) DUT (.*);

  initial begin
    $monitor($time,, "I0: %b | I1: %b | S: %b | Y: %b",
            I0, I1, S, Y);
    #0 I0 = 4'd15;
       I1 = 4'd0;
       S = 1'b0;
    #5 S = 1'b1;
    #1 $finish;
  end

endmodule : Mux2to1_test

module Decoder_test();
  logic [1:0] I;
  logic en;
  logic [3:0] D;

  Decoder #(4) DUT (.*);

  initial begin
    $monitor($time,, "I: %b | en: %b | D: %b",
             I, en, D);
    #0 I = 2'd0;
       en = 1'b1;
    #5 I = 2'd3;
    #5 en = 1'b0;
    #1 $finish;
  end

endmodule : Decoder_test

module DFlipFlop_test();
  logic D, Q, clock, preset_L, reset_L;

  DFlipFlop DUT (.*);

  initial begin
    clock = 1'b0;
    forever #10 clock = ~clock;
  end

  initial begin
    $monitor($time,, "D: %b | preset_L: %b | reset_L: %b | Q: %b",
             D, preset_L, reset_L, Q);
    D <= 1'b1;
    preset_L <= 1'b1;
    reset_L <= 1'b1;
    @(posedge clock);
    reset_L <= 1'b0;
    @(posedge clock);
    reset_L <= 1'b1;
    D <= 1'b0;
    preset_L <= 1'b0;
    @(posedge clock);
    #1 $finish;
  end

endmodule : DFlipFlop_test


module Register_test();
  logic [3:0] D, Q;
  logic en, clear, clock;

  Register #(4) DUT (.*);

  initial begin
    clock = 1'b0;
    forever #10 clock = ~clock;
  end

  initial begin
    $monitor($time,, "en: %b | clear: %b | D: %b | Q: %b",
             en, clear, D, Q);
    D <= 4'd1;
    en <= 1'b1;
    clear <= 1'b0;
    @(posedge clock);
    D <= 4'd15;
    en <= 1'b0;
    @(posedge clock);
    en <= 1'b1;
    @(posedge clock);
    D <= 4'd10;
    en <= 1'b1;
    clear <= 1'b1;
    @(posedge clock);
    en <= 1'b0;
    @(posedge clock);
    #1 $finish;
  end

endmodule : Register_test

module Counter_test();
  logic en, clear, load, up, clock;
  logic [3:0] D, Q;

  Counter #(4) DUT (.*);

  initial begin
    clock = 1'b0;
    forever #10 clock = ~clock;
  end

  initial begin
    $monitor($time,, "D: %b | en: %b | clr: %b | load: %b | up: %b | Q: %b",
             D, en, clear, load, up, Q);
    D <= 4'd10;
    en <= 1'b1;
    clear <= 1'b0;
    load <= 1'b1;
    up <= 1'b1;
    @(posedge clock);
    load <= 1'b0;
    @(posedge clock);
    up <= 1'b0;
    @(posedge clock);
    en <= 1'b0;
    @(posedge clock);
    en <= 1'b1;
    load <= 1'b1;
    D <= 4'd1;
    clear <= 1'd1;
    @(posedge clock);
    #1 $finish;
  end

endmodule : Counter_test;

module Synchronizer_test();
  logic async, clock, sync;

  Synchronizer DUT (.*);

  initial begin
    clock = 1'b0;
    forever #10 clock = ~clock;
  end

  initial begin
    $monitor($time,, "async: %b | sync: %b",
             async, sync);
    #0 async = 1'b1;
    #1 async = 1'b0;
    #1 async = 1'b1;
    @(posedge clock);
    #1 async = 1'b0;
    @(posedge clock);
    #1 $finish;
  end
endmodule : Synchronizer_test

module ShiftRegister_SIPO_test();
  logic serial, en, left, clock;
  logic [3:0] Q;

  ShiftRegister_SIPO #(4) DUT (.*);

  initial begin
    clock = 1'b0;
    forever #10 clock = ~clock;
  end

  initial begin
    $monitor($time,, "serial: %b | en: %b | left: %b | Q: %b",
             serial, en, left, Q);
    serial <= 1'b1;
    en <= 1'b0;
    left <= 1'b1;
    @(posedge clock);
    en <= 1'b1;
    @(posedge clock);
    @(posedge clock);
    @(posedge clock);
    left <= 1'b0;
    @(posedge clock);
    @(posedge clock);
    en <= 1'b0;
    @(posedge clock);
    @(posedge clock);
    #1 $finish;
  end

endmodule : ShiftRegister_SIPO_test

module ShiftRegister_PIPO_test();
  logic en, left, load, clock;
  logic [3:0] D, Q;

  ShiftRegister_PIPO #(4) DUT (.*);

  initial begin
    clock = 1'b0;
    forever #10 clock = ~clock;
  end

  initial begin
    $monitor($time,, "D: %b | en: %b | left: %b | load: %b | Q: %b",
             D, en, left, load, Q);
    D <= 4'd10;
    load <= 1'b0;
    left <= 1'b1;
    en <= 1'b0;
    @(posedge clock);
    load <= 1'b1;
    @(posedge clock);
    en <= 1'b1;
    @(posedge clock);
    load <= 1'b0;
    @(posedge clock);
    @(posedge clock);
    left <= 1'b0;
    @(posedge clock);
    @(posedge clock);
    #1 $finish;
  end

endmodule : ShiftRegister_PIPO_test

module BarrelShiftRegister_test();
  logic en, load, clock;
  logic [1:0] by;
  logic [3:0] D, Q;

  BarrelShiftRegister #(4) DUT (.*);

  initial begin
    clock = 1'b0;
    forever #10 clock = ~clock;
  end

  initial begin
    D <= 1'd1;
    en <= 1'b0;
    load <= 1'b0;
    by <= 2'd1;
    @(posedge clock);
    load <= 1'b1;
    @(posedge clock);
    en <= 1'b1;
    @(posedge clock);
    load <= 1'b0;
    @(posedge clock);
    @(posedge clock);
    #1 $finish;
  end

endmodule : BarrelShiftRegister_test
