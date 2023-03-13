`default_nettype none
module ChipInterface
    (input logic SW[17:0],
    output logic LEDR[17:0]);

    Parity PAR(.d2(SW[5]),
                .d1(SW[4]),
                .p2(SW[3]),
                .d0(SW[2]),
                .p1(SW[1]),
                .p0(SW[0]),
                .valid(LEDR[17]));

endmodule: chipInterface
