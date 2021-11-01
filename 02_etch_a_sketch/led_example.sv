// cycles through RGB colors
module led_example(clk, rst, btn, red, blue, green, dbg);

parameter BOUNCE_TICKS = 1000;
input wire clk, rst, btn;
output logic red, green, blue, dbg;

enum logic [1:0] {R, G, B} state;
logic debounced, rise_edge, fall;

always_comb dbg = debounced;

debouncer #(.BOUNCE_TICKS(BOUNCE_TICKS)) DEBOUNCE(clk, rst, btn, debounced);

edge_detector EDGE(clk, rst, debounced, rise_edge, fall); // doesn't do anything on the falling edge

always_ff @( posedge clk ) begin : stateMachine
  if (rst) begin
    state <= R;
  end else if (rise_edge) begin
    case (state)
      R: state <= G;
      G: state <= B;
      B: state <= R;
      default: state <= R;
    endcase
  end
end

always_comb begin : ledDriver
  case (state)
    R: begin red = 1; green = 0; blue = 0; end
    G: begin red = 0; green = 1; blue = 0; end
    B: begin red = 0; green = 0; blue = 1; end
    default: begin red = 0; green = 0; blue = 0; end
  endcase
end

endmodule