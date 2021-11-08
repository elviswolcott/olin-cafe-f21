module shift_left_logical(in, shamt, out);

parameter N = 32; // only used as a constant! Don't feel like you need to a shifter for arbitrary N.

input wire [N-1:0] in; // the input number that will be shifted left. Fill in the remainder with zeros.
input wire [$clog2(N)-1:0] shamt; // the amount to shift by (think of it as a decimal number from 0 to 31). 
output logic [N-1:0] out;

wire [(N**2)-1:0] precompute; // input to a mux

// you can also appraoch this using a 32x1:1x1 mux for each output bit
// BUT it requires flipping the order of bits which is messy
// we basically perform the shift for all possible values of shamt and then feed than into a mux like a LUT
generate
  genvar i;
  // mux for one out bit
  for(i = 0; i < N; i++) begin
    // setup inputs for the mux
    // this is just how you perform a SLL for a fixed shamt
    assign precompute[(i*N) + (N-1):i*N] = { in[N-1-i:0], {i{1'b0}} };
  end
endgenerate

muxN #(.N(N), .W(N)) MUX(shamt, precompute, out);

endmodule
