/*
Assignment - 4
Problem - 3
Semester - 5
Group no. : G26
K Rahul Sai - 18CS10028
D Jaswanth - 18CS10014
*/

//test bench for gcd calculator

`timescale 1ns/10ps

module gcd_calculator_tb();

	reg [7:0] a,b;//inputs 8 bit 
	reg a_available,b_available,clk,rst;//for controlling availability of inputs and clock,reset
	wire [7:0] out; //output 8bit
	wire out_ready;//to control availability of output
	//module instantiation
	gcd_calculator_control inst(.out(out),.out_ready(out_ready),.a(a),.b(b),.clk(clk),.rst(rst),.a_available(a_available),.b_available(b_available));

	initial //code for clock
	begin
		clk = 0;
		forever #5 clk = ~clk;
	end 
	//when out_ready is 1 out value gives the gcd of provided a and b.
	//provide inputs such that a>=b and a != 0 and b != 0.
	initial
	begin
		#10//delay of 10units
		rst = 1;
		#10
		rst = 0;
		a = 8'b011110;//change inputs here
		a_available = 1;//to let code know that input a is available
		#10
		b = 8'b0000111;//change inputs here
		b_available = 1;//to let module know that input b is available
		#10
		$display("GCD is - %d , out_ready - %b for inputs a - %d , b - %d",out,out_ready,a,b);
		b_available = 0;
		#100
		$display("GCD is - %d , out_ready - %b for inputs a - %d , b - %d",out,out_ready,a,b);
		#400
		$display("GCD is - %d , out_ready - %b for inputs a - %d , b - %d",out,out_ready,a,b);
		//second set of inputs
		rst = 1;
		#10
		rst = 0;
		a = 8'b001111;//change inputs here
		a_available = 1;//to let code know that input a is available
		#10
		b = 8'b0000101;//change inputs here
		b_available = 1;//to let module know that input b is available
		#10
		$display("GCD is - %d , out_ready - %b for inputs a - %d , b - %d",out,out_ready,a,b);
		a_available = 0;
		#100
		$display("GCD is - %d , out_ready - %b for inputs a - %d , b - %d",out,out_ready,a,b);
		#400
		$display("GCD is - %d , out_ready - %b for inputs a - %d , b - %d",out,out_ready,a,b);
		/*
		For input 8,4 output is 4.
		For input 8,1 output is 1.
		For input 8,7 output is 1.
		*/
		$finish;
	end
endmodule