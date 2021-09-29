module decoder_2_to_4(ena, in, out);

  input wire ena;
  input wire [1:0] in;
  output logic [3:0] out;

  wire [1:0] eno;

  decoder_1_to_2 en(ena, in[1], eno);

  decoder_1_to_2 d1(eno[1], in[0], out[3:2]);
  decoder_1_to_2 d0(eno[0], in[0], out[1:0]);

endmodule