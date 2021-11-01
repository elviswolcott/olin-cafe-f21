module muxN(s, d, y);
parameter N = 32; // number of inputs
parameter W = 32; // width

input wire [N*W-1:0] d;
input wire [$clog2(N)-1:0] s;
output logic [W-1:0] y;
logic [W-1:0] y_left, y_right;

// using recursion makes implimenting a binary tree design painless
initial begin
  if (N%2 != 0) begin
    $error(".N(%2d) is not a multiple of 2",N);
  end
end
generate
  if (N > 2) begin
    muxN #(.N(N/2), .W(W)) LEFT(s[$clog2(N)-2:0], d[N*W-1:(N*W)/2], y_left[W-1:0]);
    muxN #(.N(N/2), .W(W)) RIGHT(s[$clog2(N)-2:0], d[(N*W)/2-1:0], y_right[W-1:0]);
    // this is a 2:1, just using the muxN for consistency
    muxN #(.N(2), .W(W)) ROOT(s[$clog2(N)-1], {y_left[W-1:0], y_right[W-1:0]}, y[W-1:0]); // MSB as select
  end else begin
    always_comb begin
      y[31:0] = s ? d[W*2-1:W] : d[W-1:0];
    end
  end
endgenerate
endmodule