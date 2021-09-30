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
  wire [3:0] c_3;
  logic [3:0] sum;
  

  half_adder UUT(a[0], b[0], c_half[0], c_half[1]);
  full_adder UUTF(a[0], b[0], c_in, c_full[0], c_full[1]);
  adder_2_bit UUT2(a[1:0], b[1:0], c_2[1:0], c_2[2]);
  adder_3_bit UUT3(a[2:0], b[2:0], c_3[2:0], c_3[3]);

  initial begin
    // Collect waveforms
    $dumpfile("adders.vcd");
    $dumpvars(0, UUT);
    $dumpvars(0, UUTF);
    $dumpvars(0, UUT2);
    $dumpvars(0, UUT3);
    
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

    $display("\n3bit adder tested");
    for (int i = 0; i < 128; i = i + 1) begin
      b = i[2:0];
      a = i[6:3];
      sum = a + b;
      #1
      if (c_3 !== sum) begin
        $error("%3b + %3b = %4b (expected %4b)", a, b, c_3, sum);
      end

    end
        
    $finish;      
	end

endmodule
