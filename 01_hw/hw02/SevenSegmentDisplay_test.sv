`default_nettype none

module SevenSegmentDisplay_test();

  logic [3:0] BCD7, BCD6, BCD5, BCD4, BCD3, BCD2, BCD1, BCD0;
  logic [7:0] blank;
  logic [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

  SevenSegmentDisplay ssd(.*);

  function display_it(logic [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);

    string p00, p01, p02, p03, p04, p05, p06; // 1st digit is HEX number
    string p10, p11, p12, p13, p14, p15, p16; // 2nd digit is segment
    string p20, p21, p22, p23, p24, p25, p26;
    string p30, p31, p32, p33, p34, p35, p36;
    string p40, p41, p42, p43, p44, p45, p46;
    string p50, p51, p52, p53, p54, p55, p56;
    string p60, p61, p62, p63, p64, p65, p66;
    string p70, p71, p72, p73, p74, p75, p76;
    
    p00 = (HEX0[0] === 1'b0) ? " *** " : " ... ";  // If zero, then light something up
    p01 = (HEX0[1] === 1'b0) ? "*" : ".";
    p02 = (HEX0[2] === 1'b0) ? "*" : ".";
    p03 = (HEX0[3] === 1'b0) ? " *** " : " ... ";
    p04 = (HEX0[4] === 1'b0) ? "*" : ".";
    p05 = (HEX0[5] === 1'b0) ? "*" : ".";
    p06 = (HEX0[6] === 1'b0) ? " *** " : " ... ";

    p10 = (HEX1[0] === 1'b0) ? " *** " : " ... ";
    p11 = (HEX1[1] === 1'b0) ? "*" : ".";
    p12 = (HEX1[2] === 1'b0) ? "*" : ".";
    p13 = (HEX1[3] === 1'b0) ? " *** " : " ... ";
    p14 = (HEX1[4] === 1'b0) ? "*" : ".";
    p15 = (HEX1[5] === 1'b0) ? "*" : ".";
    p16 = (HEX1[6] === 1'b0) ? " *** " : " ... ";

    p20 = (HEX2[0] === 1'b0) ? " *** " : " ... ";
    p21 = (HEX2[1] === 1'b0) ? "*" : ".";
    p22 = (HEX2[2] === 1'b0) ? "*" : ".";
    p23 = (HEX2[3] === 1'b0) ? " *** " : " ... ";
    p24 = (HEX2[4] === 1'b0) ? "*" : ".";
    p25 = (HEX2[5] === 1'b0) ? "*" : ".";
    p26 = (HEX2[6] === 1'b0) ? " *** " : " ... ";

    p30 = (HEX3[0] === 1'b0) ? " *** " : " ... ";
    p31 = (HEX3[1] === 1'b0) ? "*" : ".";
    p32 = (HEX3[2] === 1'b0) ? "*" : ".";
    p33 = (HEX3[3] === 1'b0) ? " *** " : " ... ";
    p34 = (HEX3[4] === 1'b0) ? "*" : ".";
    p35 = (HEX3[5] === 1'b0) ? "*" : ".";
    p36 = (HEX3[6] === 1'b0) ? " *** " : " ... ";

    p40 = (HEX4[0] === 1'b0) ? " *** " : " ... ";
    p41 = (HEX4[1] === 1'b0) ? "*" : ".";
    p42 = (HEX4[2] === 1'b0) ? "*" : ".";
    p43 = (HEX4[3] === 1'b0) ? " *** " : " ... ";
    p44 = (HEX4[4] === 1'b0) ? "*" : ".";
    p45 = (HEX4[5] === 1'b0) ? "*" : ".";
    p46 = (HEX4[6] === 1'b0) ? " *** " : " ... ";

    p50 = (HEX5[0] === 1'b0) ? " *** " : " ... ";
    p51 = (HEX5[1] === 1'b0) ? "*" : ".";
    p52 = (HEX5[2] === 1'b0) ? "*" : ".";
    p53 = (HEX5[3] === 1'b0) ? " *** " : " ... ";
    p54 = (HEX5[4] === 1'b0) ? "*" : ".";
    p55 = (HEX5[5] === 1'b0) ? "*" : ".";
    p56 = (HEX5[6] === 1'b0) ? " *** " : " ... ";

    p60 = (HEX6[0] === 1'b0) ? " *** " : " ... ";
    p61 = (HEX6[1] === 1'b0) ? "*" : ".";
    p62 = (HEX6[2] === 1'b0) ? "*" : ".";
    p63 = (HEX6[3] === 1'b0) ? " *** " : " ... ";
    p64 = (HEX6[4] === 1'b0) ? "*" : ".";
    p65 = (HEX6[5] === 1'b0) ? "*" : ".";
    p66 = (HEX6[6] === 1'b0) ? " *** " : " ... ";

    p70 = (HEX7[0] === 1'b0) ? " *** " : " ... ";
    p71 = (HEX7[1] === 1'b0) ? "*" : ".";
    p72 = (HEX7[2] === 1'b0) ? "*" : ".";
    p73 = (HEX7[3] === 1'b0) ? " *** " : " ... ";
    p74 = (HEX7[4] === 1'b0) ? "*" : ".";
    p75 = (HEX7[5] === 1'b0) ? "*" : ".";
    p76 = (HEX7[6] === 1'b0) ? " *** " : " ... ";

    $display("%s  %s  %s  %s  %s  %s  %s  %s",
             p70, p60, p50, p40, p30, p20, p10, p00);
    $display("%s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s",
             p75, p71, p65, p61, p55, p51, p45, p41, p35, p31, p25, p21, p15, p11, p05, p01);
    $display("%s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s",
             p75, p71, p65, p61, p55, p51, p45, p41, p35, p31, p25, p21, p15, p11, p05, p01);
    $display("%s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s",
             p75, p71, p65, p61, p55, p51, p45, p41, p35, p31, p25, p21, p15, p11, p05, p01);
    $display("%s  %s  %s  %s  %s  %s  %s  %s",
             p76, p66, p56, p46, p36, p26, p16, p06);
    $display("%s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s",
             p74, p72, p64, p62, p54, p52, p44, p42, p34, p32, p24, p22, p14, p12, p04, p02);
    $display("%s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s",
             p74, p72, p64, p62, p54, p52, p44, p42, p34, p32, p24, p22, p14, p12, p04, p02);
    $display("%s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s  %s   %s",
             p74, p72, p64, p62, p54, p52, p44, p42, p34, p32, p24, p22, p14, p12, p04, p02);
    $display("%s  %s  %s  %s  %s  %s  %s  %s",
             p73, p63, p53, p43, p33, p23, p13, p03);
  endfunction : display_it

  initial begin
    $display("Asterisks indicate a lit LED, periods indicate a blank LED.");
    $display("\n");
    $display("Output the value 9876 5432");
    blank = 8'h00;
    BCD7 = 4'd9;
    BCD6 = 4'd8;
    BCD5 = 4'd7;
    BCD4 = 4'd6;
    BCD3 = 4'd5;
    BCD2 = 4'd4;
    BCD1 = 4'd3;
    BCD0 = 4'd2;
    #5 display_it(HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);

    $display("\n");
    $display("Output a blanked display");
    blank = 8'hFF;
    #5 display_it(HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);

    $display("\n");
    $display("Output three blanked values, followed by a great course number");
    blank = 8'b1110_0000;
    BCD4 = 4'd1;
    BCD3 = 4'd8;
    BCD2 = 4'd2;
    BCD1 = 4'd4;
    BCD0 = 4'd0;
    #5 display_it(HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
    #5 $finish;
  end
    
endmodule : SevenSegmentDisplay_test

