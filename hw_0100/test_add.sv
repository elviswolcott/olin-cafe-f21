`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_adders;
  logic [31:0] a;
  logic [31:0] b;
  logic c_in;
  wire [1:0] c_full;
  wire [1:0] c_out;
  wire [31:0] y;
  logic [31:0] sum;
  

  full_adder UUT(a[0], b[0], c_in, c_full[0], c_full[1]);
  add32 UUT32(a, b, c_in, c_out, y);

  initial begin
    // Collect waveforms
    $dumpfile("adders.vcd");
    $dumpvars(0, UUT);
    $dumpvars(0, UUT32);
    
    $display("\nfull adder:");
    $display("c a b | c y");
    $display("-----------");
    for (int i = 0; i < 8; i = i + 1) begin
      b = i[0];
      a = i[1];
      c_in = i[2];
      #1 $display("%1b %1b %1b | %1b %1b", c_in, a[0], b[0], c_full[1], c_full[0]);
    end

    $display("\ntesting 32-bit adder");
    // it would be painfully slow to go through all the possibilities here
    // a few random values

    // random values
    for (int i = 0; i < 128; i = i + 1) begin
      a = $urandom%4294967296;
      b = $urandom%4294967296;
      c_in = 0;
      sum = a + b;
      #1
      if (y !== sum) begin
        $error("0x%8x + 0x%8x = 0x%8x (expected 0x%8x)", a, b, y, sum);
      end
    end

    // 00...1..00
    for (int i = 0; i < 32; i = i + 1) begin
      for (int j = 0; j < 32; j = j + 1) begin
        a = 1 << i;
        b = 1 << j;
        c_in = 0;
        sum = a + b;
        #1
        if (y !== sum) begin
          $error("0x%8x + 0x%8x = 0x%8x (expected 0x%8x)", a, b, y, sum);
        end
      end
    end

    // overflow
    a = 1<<31;
    b = 1<<31;
    #1
    if (c_out != 1) begin
      $error("carry out fails");
    end

    // assuming the full adder works this is sufficient test coverage - and the full adder is field tested!
        
    $finish;      
	end

endmodule
