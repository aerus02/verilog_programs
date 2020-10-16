/*
Assignment - 5
Problem - 2
Semester - 5
Group no. : G26
K Rahul Sai - 18CS10028
D Jaswanth - 18CS10014
*/

//test bench for 16-bit bit slice adder

`timescale 1ns / 1ps

module bit_sliced_alu_16_tb(
	);

	//inputs
	reg [15:0] a,b;
	reg [3:0] s;
	reg m,cin;

	//outputs
	wire [15:0] f;
	wire cout;

	//module instantiation
	bit_sliced_alu_16 uut(.f(f),.cout(cout),.a(a),.b(b),.s(s),.m(m),.cin(cin));

	initial begin
		// Initialize Inputs
	a = 16'b100000;//=16
	b = 16'b10000;//=32
	s = 4'b1111;
	m = 0;
	cin = 1;
	$display("After time %4d s, output is  %b ,(in integer - %d) cout is - %b",$time,f,f,cout);
	// delay of 100 ns
	#100;
	 
	$display("After time %4d s, output is  %b ,(in integer - %d) cout is - %b",$time,f,f,cout);
	
	// a =16'b10010;
	// b = 16'b10011;
	#10;
	$display("After time %4d s, output is  %b ,(in integer -- %d) cout is - %b",$time,f,f,cout);
	
	end
	/*
	Few other test cases:
	For  inputs , a=16'b100 , b = 16'b101 , cin = 1(inverted in module) ;Outputs are:
	For  m = 1; (cout is also inverted.)
	s      -    f    , cout  ;
	0000   -  1111111111111011  , 1;
	0010   -  0000000000000001  , 1;
	0100   -  1111111111111011  , 1;
	For  inputs , a=16'b100000 , b = 16'b10000 , m = 0;
	1111   -  0000000000011111  , 0;
	1001   -  0000000000110000  , 1;
	0111   -  1111111111111111  , 1;

	*/

endmodule