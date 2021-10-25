module debouncer(clk, rst, bouncy_in, debounced_out);
parameter BOUNCE_TICKS = 10;
input wire clk, rst;
input wire bouncy_in;

output logic debounced_out;

logic [$clog2(BOUNCE_TICKS)-1:0] active_for;
enum logic [1:0] {MAYBE_0, STATE_0, MAYBE_1, STATE_1} state;
logic incriment;

always_ff @( posedge clk ) begin : counter
  if (rst) begin
    active_for <= 0;
    state <= STATE_0;
  end else if(incriment) begin
    active_for <= active_for + 1;
  end
end

always_comb begin : reset
  if (rst) begin
    incriment = 0;
  end
end

always_comb begin : stateTransition
  if (state == MAYBE_0) begin
    incriment = bouncy_in == 0;
  end else if (state == MAYBE_1) begin
    incriment = bouncy_in == 1;
  end
end

// change between states based on the counter and input
always_ff @( posedge clk ) begin : stateMachine
  if (state == MAYBE_0 && active_for == BOUNCE_TICKS-1) begin
    if (~bouncy_in) begin
      state <= STATE_0;
    end else begin
      state <= STATE_1;
    end
    active_for <= 0;
  end else if (state == MAYBE_1 && active_for == BOUNCE_TICKS-1) begin
    if (bouncy_in) begin
      state <= STATE_1;
    end else begin
      state <= STATE_0;
    end
    active_for <= 0;
  end else if (state == STATE_1 && ~bouncy_in) begin
    state <= MAYBE_0;
    active_for <= 0;
  end else if (state == STATE_0 && bouncy_in) begin
    state <= MAYBE_1;
    active_for <= 0;
  end
end

// get output based on state
always_comb begin : outputLogic
  case (state)
    MAYBE_0, STATE_1 : debounced_out = 1;
    MAYBE_1, STATE_0 : debounced_out = 0;
    default: debounced_out = 1'bx;
  endcase
end



endmodule