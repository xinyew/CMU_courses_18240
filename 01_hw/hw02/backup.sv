`default_nettype none

module SevenSegmentDisplay
  (input  logic [3:0] BCD7, BCD6, BCD5, BCD4, BCD3, BCD2, BCD1, BCD0,
   input  logic [7:0] blank,
   output logic [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);

  always_comb begin
    HEX0 = 7'b0000000;
    if (~blank[0])
      case (BCD0)
        4'd0: HEX0 = 7'b0111111;
        4'd1: HEX0 = 7'b0000110;
        4'd2: HEX0 = 7'b1011011;
        4'd3: HEX0 = 7'b1001111;
        4'd4: HEX0 = 7'b1100110;
        4'd5: HEX0 = 7'b1101101;
        4'd6: HEX0 = 7'b1111101;
        4'd7: HEX0 = 7'b0000111;
        4'd8: HEX0 = 7'b1111111;
        4'd9: HEX0 = 7'b1101111;
        default: HEX0 = 7'b0000000;
      endcase
    HEX0 = ~HEX0;
  end

  always_comb begin
    HEX1 = 7'b0000000;
    if (~blank[1])
      case (BCD1)
        4'd0: HEX1 = 7'b0111111;
        4'd1: HEX1 = 7'b0000110;
        4'd2: HEX1 = 7'b1011011;
        4'd3: HEX1 = 7'b1001111;
        4'd4: HEX1 = 7'b1100110;
        4'd5: HEX1 = 7'b1101101;
        4'd6: HEX1 = 7'b1111101;
        4'd7: HEX1 = 7'b0000111;
        4'd8: HEX1 = 7'b1111111;
        4'd9: HEX1 = 7'b1101111;
        default: HEX1 = 7'b0000000;
      endcase
    HEX1 = ~HEX1;
  end

  always_comb begin
    HEX2 = 7'b0000000;
    if (~blank[2])
      case (BCD2)
        4'd0: HEX2 = 7'b0111111;
        4'd1: HEX2 = 7'b0000110;
        4'd2: HEX2 = 7'b1011011;
        4'd3: HEX2 = 7'b1001111;
        4'd4: HEX2 = 7'b1100110;
        4'd5: HEX2 = 7'b1101101;
        4'd6: HEX2 = 7'b1111101;
        4'd7: HEX2 = 7'b0000111;
        4'd8: HEX2 = 7'b1111111;
        4'd9: HEX2 = 7'b1101111;
        default: HEX2 = 7'b0000000;
      endcase
    HEX2 = ~HEX2;
  end

  always_comb begin
    HEX3 = 7'b0000000;
    if (~blank[3])
      case (BCD3)
        4'd0: HEX3 = 7'b0111111;
        4'd1: HEX3 = 7'b0000110;
        4'd2: HEX3 = 7'b1011011;
        4'd3: HEX3 = 7'b1001111;
        4'd4: HEX3 = 7'b1100110;
        4'd5: HEX3 = 7'b1101101;
        4'd6: HEX3 = 7'b1111101;
        4'd7: HEX3 = 7'b0000111;
        4'd8: HEX3 = 7'b1111111;
        4'd9: HEX3 = 7'b1101111;
        default: HEX3 = 7'b0000000;
      endcase
    HEX3 = ~HEX3;
  end

  always_comb begin
    HEX4 = 7'b0000000;
    if (~blank[4])
      case (BCD4)
        4'd0: HEX4 = 7'b0111111;
        4'd1: HEX4 = 7'b0000110;
        4'd2: HEX4 = 7'b1011011;
        4'd3: HEX4 = 7'b1001111;
        4'd4: HEX4 = 7'b1100110;
        4'd5: HEX4 = 7'b1101101;
        4'd6: HEX4 = 7'b1111101;
        4'd7: HEX4 = 7'b0000111;
        4'd8: HEX4 = 7'b1111111;
        4'd9: HEX4 = 7'b1101111;
        default: HEX4 = 7'b0000000;
      endcase
    HEX4 = ~HEX4;
  end

  always_comb begin
    HEX5 = 7'b0000000;
    if (~blank[5])
      case (BCD5)
        4'd0: HEX5 = 7'b0111111;
        4'd1: HEX5 = 7'b0000110;
        4'd2: HEX5 = 7'b1011011;
        4'd3: HEX5 = 7'b1001111;
        4'd4: HEX5 = 7'b1100110;
        4'd5: HEX5 = 7'b1101101;
        4'd6: HEX5 = 7'b1111101;
        4'd7: HEX5 = 7'b0000111;
        4'd8: HEX5 = 7'b1111111;
        4'd9: HEX5 = 7'b1101111;
        default: HEX5 = 7'b0000000;
      endcase
    HEX5 = ~HEX5;
  end

  always_comb begin
    HEX6 = 7'b0000000;
    if (~blank[6])
      case (BCD6)
        4'd0: HEX6 = 7'b0111111;
        4'd1: HEX6 = 7'b0000110;
        4'd2: HEX6 = 7'b1011011;
        4'd3: HEX6 = 7'b1001111;
        4'd4: HEX6 = 7'b1100110;
        4'd5: HEX6 = 7'b1101101;
        4'd6: HEX6 = 7'b1111101;
        4'd7: HEX6 = 7'b0000111;
        4'd8: HEX6 = 7'b1111111;
        4'd9: HEX6 = 7'b1101111;
        default: HEX6 = 7'b0000000;
      endcase
    HEX6 = ~HEX6;
  end

  always_comb begin
    HEX7 = 7'b0000000;
    if (~blank[7])
      case (BCD7)
        4'd0: HEX7 = 7'b0111111;
        4'd1: HEX7 = 7'b0000110;
        4'd2: HEX7 = 7'b1011011;
        4'd3: HEX7 = 7'b1001111;
        4'd4: HEX7 = 7'b1100110;
        4'd5: HEX7 = 7'b1101101;
        4'd6: HEX7 = 7'b1111101;
        4'd7: HEX7 = 7'b0000111;
        4'd8: HEX7 = 7'b1111111;
        4'd9: HEX7 = 7'b1101111;
        default: HEX7 = 7'b0000000;
      endcase
    HEX7 = ~HEX7;
  end

endmodule : SevenSegmentDisplay
