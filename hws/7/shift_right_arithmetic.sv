module shift_right_arithmetic(in,shamt,out);
parameter N = 32; // only used as a constant! Don't feel like you need to a shifter for arbitrary N.

//port definitions
input  wire [N-1:0] in;    // A 32 bit input
input  wire [$clog2(N)-1:0] shamt; // Shift ammount
output wire [N-1:0] out; // The same as SRL, but maintain the sign bit (MSB) after the shift! 

wire [(N**2)-1:0] precompute; // input to a mux

generate
  genvar i;
  // mux for one out bit
  for(i = 0; i < N; i++) begin
    // same as srl except here we fill with a the MSB
    assign precompute[(i*N) + (N-1):i*N] = { {i{in[N-1]}}, in[N-1:i] };
  end
endgenerate

muxN #(.N(N), .W(N)) MUX(shamt, precompute, out);

endmodule
