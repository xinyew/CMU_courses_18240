`default_nettype none

module BusDriver
 #(parameter WIDTH = 8)
  (input  logic en,
   input  logic [WIDTH-1:0] data,
   output logic [WIDTH-1:0] buff,
   inout  tri   [WIDTH-1:0] bus
   );

   assign bus = (en) ? data : 'bz;
   assign buff = bus;

endmodule : BusDriver

module Memory
 #(parameter DW = 16,
             W  = 256,
             AW = $clog2(W))
  (input  logic re, we, clock,
   input  logic [AW-1:0] addr,
   inout  tri   [DW-1:0] data);

  logic [DW-1:0] M[W];
  logic [DW-1:0] rData;

  assign data = (re) ? rData : 'bz;

  always_ff @(posedge clock)
    if (we)
      M[addr] <= data;
  
  always_comb
    rData = M[addr];

endmodule : Memory


`default_nettype none

// Magnitude comparator
module MagComp
 #(parameter WIDTH = 16)
  (input  logic [WIDTH-1:0] A, B,
   output logic AltB, AeqB, AgtB);

  assign AltB = A < B;
  assign AeqB = A == B;
  assign AgtB = A > B;

endmodule : MagComp

// Adder
module Adder
 #(parameter WIDTH = 16)
  (input  logic cin,
   input  logic [WIDTH-1:0] A, B,
   output logic [WIDTH-1:0] S,
   output logic cout);

  assign {cout, S} = A + B + cin;

endmodule : Adder

// Mux
module Multiplexer
 #(parameter WIDTH = 16)
  (input  logic [WIDTH-1:0] I,
   input  logic [$clog2(WIDTH)-1:0] S,
   output logic Y);

  assign Y = I[S];

endmodule : Multiplexer

// Mux2to1
module Mux2to1
 #(parameter WIDTH = 16)
  (input  logic [WIDTH-1:0] I0, I1,
   input  logic S,
   output logic [WIDTH-1:0] Y);

   assign Y = S ? I1 : I0;

endmodule : Mux2to1

// Decoder
module Decoder
 #(parameter WIDTH = 16)
  (input  logic [$clog2(WIDTH)-1:0] I,
   input  logic en,
   output logic [WIDTH-1:0] D);

  assign D = en ? 1'b1 << I : 1'b0;

endmodule : Decoder

// DFlipFlop
module DFlipFlop
  (input  logic D,
   input  logic clock, preset_L, reset_L,
   output logic Q);

  always_ff @(posedge clock, negedge reset_L, negedge preset_L)
    // when reset_L and preset_L asserted at the same time, output x
    if (~reset_L && ~preset_L)
      Q <= 1'bx;
    else if (~reset_L)
      Q <= 1'b0;
    else if (~preset_L)
      Q <= 1'b1;
    else
      Q <= D;

endmodule : DFlipFlop

// Register
module Register
 #(parameter WIDTH = 16)
  (input  logic en, clear, clock,
   input  logic [WIDTH-1:0] D,
   output logic [WIDTH-1:0] Q);

  always_ff @(posedge clock)
    if (en)
      Q <= D;
    else if (clear)
      Q <= 1'b0;

endmodule : Register

// Counter
module Counter
 #(parameter WIDTH = 16)
  (input  logic en, clear, load, up, clock,
   input  logic [WIDTH-1:0] D,
   output logic [WIDTH-1:0] Q);

  always_ff @(posedge clock)
    if (clear)
      Q <= 1'b0;
    else if (load)
      Q <= D;
    else if (en) begin
      if (up)
        Q <= Q + 1;
      else
        Q <= Q - 1;
    end

endmodule : Counter

// Sync
module Synchronizer
  (input  logic async, clock,
   output logic sync);

  always_ff @(posedge clock)
    sync <= async;

endmodule : Synchronizer

// ShiftRegister_SIPO
module ShiftRegister_SIPO
 #(parameter WIDTH = 16)
  (input  logic serial, en, left, clock,
   output logic [WIDTH-1:0] Q);

  always_ff @(posedge clock)
    if (en) begin
      if (left)
        Q <= {Q[WIDTH-2:0], serial};
      else
        Q <= {serial, Q[WIDTH-1:1]};
    end

endmodule : ShiftRegister_SIPO

// ShiftRegister_PIPO
module ShiftRegister_PIPO
 #(parameter WIDTH = 16)
  (input  logic en, left, load, clock,
   input  logic [WIDTH-1:0] D,
   output logic [WIDTH-1:0] Q);

  always_ff @(posedge clock)
    if (load)
      Q <= D;
    else if (en) begin
      if (left)
        Q <= Q << 1;
      else
        Q <= Q >> 1;
    end

endmodule : ShiftRegister_PIPO

// BarrelShiftRegister
module BarrelShiftRegister
 #(parameter WIDTH = 16)
  (input  logic en, load, clock,
   input  logic [1:0] by,
   input  logic [WIDTH-1:0] D,
   output logic [WIDTH-1:0] Q);

  always_ff @(posedge clock)
    if (load)
      Q <= D;
    else if (en) begin
      Q <= Q << by;
    end

endmodule : BarrelShiftRegister
