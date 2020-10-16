/*
Assignment - 5
Problem - 2
Semester - 5
Group no. : G26
K Rahul Sai - 18CS10028
D Jaswanth - 18CS10014
*/

//code for 16-bit bit slice adder

/*
uses four four_bit_ALU modules and takes 16 bit inputs a,b and splits them into 4 bits and sends each part in distict four_bit_ALU blocks.
m and s are same for each four_bit_ALU block to ensure each block compute same function
cin is given to first module(with 3:0 bits of inputs) and the carryout from one block is propogated as cin to its successive block.
cout from final bloc(with 12:15 bits of inputs) is given as cout of whole module.
outputs from each of 4 blocks is finally concatenated to give 16 bit output f.
*/

/*
should link the four_bit_ALU module
i.e. while running this module,also include the four_bit_ALU module from four_bit_ALU.v file.
i.e. command using iverilog: " iverilog four_bit_ALU.v bit_sliced_alu_16.v bit_sliced_alu_16_tb.v   "
*/
`timescale 1ns / 1ps

module bit_sliced_alu_16( output [15:0] f, output cout, input [15:0] a, input [15:0] b, input [3:0] s,input m,input cin
	);
	wire [2:0] carry;

	four_bit_ALU alu0(.a(a[3:0]),.b(b[3:0]),.m(m),.s(s),.cin(cin),.f(f[3:0]),.cout(carry[0]));
	four_bit_ALU alu1(.a(a[7:4]),.b(b[7:4]),.m(m),.s(s),.cin(carry[0]),.f(f[7:4]),.cout(carry[1]));
	four_bit_ALU alu2(.a(a[11:8]),.b(b[11:8]),.m(m),.s(s),.cin(carry[1]),.f(f[11:8]),.cout(carry[2]));
	four_bit_ALU alu3(.a(a[15:12]),.b(b[15:12]),.m(m),.s(s),.cin(carry[2]),.f(f[15:12]),.cout(cout));

endmodule