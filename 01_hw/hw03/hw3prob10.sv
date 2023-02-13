`default_nettype none
module hw3prob10
  (input logic [7:0] a, b,
   output logic [7:0] sum,
   output logic overflow);

  logic [6:0] mag_a, mag_b , max, min;
  logic [6:0]mag_sum;
  logic sign_a, sign_b, sign_sum;

  assign mag_a = a[6:0] ;
  assign mag_b = b[6:0] ;
  assign sign_a = a[7];
  assign sign_b = b[7] ;

  always_comb begin
    if (mag_a > mag_b) begin
      max = mag_a;
      min = mag_b;
      sign_sum = sign_a;
    end
    else begin
      max = mag_b;
      min = mag_a;
      sign_sum = sign_b;
    end

    if (sign_a==sign_b) begin
      {overflow, mag_sum} = max + min;
    end
    else begin
      mag_sum = max - min;
      overflow = 0;
    end


    sum = {sign_sum, mag_sum};

  end
endmodule : hw3prob10

module hw3prob10_test;
  logic [7:0] a, b, sum;
  logic overflow;

  hw3prob10 DUT (.a(a),
                .b(b),
                .sum(sum),
                .overflow(overflow));

  initial begin
    $monitor($time,,
      "a = %b, b = %b, sum = %b, overflow = %b",
      a, b, sum, overflow);
    a = 8'b00000000;
    b = 8'b11111111;
    #1 a = 8'b00000001;
    #1 a = 8'b10000001;
    #1 a = 8'b11111111;
    #1 a = 8'b01111111;
       b = 8'b10000000;
    #1 b = 8'b10000001;
    #1 b = 8'b00000001;
    #1 b = 8'b11111111;
    #1 b = 8'b01111111;
    #1 $finish;
  end
endmodule : hw3prob10_test
