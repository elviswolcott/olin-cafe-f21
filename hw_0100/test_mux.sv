`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_mux;
  logic [4:0] s;
  logic [32*32-1:0] d;
  logic [31:0] y_2, y_32, result;
  

  // base case
  muxN #(.N(2), .W(32)) UUT_2_1(s[0], d[63:0], y_2);
  mux32 UUT_32_1(s, d, y_32);

  initial begin
    // Collect waveforms
    $dumpfile("adders.vcd");
    $dumpvars(0, UUT_2_1);
    $dumpvars(0, UUT_32_1);
    

    $display("\ntesting 2:1 mux");
    // random values
    d[63:32] = $urandom%4294967296;
    d[31:0] = $urandom%4294967296;
    for (int i = 0; i < 2; i++) begin
      s = i;
      result = s ? d[63:32] : d[31:0];
      #1
      if (y_2 !== result) begin
        $error("%1b ? 0x%8x : 0x%8x = 0x%8x (expected 0x%8x)", s, d[63:32], d[31:0], y_2, result);
      end
    end

    $display("\ntesting 32:1 mux");
    // initialize random values
    d = 0;
    for (int j = 0; j < 32; j++) begin
      d = d | $urandom%4294967296<<(j*32);
    end
    // check each value
    for (int i = 0; i < 32; i++) begin
      s = i;
      result = d >> (32*i);
      #1
      if (y_32 !== result) begin
        $error("%4b got 0x%8x (expected 0x%8x)", s, y_32, result);
      end
    end
    $finish;
	end

endmodule
