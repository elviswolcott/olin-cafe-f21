`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_slt;
  logic signed [31:0] a, b;
  logic lt, lt_2;
  logic cmp;
  logic signs, nsigns;
  assign signs = a[1] & b[1];
  assign nsigns = ~a[1] & ~b[1];

  
  slt #(.N(32)) UUT(a, b, lt);
  slt #(.N(2)) UUT_2(a[1:0], b[1:0], lt_2);

  initial begin
    // Collect waveforms
    $dumpfile("slt.vcd");
    $dumpvars(0, UUT);
    $dumpvars(0, UUT_2);
    $dumpvars(1, test_slt);

    // this will verify all the sign combinations and carry behaviors
    $display("\n2-bit SLT:");
    $display("---------");
    for (int i = -2; i < 2; i = i + 1) begin
      for (int j = -2; j < 2; j = j + 1) begin
        b = i;
        a = j;
        cmp = a < b;
        #1 if (lt_2) begin
          $display("%2d <  %2d (a <  b), %b %b", a, b, lt_2, cmp);
        end else begin
          $display("%2d >= %2d (a >= b), %b %b", a, b, lt_2, cmp);
        end
      end
    end

    $display("\n2-bit SLT:");
    $display("---------");
    // test a bunch of random values to make sure nothing breaks down unexpected
    for (int i = 0; i < 512; i = i + 1) begin
      b = $random%4294967296;
      a = $random%4294967296;
      cmp = a < b;
      #1 if (lt != cmp) begin
        $error("%x <  %x (a <  b), %b %b", a, b, lt, cmp);
      end
    end

    $finish;      
	end

endmodule
