`default_nettype none
module Decoder
  (input  logic en,
   input  logic [2:0] I,
   output logic [7:0] D);

  always_comb begin
    unique case (I)
      3'b000: D = 8'b00000001;
      3'b001: D = 8'b00000010;
      3'b010: D = 8'b00000100;
      3'b011: D = 8'b00001000;
      3'b100: D = 8'b00010000;
      3'b101: D = 8'b00100000;
      3'b110: D = 8'b01000000;
      3'b111: D = 8'b10000000;
    endcase
    D = en ? D : 0;
  end

endmodule : Decoder

module BarrelShifter
  (input  logic [15:0] v,
   input  logic [3:0] by,
   output logic [15:0] s);

  always_comb begin
    s = by[3] ? v << 8 : v;
    s = by[2] ? s << 4 : s;
    s = by[1] ? s << 2 : s;
    s = by[0] ? s << 1 : s;
  end

endmodule : BarrelShifter

module Multiplexer
  (input  logic [7:0] I,
   input  logic [2:0] s,
   output logic Y);

  always_comb 
    case (s)
      3'b000: Y = I[0];
      3'b001: Y = I[1];
      3'b010: Y = I[2];
      3'b011: Y = I[3];
      3'b100: Y = I[4];
      3'b101: Y = I[5];
      3'b110: Y = I[6];
      3'b111: Y = I[7];
    endcase
    
endmodule: Multiplexer

module Mux2to1
  (input  logic [6:0] I0,
   input  logic [6:0] I1,
   input  logic S,
   output logic [6:0] Y);

  always_comb
    case (S)
      0: Y = I0;
      1: Y = I1;
    endcase

endmodule : Mux2to1

module MagComparator
  (input  logic [7:0] A,
   input  logic [7:0] B,
   output logic AltB,
   output logic AeqB,
   output logic AgtB);

   assign AltB = A < B;
   assign AgtB = A > B;
   assign AeqB = A == B;

endmodule : MagComparator

module Comparator
  (input  logic [3:0] A,
   input  logic [3:0] B,
   output logic AeqB);

   assign AeqB = A == B;

endmodule : Comparator

module Adder
  (input logic [4:0] A,
   input logic [4:0] B,
   input logic cin,
   output logic cout,
   output logic [4:0] sum);

  assign {cout, sum} = A + B + cin;
endmodule : Adder
