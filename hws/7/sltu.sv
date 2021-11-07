`timescale 1ns/1ps
module sltu(a, b, ltu);

parameter N = 32;

input wire unsigned [N-1:0] a, b;
output logic ltu;



logic [N-1:0] sum;
logic unsigned [N-1:0] notb;
logic carry;

adder_n #(.N(N)) SUBTRACT(.a(a), .b(notb), .c_in(1'b1), .sum(sum), .c_out(carry));

always_comb begin
  notb = ~b;
  ltu = ~carry;
end
endmodule