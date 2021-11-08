`timescale 1ns/1ps
`default_nettype none

`include "alu_types.sv"

module alu(a, b, control, result, overflow, zero, equal);
parameter N = 32; // Don't need to support other numbers, just using this as a constant.

input wire [N-1:0] a, b; // Inputs to the ALU.
input alu_control_t control; // Sets the current operation.
output logic [N-1:0] result; // Result of the selected operation.

output logic overflow; // Is high if the result of an ADD or SUB wraps around the 32 bit boundary.
output logic zero;  // Is high if the result is ever all zeros.
output logic equal; // is high if a == b.

logic [N-1:0] r_and, r_or, r_xor, r_ors, r_bool, r_sra, r_srl, r_sll, r_shifters, sum, b_in, r_comp, r_add_sub, r_slt, r_sltu;
logic diff_sign, unexpected_sign, shamt_overflow, c_in, c_out;

// Use *only* structural logic and previously defined modules to implement an 
// ALU that can do all of operations defined in alu_types.sv's alu_op_code_t!

// I was a little extra and tried to optimize so I'm using modules sparingly\
// my diagram in notes shows the full structure

always_comb begin : booleanLogic
  r_and = a & b;
  r_or = a | b;
  r_xor = a ^ b;
  r_ors = control[0] ? r_xor : r_or;
  r_bool = control[1] ? r_ors : r_and;
end

shift_left_logical #(.N(N)) SLL(a, b[$clog2(N)-1:0], r_sll);
shift_right_logical #(.N(N)) SRL(a, b[$clog2(N)-1:0], r_srl);
shift_right_arithmetic #(.N(N)) SRA(a, b[$clog2(N)-1:0], r_sra);

always_comb begin : shifters
  shamt_overflow = | b[N-1:$clog2(N)];
  r_shifters = shamt_overflow ? 32'b0 : control[1] ? (control[0] ? r_sra : r_srl) : r_sll;
end

adder_n #(.N(N)) ADD_SUB(a, b_in, c_in, sum, c_out);

always_comb begin : addSubtract
  b_in = control[2] ? ~b : b;
  c_in = control[2];
  r_add_sub = control[0] ? r_comp : sum;
end

// doing this uses only the one adder
// the tools probably would do this optimization anyways but it was fun to think about
always_comb begin : sltSltu
  r_sltu = {{N-1{1'b0}},~c_out};
  r_slt = {{N-1{1'b0}},diff_sign ? a[N-1] : sum[N-1]};
  r_comp = control[1] ? r_sltu : r_slt;
end

always_comb begin : isEqual
  equal = & (~r_xor);
end

always_comb begin : isZero
  zero = ~ (| result);
end

always_comb begin : willOverflow
  diff_sign = a[N-1] ^ b[N-1];
  unexpected_sign = sum[N-1] ^ a[N-1];
  overflow = control[3] ? (control[2] ? (diff_sign & unexpected_sign) : ~diff_sign & unexpected_sign) : 0;
end

always_comb begin : resultSelection
  result = control[3] ? (r_add_sub) : (control[2] ? r_shifters : r_bool);
end

endmodule