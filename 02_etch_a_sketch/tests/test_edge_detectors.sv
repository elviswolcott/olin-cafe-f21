module test_edge_detectors;

logic clk, rst, in;
wire positive_edge, negative_edge;

edge_detector UUT(clk, rst, in, positive_edge, negative_edge);

logic [6:0] delay;

initial begin
  clk = 0;
  rst = 1;
  #5 rst = 0;
  in = 0;
  $dumpfile("edge_detectors.vcd");
  $dumpvars(0, UUT);

  for (int i = 0; i < 10; i++) begin
    delay = $random + 1;
    repeat (delay) @(negedge clk);
    in = ~in;
  end

  $finish;
end

always #5 clk = ~clk; // clock signal
endmodule