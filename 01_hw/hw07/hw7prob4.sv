`default_nettype none

module MemoryController
 #(parameter logic [7:0] page = 8'h02)
  (inout tri [15:0] addressData,
   input logic addressValid, read, clock, reset);

  // indicating controller to drive the bus
  logic send;
  // word to be sent
  logic [15:0] toSend;
  // word received
  logic [15:0] received;

  // init the bus driver
  BusDriver #(16) BUS (.en(send),
                       .data(toSend),
                       .bus(addressData),
                       .buff(received));

  // current address
  logic [7:0] addr;

  // init memory
  Memory #(.AW(8), .DW(16)) M(.addr(addr),
                              .re(~send),
                              .we(send),
                              .clock(clock),
                              .data(addressData));
   
  FSM fsm (.*);

endmodule : MemoryController

module FSM
  (input logic [15:0] addressData,
   input logic [7:0] page,
   input logic read, addressValid,
   output logic [7:0] addr,
   output logic send);
  enum logic [3:0] {IDLE, READ1, READ2, 
                    READ3, READ4, WRITE1, WRITE2, WRITE3,
                    WRITE4, DONE} cur_state, n_state;
  
  always_comb begin
    case (cur_state)
      IDLE: begin
        if (addressValid && (addressData[15:8] == page)) begin
          addr = addressData[7:0];
          if (read)
            n_state = READ1;
          else
            n_state = WRITE1;
        end
        else
          n_state = IDLE;
      end
      READ1: begin
        n_state = READ2;
        send = 'b1;
        addr = addr + 1;
      end
      READ2: begin
        n_state = READ2;
        addr = addr + 1;
      end
      READ3: begin
        n_state = READ2;
        addr = addr + 1;
      end
      READ4: begin
        n_state = DONE;
      end
      DONE:
        send = 'b0;
      WRITE1: begin
        n_state = WRITE2;
        addr = addr + 1;
      end
      WRITE2: begin
        n_state = WRITE3;
        addr = addr + 1;
      end
      WRITE3: begin
        n_state = WRITE4;
        addr = addr + 1;
      end
      WRITE4: begin
        n_state = DONE;
      end
    endcase
  end

endmodule : FSM