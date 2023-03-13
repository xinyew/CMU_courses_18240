`default_nettype none

module hw5prob2_test();
  logic value, clock, hue, reset_n, water;

  hw5prob2 dut(.hue(hue),
               .value(value),
               .clock(clock),
               .reset_n(reset_n),
               .water(water));

  initial begin
    $monitor($time,, "state = %s, nextState = %s, in(%b%b), out(%b), reset_n(%b)",
             dut.state.name, dut.nextState.name, hue, value, water, reset_n);
    // init -> Red
    clock = 0;
    reset_n = 1'b0;
    reset_n <= 1'b1;

    forever #10 clock = ~clock;
  end

  initial begin
    {hue, value} <= 2'b00;
    @(posedge clock); // #10 Red + 00 -> Pink
    @(posedge clock); // #30 Pink + 00 -> Blue
    {hue, value} <= 2'b01;
    @(posedge clock); // #50 Blue + 01 -> Blue

    // Blue Reset
    #1 reset_n = 1'b0; // Blue + Reset -> Red
    #1 reset_n = 1'b1; // release reset

    @(posedge clock); // #70 Red + 01 -> Gold
    @(posedge clock); // #90 Gold + 01 -> Green
    {hue, value} <= 2'b11;
    @(posedge clock); // #110 Green + 11 -> Green
    {hue, value} <= 2'b00;
    @(posedge clock); // #130 Green + 00 -> Red
    {hue, value} <= 2'b10;
    @(posedge clock); // #150 Red + 10 -> Blue

    // Blue reset
    #1 reset_n = 1'b0; // Blue + Reset -> Red
    #1 reset_n = 1'b1; // release reset

    {hue, value} <= 2'b11;
    @(posedge clock); // #170 Red + 11 -> Pink
    @(posedge clock); // # 190 Pink + 11 -> Green

    // Green Reset
    #1 reset_n = 1'b0; // Green + Reset -> Red
    #1 reset_n = 1'b1; // release reset
    
    // Red Reset
    #1 reset_n = 1'b0; // Red + Reset -> Red
    #1 reset_n = 1'b1; // release reset

    @(posedge clock); // #210 Red + 11 -> Pink

    // Pink Reset
    #1 reset_n = 1'b0; // Pink + Reset -> Red
    #1 reset_n = 1'b1; // release reset

    {hue, value} <= 2'b01;
    @(posedge clock); // #230 Red + 01 -> Gold

    // Gold Reset
    #1 reset_n = 1'b0; // Gold + Reset -> Red
    #1 reset_n = 1'b1; // release reset

    #1 $finish;
  end

endmodule : hw5prob2_test
