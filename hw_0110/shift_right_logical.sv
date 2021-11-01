module shift_right_logical(in,shamt,out);
parameter N = 32; // only used as a constant! Don't feel like you need to a shifter for arbitrary N.

//port definitions
input  wire [N-1:0] in;    // A 32 bit input
input  wire [$clog2(N)-1:0] shamt; // Amount we shift by.
output wire [N-1:0] out;  // Output.

wire [(N**2)-1:0] precompute; // input to a mux

// we basically perform the shift for all possible values of shamt and then feed than into a mux like a LUT
generate
  genvar i;
  // mux for one out bit
  for(i = 0; i < N; i++) begin
    // setup inputs for the mux
    // this is just how you perform a SLL for a fixed shamt
    assign precompute[(i*N) + (N-1):i*N] = { {i{1'b0}}, in[N-1:i] };
  end
endgenerate

muxN #(.N(N), .W(N)) MUX(shamt, precompute, out);

endmodule
