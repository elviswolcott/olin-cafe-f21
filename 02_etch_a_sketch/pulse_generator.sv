/*
  Outputs a pulse generator with a period of "ticks".
  out should go high for one cycle every "ticks" clocks.
*/
module pulse_generator(clk, rst, ena, ticks, out);

parameter N = 8;

input wire clk, rst, ena;
input wire [N-1:0] ticks;
output logic out;

logic [N-1:0] counter;
logic counter_comparator;

always_ff @(posedge clk) begin
  if (rst |  counter_comparator) begin
    counter <= 1'b0;
  end else if (ena) begin
    counter <= counter + 1'b1;
  end
end

always_comb begin
  counter_comparator = counter == ticks - 1;
  out = counter_comparator & ena & clk;
end

endmodule
