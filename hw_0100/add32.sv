module add32(a, b, c_in, c_out, y);
input wire [31:0] a;
input wire [31:0] b;
input wire c_in;
output logic c_out; // could be useful for comparison/overflow
output logic [31:0] y;

// connections between ripple adders
logic [32:0] carries;

generate
  genvar i;
  for (i = 0; i < 32; i++) begin
    full_adder ADDR(a[i], b[i], carries[i], carries[i+1], y[i]);
  end
endgenerate

always_comb begin
  carries[0] = c_in;
  c_out = carries[32];
end

endmodule