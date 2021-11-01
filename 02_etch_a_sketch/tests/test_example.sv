`timescale 1ns / 100ps
`default_nettype none

module test_example;
parameter CLK_HZ = 12_000_000;
parameter CLK_PERIOD_NS = (1_000_000_000/CLK_HZ); // Approximation.
//Module I/O and parameters
logic clk;
logic [1:0] buttons;
wire [1:0] leds;
wire [2:0] rgb;

led_example #(.BOUNCE_TICKS(50)) UUT(clk, buttons[0], buttons[1], rgb[2], rgb[1], rgb[0]);

logic [6:0] delay;

// Run our main clock.
always #(CLK_PERIOD_NS/2) clk = ~clk;

initial begin
  // Collect waveforms
  $dumpfile("example.vcd");
  $dumpvars(0);
  // Initialize module inputs.
  clk = 0;
  buttons = 2'b11; //using buttons[0] as reset.
  // Assert reset for long enough.
  repeat(2) @(negedge clk);
  buttons = 2'b00;
  for (int i = 0; i < 10; i++) begin
    delay = $random + 100;
    repeat (delay) @(negedge clk);
    buttons = 2'b10;
    repeat (100) @(negedge clk);
    buttons = 2'b00;
  end

  $finish;
end



endmodule
