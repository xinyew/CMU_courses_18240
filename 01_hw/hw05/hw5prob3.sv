`default_nettype none
module hw5prob3_test();
  logic gym, trainer, clock, reset, got_em_all;

  hw5prob3 dut(.gym(gym),
               .trainer(trainer),
               .clock(clock),
               .reset(reset),
               .got_em_all(got_em_all));

  initial begin
    $monitor($time,, "state: %s, nextState: %s, out: %b, in: %b%b, reset: %b",
             dut.state.name, dut.nextState.name, got_em_all, gym, trainer, reset);
    // init
    clock = 1'b0;
    reset = 1'b1;
    reset <= 1'b0;

    forever #10 clock = ~clock;
  end

  initial begin
    {gym, trainer} <= 2'b10;
    @(posedge clock); // #10 G 10 -> E 0
    @(posedge clock); // #30 E 10 -> S 0
    @(posedge clock); // #50 S 10 -> S 1
    {gym, trainer} <= 2'b01;
    @(posedge clock); // #70 S 01 -> G 1
    @(posedge clock); // #90 G 01 -> E 0

    // E + Reset/01 -> G 1
    #1 reset = 1'b1;
    #1 reset = 1'b0;

    {gym, trainer} <= 2'b11;
    @(posedge clock); // #110 G 11 -> S 0

    // S + Reset/11 -> G 1
    #1 reset = 1'b1;
    #1 reset = 1'b0;

    {gym, trainer} <= 2'b00;
    @(posedge clock); // #130 G 00 -> S 1

    // S + Reset/00 -> G 0
    #1 reset = 1'b1;
    #1 reset = 1'b0;

    // G + Reset/00 -> G 0
    #1 reset = 1'b1;
    #1 reset = 1'b0;

    #1 $finish;
  end

endmodule : hw5prob3_test
