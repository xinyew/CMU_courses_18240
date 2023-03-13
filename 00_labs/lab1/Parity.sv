`default_nettype none
module Parity_POS
    (input logic d2, d1, p2, d0, p1, p0,
    output logic valid);

    logic nor_1, nor_2, nor_3, nor_4, nor_5, nor_6, nor_7, nor_8, nor_9,
            nor_10, nor_11, nor_12;
    logic not_d2, not_d1, not_p2, not_d0, not_p1, not_p0;

    not (not_d2, d2),
        (not_d1, d1),
        (not_p2, p2),
        (not_d0, d0),
        (not_p1, p1),
        (not_p0, p0);
    //term 1
    nor (nor_1, d1, not_d0, p0);
    //term 2
    nor (nor_2, not_d2, d0, p1);
    //term 3
    nor (nor_3, d1, d0, not_p0);
    //term 4
    nor (nor_4, not_d2, not_d0, not_p1);
    //term 5
    nor (nor_5, p2, p1, not_p0);
    //term 6
    nor (nor_6, d2, not_d0, p1);
    //term 7
    nor (nor_7, p2, not_p1, p0);
    //term 8
    nor (nor_8, not_p2, not_p1, not_p0);
    //term 9
    nor (nor_9, not_p2, p1, p0);
    //term 10
    nor (nor_10, not_d1, d0, p0);
    //term 11
    nor (nor_11, d2, d0, not_p1);
    //term 12
    nor (nor_12, not_d1, not_d0, not_p0);

    nor (valid, nor_1, nor_2, nor_3, nor_4, nor_5, nor_6, nor_7, nor_8,
        nor_9, nor_10, nor_11, nor_12);

endmodule: Parity_POS


module Parity_SOP
    (input logic d2, d1, p2, d0, p1, p0,
    output logic valid);

    logic and_01, and_02, and_03, and_04, and_05, and_06,
          and_07, and_08;
    logic not_d2, not_d1, not_p2, not_d0, not_p1, not_p0;

    not (not_d2, d2),
        (not_d1, d1),
        (not_p2, p2),
        (not_d0, d0),
        (not_p1, p1),
        (not_p0, p0);
    //term 1
    and (and_01, not_d2, not_d1, not_p2, not_d0, not_p1, not_p0);
    //term 2
    and (and_02, not_d2, not_d1, not_p2, d0, p1, p0);
    //term 3
    and (and_03, not_d2, d1, p2, not_d0, not_p1, p0);
    //term 4
    and (and_04, not_d2, d1, p2, d0, p1, not_p0);
    //term 5
    and (and_05, d2, not_d1, p2, d0, not_p1, p0);
    //term 6
    and (and_06, d2, not_d1, p2, not_d0, p1, not_p0);
    //term 7
    and (and_07, d2, d1, not_p2, d0, not_p1, not_p0);
    //term 8
    and (and_08, d2, d1, not_p2, not_d0, p1, p0);

    or (valid, and_01, and_02, and_03, and_04,
               and_05, and_06, and_07, and_08);

endmodule: Parity_SOP


module Parity_test;
    logic [5:0] vector;
    logic valid_POS, valid_SOP;

    Parity_POS DUT1(.d2(vector[5]),
                .d1(vector[4]),
                .p2(vector[3]),
                .d0(vector[2]),
                .p1(vector[1]),
                .p0(vector[0]),
                .valid(valid_POS));

    Parity_SOP DUT2(.d2(vector[5]),
                .d1(vector[4]),
                .p2(vector[3]),
                .d0(vector[2]),
                .p1(vector[1]),
                .p0(vector[0]),
                .valid(valid_SOP));

    initial begin
        $monitor($time,,
            "vector = %b, valid_POS = %b, valid_SOP = %b",
            vector, valid_POS, valid_SOP);
        for (vector=6'b0; vector < 6'b111111; vector++)
            #1;
        #1 $finish;
    end

endmodule: Parity_test
