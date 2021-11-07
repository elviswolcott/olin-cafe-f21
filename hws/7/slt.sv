module slt(a, b, lv);

parameter N = 32;

input wire signed [N-1:0] a, b;
output logic lv;



logic [N-1:0] sum;
logic signed [N-1:0] notb;
logic same_sign;

adder_n #(.N(N)) SUBTRACT(.a(a), .b(notb), .c_in(1'b1), .sum(sum), .c_out());

always_comb begin
  notb = ~b;
  same_sign = a[N-1] ~^ b[N-1];
  lv = same_sign ? sum[N-1] : a[N-1];
end
endmodule