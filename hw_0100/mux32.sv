module mux32(s, d, y);
input wire [4:0] s;
input wire [32*32-1:0] d;
output logic [31:0] y;

muxN #(.N(32), .W(32)) MUX(s, d, y);
endmodule