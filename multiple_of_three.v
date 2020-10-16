/*
Assignment - 4
Problem - 2
Semester - 5
Group no. : G26
K Rahul Sai - 18CS10028
D Jaswanth - 18CS10014
*/

//code for FSM to check divisibility by 3


`timescale  1ns/10ps
/*
state transition chart:

notation : onetwo means - when input bit is i,it is to be considered as (one*i+current remainder by 3)%3.
And current remainder when divided by 3 is represented by second half in state name i.e for state onetwo,current remainder is 2.
So if input bit is 1 for state onetwo,final remainder of total bitstring till now will be (1*1+2)%3 = 0.

If total remainder till now is 0 then output will be 1  i.e. string given till now is divisible by 3 and similarly for output 0.

Initial state - onezero

Current state  - input - Next state  - Output
onezero        - 0     -  twozero    -  1
oneone         - 0     -  twoone     -  0
onetwo         - 0     -   twotwo    -  0
twozero        - 0     -   onezero   -  1
twoone         - 0     -   oneone    -  0   
twotwo         - 0     -   onetwo    -  0
onezero        - 1     -    twoone   -  0
oneone         - 1     -    twotwo   -  0
onetwo         - 1     -    twozero  -  1
twozero        - 1     -    onetwo   -  0
twoone         - 1     -    onezero  -  1
twotwo         - 1     -    oneone   -  0


*/


module multiple_of_three(out,rst,in,clk);
	input in,rst,clk;  //input bit,clock,reset bit
	output reg out;  //output bit
	reg [2:0]current_state,next_state;
	parameter onezero = 3'b000;  //states encoding in binary
	parameter	oneone = 3'b001;
	parameter	onetwo = 3'b010;
	parameter	twozero = 3'b011;
	parameter	twoone = 3'b100;
	parameter	twotwo = 3'b101;

	always @(posedge clk)
	begin
		if(rst == 0) 
		begin  // update current state to next state atbeginning of execution whenever reset is not 1
			current_state = next_state;
			#1;
		end
	end

	always @(posedge clk)//for next state
	begin
		if(rst == 1)
		begin //when reset,current state goes to beginning state
			current_state <= onezero;
			next_state <= onezero;
		end
		else 
		begin
			if(in == 1)
			begin
				case(current_state)//according to transition table above
					onezero:
					next_state <=  twoone;
					oneone:
					next_state <=  twotwo;
					onetwo:
					next_state <=  twozero;
					twozero:
					next_state <=  onetwo;
					twoone:
					next_state <=  onezero;
					twotwo:
					next_state <=  oneone;
					default: next_state <= onezero;
				endcase
			end
			else 
			begin
				case(current_state) //according to transition table above
					onezero:
					next_state <=  twozero;
					oneone:
					next_state <=  twoone;
					onetwo:
					next_state <=  twotwo;
					twozero:
					next_state <=  onezero;
					twoone:
					next_state <=  oneone;
					twotwo:
					next_state <=  onetwo;
					default: next_state <= onezero;
				endcase
			end
		end
	end

	always @(posedge clk)//for output
	begin//returns 0 for not divisible by 3 and 1 if divisible
		if(rst == 1)
		begin
			out <= 0;
		end
		else 
		begin
			if(in == 1)
			begin
				case(current_state) //according to transition table above
					onezero:
					// out = i;
					out <= 0;
					oneone:
					out <= 0;
					onetwo:
					out <= 1;
					twozero:
					out <= 0;
					twoone:
					out <= 1;
					twotwo:
					out <= 0;
					default: out <= 0;
				endcase
			end
			else 
			begin
				case(current_state) //according to transition table above
					onezero:
					out <= 1;
					oneone:
					out <= 0;
					onetwo:
					out <= 0;
					twozero:
					out <= 1;
					twoone:
					out <= 0;
					twotwo:
					out <= 0;
					default: out <= 0;
				endcase
			end
		end
	end


endmodule