module adder_2_bit(a, b, y, c);

input wire [1:0] a;
input wire [1:0] b;
output logic [1:0] y;
output logic c;

wire c_1;

half_adder half(a[0], b[0], y[0], c_1);
full_adder full(a[1], b[1], c_1, y[1], c);


endmodule