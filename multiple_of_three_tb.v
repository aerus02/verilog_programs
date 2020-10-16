/*
Assignment - 4
Problem - 2
Semester - 5
Group no. : G26
K Rahul Sai - 18CS10028
D Jaswanth - 18CS10014
*/

//test bench for FSM to check divisibility by 3

`timescale 1ns/10ps

module multiple_of_three_tb();
// change input bit in every clock cycle and reset in the end 
	reg in,clk,rst;//input ,clock,reset
	wire out;//output bit
	//module instantiation
	multiple_of_three inst(.out(out),.in(in),.clk(clk),.rst(rst));

	initial //code for clock
	begin
		clk = 0;
		forever #5 clk = ~clk;
	end 

	initial
	begin//example is 11001,output is  01110.(Consider only first n bits where n is size of input to  get corresponding output)
		#10
		rst = 1;
		#10
		rst = 0;
		$display("Output       Time  input  currrent_state  next_state reset");
		// $display("Output is %b %3d %4b %12b %12b %10b",out,$time,in,inst.current_state,inst.next_state,rst);
		in = 1;
		#10
		$display("Output is %b %3d %4b %12b %12b %10b",out,$time,in,inst.current_state,inst.next_state,rst);
		
		in = 1;
		#10
		$display("Output is %b %3d %4b %12b %12b %10b",out,$time,in,inst.current_state,inst.next_state,rst);
		
		in = 0;
		#10
		$display("Output is %b %3d %4b %12b %12b %10b",out,$time,in,inst.current_state,inst.next_state,rst);
		
		in = 0;
		#10
		$display("Output is %b %3d %4b %12b %12b %10b",out,$time,in,inst.current_state,inst.next_state,rst);
		
		in = 1;
		#10
	$display("Output is %b %3d %4b %12b %12b %10b",out,$time,in,inst.current_state,inst.next_state,rst);
	
	// rst = 1;
	// #10
	// $display("Output is %b %3d %4b %12b %12b %10b",out,$time,in,inst.current_state,inst.next_state,rst);
	/*
		For 11111,output is 01010
		For 00000,output is 11111
		For 10101 ,output is 00001
		For 11001 ,output is 01110
	*/
	$finish;
	end
endmodule