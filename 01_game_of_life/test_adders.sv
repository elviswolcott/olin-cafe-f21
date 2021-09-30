`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_adders;
  logic [2:0] a;
  logic [2:0] b;
  logic c_in;
  wire [1:0] c_half;
  wire [1:0] c_full;
  wire [2:0] c_2;
  

  half_adder UUT(a[0], b[0], c_half[0], c_half[1]);
  full_adder UUTF(a[0], b[0], c_in, c_full[0], c_full[1]);
  adder_2_bit UUT2(a[1:0], b[1:0], c_2[1:0], c_2[2]);

  initial begin
    // Collect waveforms
    $dumpfile("adders.vcd");
    $dumpvars(0, UUT);
    $dumpvars(0, UUTF);
    $dumpvars(0, UUT2);
    
    $display("\nhalf adder:");
    $display("a b | c y");
    $display("---------");
    for (int i = 0; i < 4; i = i + 1) begin
      b = i[0];
      a = i[1];
      #1 $display("%1b %1b | %1b %1b", a[0], b[0], c_half[1], c_half[0]);
    end

    $display("\nfull adder:");
    $display("c a b | c y");
    $display("-----------");
    for (int i = 0; i < 8; i = i + 1) begin
      b = i[0];
      a = i[1];
      c_in = i[2];
      #1 $display("%1b %1b %1b | %1b %1b", c_in, a[0], b[0], c_full[1], c_full[0]);
    end

    $display("\n2bit adder:");
    $display("a  b  | cy ");
    $display("----------------");
    for (int i = 0; i < 16; i = i + 1) begin
      b = i[1:0];
      a = i[3:2];
      #1 $display("%2b %2b | %1b%2b", a[1:0], b[1:0], c_2[2], c_2[1:0]);
    end
        
    $finish;      
	end

endmodule
