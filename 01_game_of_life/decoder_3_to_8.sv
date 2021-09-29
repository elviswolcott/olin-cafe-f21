module decoder_3_to_8(ena, in, out);

  input wire ena;
  input wire [2:0] in;
  output logic [7:0] out;

  wire [1:0] eno;

  decoder_1_to_2 en(ena, in[2], eno);

  decoder_2_to_4 d1(eno[1], in[1:0], out[7:4]);
  decoder_2_to_4 d0(eno[0], in[1:0], out[3:0]);

endmodule