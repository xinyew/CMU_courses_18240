`default_nettype none

module BCDtoSevenSegment_test();

  logic [3:0] bcd;
  logic [6:0] segment;

  BCDtoSevenSegment DUT(.bcd, .segment);

  function display(logic [6:0] s);
    string p6, p5, p4, p3, p2, p1, p0;

    p6 = (s[6] === 1'b1) ? " *** " : " ... ";
    p5 = (s[5] === 1'b1) ? "*" : ".";
    p4 = (s[4] === 1'b1) ? "*" : ".";
    p3 = (s[3] === 1'b1) ? " *** " : " ... ";
    p2 = (s[2] === 1'b1) ? "*" : ".";
    p1 = (s[1] === 1'b1) ? "*" : ".";
    p0 = (s[0] === 1'b1) ? " *** " : " ... ";

    $display(p0);
    $display("%s   %s", p5, p1);
    $display("%s   %s", p5, p1);
    $display("%s   %s", p5, p1);
    $display(p6);
    $display("%s   %s", p4, p2);
    $display("%s   %s", p4, p2);
    $display("%s   %s", p4, p2);
    $display(p3);

  endfunction

  initial begin
    $display("Asterisks represent lit segments.  Periods represent dim segments");
    for (bcd = 4'd0; bcd < 4'd10; bcd++) begin
      #5;
      $display("Testing with a bcd input value of %d(%b)", bcd, bcd);
      $display("");
      display(segment);
      $display("");
      end
  end

endmodule : BCDtoSevenSegment_test 

