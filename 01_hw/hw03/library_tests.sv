`default_nettype none
module Decoder_test;
  logic en;
  logic [2:0] I;
  logic [7:0]D;

  Decoder DUT(.en(en),
              .I(I),
              .D(D));

  initial begin
    $monitor($time,,
      "en = %b, I = %b, D = %b", en, I, D);
    en = 1;
    for (I = 3'b000; I < 3'b111; I++)
      #1;
    en = 0;
    for (I = 3'b000; I < 3'b111; I++)
      #1;
    #1 $finish;
  end

endmodule: Decoder_test

module BarrelShifter_test;
  logic [15:0] v;
  logic [3:0] by;
  logic [15:0] s;

  BarrelShifter DUT(.v(v),
                    .by(by),
                    .s(s));

  initial begin
    $monitor($time,,
      "v = %b, by = %b, s = %b", v, by, s);
    v = 16'b0101010101010101;
    for (by = 4'b0000; by < 4'b1111; by++)
      #1;
    #1 $finish;
  end

endmodule : BarrelShifter_test

module Multiplexer_test;
  logic [7:0] I;
  logic [2:0] s;
  logic Y;

  Multiplexer DUT(.I(I),
                  .s(s),
                  .Y(Y));
  
  initial begin
    $monitor($time,,
      "I = %b, s = %b, Y = %b", I, s, Y);
    I = 8'b01010101;
    for (s = 3'b000; s < 3'b111; s++)
      #1;
    #1 $finish;
  end

endmodule : Multiplexer_test

module Mux2to1_test;
  logic [6:0] I0;
  logic [6:0] I1;
  logic S;
  logic [6:0] Y;

  Mux2to1 DUT(.I0(I0),
              .I1(I1),
              .S(S),
              .Y(Y));

  initial begin
    $monitor($time,,
      "I0 = %b, I1 = %b, S = %b, Y = %b", I0, I1, S, Y);
    I0 = 7'b0000000;
    I1 = 7'b1111111;
    S = 0;
    #1 S = 1;
    #1 $finish;
  end

endmodule : Mux2to1_test

module MagComparator_test;
  logic [7:0] A;
  logic [7:0] B;
  logic AltB;
  logic AgtB;
  logic AeqB;

  MagComparator DUT (.A(A),
                     .B(B),
                     .AltB(AltB),
                     .AgtB(AgtB),
                     .AeqB(AeqB));

  initial begin
    $monitor($time,,
    "A = %b, B = %b, AltB = %b, AgtB = %b, AeqB = %b", A, B , AltB, AgtB, AeqB);
    A = 8'b00000000;
    B = 8'b11111111;
    #2 A = 8'b11111111;
    #2 B = 8'b00000000;
    #2 $finish;
  end
  
endmodule : MagComparator_test

module Comparator_test;
  logic [3:0] A;
  logic [3:0] B;
  logic AeqB;

  MagComparator DUT (.A(A),
                     .B(B),
                     .AeqB(AeqB));

  initial begin
    $monitor($time,,
    "A = %b, B = %b, AeqB = %b", A, B, AeqB);
    A = 8'b00000000;
    B = 8'b11111111;
    #2 A = 8'b11111111;
    #2 $finish;
  end
  
endmodule : Comparator_test

module Adder_test;
  logic [4:0] A;
  logic [4:0] B;
  logic [4:0] sum;
  logic cin;
  logic cout;

  Adder DUT (.A(A),
             .B(B),
             .cin(cin),
             .cout(cout),
             .sum(sum));

  initial begin
    $monitor($time,,
    "A = %b, B = %b, cin = %b, sum = %b, cout = %b",
    A, B, cin, sum, cout);
       A = 5'b00000;
       B = 5'b00000;
       cin = 1'b0;
    #2 cin = 1'b1;
    #2 A = 5'b00001;
    #2 B = 5'b00001;
    #2 A = 5'b11111;
       cin = 1'b0;
    #2 cin = 1'b1;
    #2 $finish;
  end

endmodule : Adder_test
