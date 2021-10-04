module adder_8_to_1(in, out);
  input wire [7:0] in;
  output logic [3:0] out;

  wire [5:0] layer_out;

  adder_4_to_1 A(in[3:0], layer_out[2:0]);
  adder_4_to_1 B(in[7:4], layer_out[5:3]);
  adder_3_bit C(layer_out[2:0], layer_out[5:3], out[2:0], out[3]);
endmodule