`default_nettype none

module hw5prob2_test();
  logic value, clock, hue, reset_n, water;

  hw5prob2 dut(.hue(hue),
               .value(value),
               .clock(clock),
               .reset_n(reset_n),
               .water(water));

  initial begin
    clock = 1'b0;
    forever #10 clock = ~clock;
  end

  initial begin
    $monitor($time,, "state = %s, nextState = %s, in(%b%b), out(%b)",
             dut.state.name, dut.nextState.name, hue, value, water);
    // init -> Red
    reset_n = 1'b0;
    {hue, value} = 2'b00;
    @(posedge clock);

    // cancel reset
    reset_n <= 1'b1;

    // Red + 00 -> Pink
    @(posedge clock);
    // Pink + 00 -> Blue
    @(posedge clock);
    // Blue + 00 -> Blue
    @(posedge clock);
    // Blue + 01 -> Blue
    {hue, value} <= 2'b01;
    @(posedge clock);
    // Blue + reset -> Red
    reset_n <= 1'b0;
    @(posedge clock);

    // Red + 01 -> Gold
    reset_n <= 1'b1;
    {hue, value} <= 2'b01;
    @(posedge clock);
    // Gold + 01 -> Green
    @(posedge clock);
    // Green + 11 -> Green
    {hue, value} <= 2'b11;
    @(posedge clock);
    // Green + 00 -> Red
    {hue, value} <= 2'b00;
    @(posedge clock);

    // Red + 10 -> Blue
    {hue, value} <= 2'b10;
    @(posedge clock);
    // Blue + Reset -> Red
    reset_n <= 1'b0;
    @(posedge clock);

    // Red + 11 -> Pink
    {hue, value} <= 2'b11;
    reset_n <= 1'b1;
    @(posedge clock);
    // Pink + 11 -> Green
    @(posedge clock);
    // Green + Reset -> Red
    reset_n <= 1'b0;
    @(posedge clock);

    // Red + Reset -> Red
    @(posedge clock);

    // Red + 11 -> Pink
    reset_n <= 1'b1;
    @(posedge clock);
    // Pink + Reset -> Red
    reset_n <= 1'b0;
    @(posedge clock);

    // Red + 01 -> Gold
    reset_n <= 1'b1;
    {hue, value} <= 2'b01;
    @(posedge clock);
    // Gold + Reset -> Red
    reset_n <= 1'b0;
    @(posedge clock);

    #1 $finish;
  end

endmodule : hw5prob2_test

