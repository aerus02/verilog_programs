/*
Assignment - 4
Problem - 3
Semester - 5
Group no. : G26
K Rahul Sai - 18CS10028
D Jaswanth - 18CS10014
*/

//code for gcd calculator

`timescale 1ns/10ps


module fulladder(
    input a,
    input b,
    input cin,
    output sum,
    output carry );
assign x=a ^ b;
assign sum=x^cin;
assign y=x & cin;
assign z=a & b;
assign carry= y | z;
endmodule


module ripple_8adder(
    input [8:0] a,
    input [8:0] b,
    input cin,
    output [8:0] sum,
    output carry );
    wire [7:0]c;
fulladder FA1(a[0],b[0],cin,sum[0],c[0]);
fulladder FA2(a[1],b[1],c[0],sum[1],c[1]);
fulladder FA3(a[2],b[2],c[1],sum[2],c[2]);
fulladder FA4(a[3],b[3],c[2],sum[3],c[3]);
fulladder FA5(a[4],b[4],c[3],sum[4],c[4]);
fulladder FA6(a[5],b[5],c[4],sum[5],c[5]);
fulladder FA7(a[6],b[6],c[5],sum[6],c[6]);
fulladder FA8(a[7],b[7],c[6],sum[7],c[7]);
fulladder FA9(a[8],b[8],c[7],sum[8],carry);
endmodule


module difference(//computes a-b
	input [7:0]a,input [7:0]b,//two 8 bit inputs 
	input clk,input rst,//clock and a reset signal(resets everything to 0 before giving input)
	output reg [8:0] out, //holds a-b with 1st bit out[8]  as sign bit
	output reg out_ready  //true if output is calculated and the value in out is the final result 
);

	always @(a,b)
	begin
		out = a-b;
		out_ready = 1;
	end

endmodule


module gcd_calculator_control(out,out_ready,a,b,clk,rst,a_available,b_available);//in_taken - true => start or continue code execution
	input [7:0] a,b;//first make rst to 1 and then rst to  0 and then inputs a and b then code  executes.
	input a_available,b_available,clk,rst;//a_available is true then value is a is input1 and can be loaded into in1.

	output reg [7:0] out;
	output reg out_ready;//out_ready is true,then value in out is gcd of taken inputs

	reg a_taken,b_taken,in_taken;//a_taken states a is successfully loaded into in2 ,similarly b and in_taken means both and b are loaded
	reg [7:0] temp,in1,in2;
	
	reg [1:0] current_state,next_state;

	parameter DIFF  = 2'b00,//to compute while(temp=(a-b) > 0)  recursively and update a= temp( a for in1 and b for in2) 
			SWP = 2'b01, //to swap in1 and in2 when (temp=(in1-in2)) < 0
			DONE = 2'b10; //when temp=(in1-in2) is zero ,value in in2 is gcd.So sets  out_ready and out values in this state. 

	reg diff_rst;
	wire [8:0]diff;
	wire diff_out_ready;//module instantiation for subtraction.
	difference subtract(.a(in1),.b(in2),.clk(clk),.rst(diff_rst),.out(diff),.out_ready(diff_out_ready));

	reg swp_done;

	always @(*)//current state update
	begin
		if(!rst) 
		begin
			current_state = next_state;
			#1;
		end
	end

	always @(*)//next state update
	begin
		if(rst)
		begin
			current_state = DIFF;
			next_state = DIFF;
			in1 = 8'b0;
			in2 = 8'b0;
			out = 8'b0;
			a_taken = 0;
			b_taken = 0;
			in_taken = 0;
			out_ready = 0;
		end
		else if(!a_taken)// || !b_taken)
		begin
			if(a_available)
			begin
				in1 = a;
				a_taken = 1;
				if(b_taken)
				begin
					in_taken = 1;
					#1;//to start execution from next cyle  not from this cycle
					// diff_rst = 1;
				end
			end
		end
		else if(!b_taken)//loads only one input(a or b) in one cycle
		begin
			if(b_available)
			begin
				in2 = b;
				b_taken = 1;
				if(a_taken)
				begin
					in_taken = 1;
					#1;
				end
			end
		end
	end


	always@(posedge clk)//for state transition 
	begin
		if(!rst && in_taken)
		begin
			case(current_state)
				DIFF:
				begin
					if(diff_out_ready)
					begin
						if(diff[8] == 1)
						begin
							next_state <= SWP;
							swp_done <= 0;
						end
						else if(!diff)//i.e. if diff==0 
						begin
							next_state <= DONE;
						end
						else //if(diff > 0) i.e. bitwise-or of all bits  is 1
						begin
							in1 <= diff;
						end						
					end
				end
				SWP:
				//swap state- swaps two input values - in1,in2
				begin
					#1;
					if(!swp_done)//to prevent repeated calculations
					begin
						swp_done = 1;
						in1 <= in2;
						in2 <= in1;
						next_state = DIFF;//next state is to perform repeated subtraction again
					end
				end
				DONE:
				//final state is reached,output wont change for these inputs
				begin
					out <= in2;
					out_ready <= 1; 
				end
			endcase
		end
	end

endmodule
