`default_nettype none

module hw6prob3
 (input  logic                 d_in_ready, clock, reset,
  input  logic [29:0]          d_in,
  output logic                 d_out_ready,
  output logic [4:0] d_out);


  logic [3:0] count1, count2, count3, count4,
              r1_Q, r2_Q, r3_Q, r4_Q;

  Count8Bits counter1 (.bits(d_in[7:0]),
                       .count(count1));
  Count8Bits counter2 (.bits(d_in[15:8]),
                       .count(count2));
  Count8Bits counter3 (.bits(d_in[23:16]),
                       .count(count3));
  Count8Bits counter4 (.bits({2'b00, d_in[29:24]}),
                       .count(count4));

  logic en_L1, clear_L1;
  Register #(4) r1 (.D(count1),
                    .Q(r1_Q),
                    .clock(clock),
                    .en(en_L1),
                    .clear(clear_L1));
  Register #(4) r2 (.D(count2),
                    .Q(r2_Q),
                    .clock(clock),
                    .en(en_L1),
                    .clear(clear_L1));
  Register #(4) r3 (.D(count3),
                    .Q(r3_Q),
                    .clock(clock),
                    .en(en_L1),
                    .clear(clear_L1));
  Register #(4) r4 (.D(count4),
                    .Q(r4_Q),
                    .clock(clock),
                    .en(en_L1),
                    .clear(clear_L1));

  logic [3:0] S_L1_part1, S_L1_part2;
  logic cout_L1_part1, cout_L1_part2;
  Adder #(4) a1 (.A(r1_Q),
                 .B(r2_Q),
                 .cin(1'b0),
                 .cout(cout_L1_part1),
                 .S(S_L1_part1));

  Adder #(4) a2 (.A(r3_Q),
                 .B(r4_Q),
                 .cin(1'b0),
                 .cout(cout_L1_part2),
                 .S(S_L1_part2));

  logic [4:0] r5_Q, r6_Q;
  logic en_L2, clear_L2;
  Register #(5) r5 (.D({cout_L1_part1, S_L1_part1}),
                    .Q(r5_Q),
                    .clock(clock),
                    .en(en_L2),
                    .clear(clear_L2));
  Register #(5) r6 (.D({cout_L1_part2, S_L1_part2}),
                    .Q(r6_Q),
                    .clock(clock),
                    .en(en_L2),
                    .clear(clear_L2));

  logic [4:0] S_L2;
  Adder #(5) a3 (.A(r5_Q),
                 .B(r6_Q),
                 .cin(1'b0),
                 .S(S_L2));

  logic en_L3, clear_L3;
  Register #(5) r7 (.D(S_L2),
                    .Q(d_out),
                    .clock(clock),
                    .en(en_L3),
                    .clear(clear_L3));

  fsm control (clock, reset, d_in_ready, d_out_ready, 
               en_L1, en_L2, en_L3, clear_L1, clear_L2, clear_L3);

endmodule: hw6prob3

module Count8Bits
  (input logic [7:0] bits,
   output logic [3:0] count);

  assign count = bits[7] + bits[6] + bits[5] + bits[4] +
                 bits[3] + bits[2] + bits[1] + bits[0];

endmodule : Count8Bits

module fsm
  (input  logic clock, reset, d_in_ready,
   output logic d_out_ready,
   output logic en_L1, en_L2, en_L3, clear_L1, clear_L2, clear_L3);

  enum logic [2:0] {A = 3'd0, B = 3'd1, C = 3'd2,
              D = 3'd3, E = 3'd4} cur_state, n_state;

  always_comb begin
    case (cur_state)
      A: begin  //State A -> waiting for d_in_ready
         n_state = d_in_ready ? B : A;
         clear_L1  = d_in_ready ? 1 : 0;
         clear_L2  = d_in_ready ? 1 : 0;
         clear_L3  = d_in_ready ? 1 : 0;
         en_L1   = 0;
         en_L2   = 0;
         en_L3   = 0;
         d_out_ready = 0;
         end
      B: begin  //State B -> all Regs cleared
         n_state = C;
         clear_L1 = 0;
         clear_L2 = 0;
         clear_L3 = 0;
         en_L1 = 1;
         end
      C: begin // State C -> L1 Regs filled from counters
         n_state = D;
         en_L1 = 0;
         en_L2 = 1;
      end
      D: begin // State D -> L2 Regs filled from Adders
         n_state = E;
         en_L2 = 0;
         en_L3 = 1;
      end
      E: begin // State E -> L3 Regs filled, Done
         n_state = A;
         en_L3 = 0;
         d_out_ready = 1;
      end
    endcase
  end

  always_ff @(posedge clock, posedge reset)
    if (reset)
      cur_state <= A;
    else
      cur_state <= n_state;

endmodule: fsm
