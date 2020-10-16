/*
Assignment - 5
Problem - 4
Semester - 5
Group no. : G26
K Rahul Sai - 18CS10028
D Jaswanth - 18CS10014
*/

//test bench for carry save adder

`timescale 1ns / 1ps

module carry_save_adder_tb;
	//inputs
	reg [15:0] a0,a1,a2,a3,a4,a5,a6,a7,a8;
	// Outputs
	wire [19:0] sum;

	// Instantiate the Unit Under Test (UUT)
	carry_save_adder_9 uut(.sum(sum),.a0(a0),.a1(a1),.a2(a2),.a3(a3),.a4(a4),.a5(a5),.a6(a6),.a7(a7),.a8(a8));
	
	initial begin
	// Initialize Inputs
	a0 = 16'b1111111111111111; // 16 1s.
	a1 = 16'b1111111111111111;
	a2 = 16'b1111111111111111;
	a3 = 16'b1111111111111111;
	a4 = 16'b1111111111111111;
	a5 = 16'b1111111111111111;
	a6 = 16'b1111111111111111;
	a7 = 16'b1111111111111111;
	a8 = 16'b1111111111111111;
	$display("After time %4d s, sum is  %b , sum in int format - %d",$time,sum,sum);
	// delay of 100 ns
	#100;
	 
	$display("After time %4d s, sum is  %b , sum in int format - %d",$time,sum,sum);
	
	a0 =16'b0;

	#10;
	$display("After time %4d s, sum is  %b , sum in int format - %d",$time,sum,sum);
	
	a1 = 16'b0;
	a2 = 16'b0;
	a3 = 16'b0;
	a4 = 16'b0;
	a5 = 16'b0;
	a6 = 16'b0;
	a7 = 16'b0;
	a8 = 16'b0;
	#10;

	$display("After time %4d s, sum is  %b , sum in int format - %d",$time,sum,sum);
	
	a8 = 16'b1;
	#10;

	$display("After time %4d s, sum is  %b , sum in int format - %d",$time,sum,sum);

	/*a0 = 16'b1;
	a1 = 16'b1;
	a2 = 16'b1;
	a3 = 16'b1;
	a4 = 16'b1;
	a5 = 16'b1;
	a6 = 16'b1;
	a7 = 16'b1;
	a8 = 16'b0;
	#10;

	$display("After time %4d s, sum is  %b , sum in int format - %d",$time,sum,sum);
	*/

	end
    /*Few other test cases :
	For inputs : a0,a1,a2,a3,a4,a5,a6,a7,a8 ; output is : sum ;
	1, 1, 1, 1, 1, 1, 1, 1, 0 ;  1000
	1, 11, 1, 1, 1, 1, 1, 1, 1 ; 1011
    */
endmodule

