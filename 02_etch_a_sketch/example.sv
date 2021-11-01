`default_nettype none // Overrides default behaviour (in a good way)

/*
  Starter module for the etch-a-sketch lab.
*/

module example(
  // On board signals
  clk, buttons, rgb, leds
);

parameter CLK_HZ = 12_000_000; // aka ticks per second
parameter BOUNCE_TICKS = 250;
parameter CLK_PERIOD_NS = (1_000_000_000/CLK_HZ); // Approximation.
parameter PWM_PERIOD_US = 100; 
parameter PWM_WIDTH = 4;
parameter PERIOD_MS_FADE = 100;
parameter PWM_TICKS = CLK_HZ*PWM_PERIOD_US/1_000_000; //1kHz modulation frequency. // Always multiply before dividing, it avoids truncation.
parameter human_divider = 23; // A clock divider parameter - 12 MHz / 2^23 is about 1 Hz (human visible speed).

//Module I/O and parameters
input wire clk;
input wire [1:0] buttons;
logic rst; always_comb rst = buttons[0]; // Use button 0 as a reset signal.
output logic [2:0] rgb;
logic [2:0] rgb_inv;
always_comb rgb = ~rgb_inv;
output logic [1:0] leds;
always_comb leds[1] = buttons[1];
wire dbg;

debouncer #(.BOUNCE_TICKS(BOUNCE_TICKS)) DEBOUNCER(clk, rst, buttons[1], leds[0]);

led_example #(.BOUNCE_TICKS(BOUNCE_TICKS)) LED_STATE_MACHINE(clk, rst, buttons[1], rgb_inv[0], rgb_inv[1], rgb_inv[2], dbg);

endmodule

`default_nettype wire // reengages default behaviour, needed when using 
                      // other designs that expect it.