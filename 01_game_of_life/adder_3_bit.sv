module adder_3_bit(a, b, y, c);

input wire [2:0] a;
input wire [2:0] b;
output logic [2:0] y;
output logic c;

wire c_1;

adder_2_bit start(a[1:0], b[1:0], y[1:0], c_1);
full_adder full(a[2], b[2], c_1, y[2], c);


endmodule