/*
Assignment - 5
Problem - 4
Semester - 5
Group no. : G26
K Rahul Sai - 18CS10028
D Jaswanth - 18CS10014
*/

//code for carry save adder

/*
	uses a tree structure to compute sum of 9 inputs each of 16 bits and generates a 20 bit sum as output
	Uses a total of  7 cla adder blocks in 3,2,1,1 pattern in 4 levels respectively and 4 carry lookahead adders(4-bit) in last level.
*/

`timescale 1ns / 1ps

module half_adder(output sum,output carry,input in1,input in2 // code for half adder
	);
	assign sum = in1 ^ in2;
	assign carry = in1 & in2;

endmodule


module full_adder(output sum,output carry,input in1,input in2,input cin // module for full adder using above define half adder
	);
	wire c1,s1,c2;
	half_adder ha1(.sum(s1),.carry(c1),.in1(in1),.in2(in2));
	half_adder ha2(.sum(sum),.carry(c2),.in1(cin),.in2(s1));
	assign carry = c1|c2;
	
endmodule


module cla_adder(output [3:0] sum,output cout,input [3:0] in1,input [3:0] in2,input cin
   ); //module for carry look ahead adder using below defined carry look ahead block

	wire [3:0] P,G;
	wire [4:0] C;   
	assign P = in1 ^ in2;
	assign G = in1 & in2;
	cla_block block(.C(C),.P(P),.G(G),.cin(cin));
	assign sum = P ^ C[3:0];
	assign cout = C[4];

endmodule


module cla_block(output [4:0] C,input [3:0] P,G,input cin
    ); //module for carry look ahead block to generate carries using propogates and generates.
            
	assign C[0] = cin;
	assign C[1] = G[0] | (P[0] & cin);
	assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & cin);
	assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & cin);
	assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & cin);

endmodule


module csa_block(output [15:0] sum,output  [15:0] cout,input[15:0] a1,input [15:0] a2,input [15:0] a3
	); //module carry cave adder block that takes 3 inputs of 16 bits each and genrates 16 bit sum and 16 bit carry
	
	full_adder fa0(.sum(sum[0]),.carry(cout[0]),.in1(a1[0]),.in2(a2[0]),.cin(a3[0]));
	full_adder fa1(.sum(sum[1]),.carry(cout[1]),.in1(a1[1]),.in2(a2[1]),.cin(a3[1]));
	full_adder fa2(.sum(sum[2]),.carry(cout[2]),.in1(a1[2]),.in2(a2[2]),.cin(a3[2]));
	full_adder fa3(.sum(sum[3]),.carry(cout[3]),.in1(a1[3]),.in2(a2[3]),.cin(a3[3]));	
	full_adder fa4(.sum(sum[4]),.carry(cout[4]),.in1(a1[4]),.in2(a2[4]),.cin(a3[4]));
	full_adder fa5(.sum(sum[5]),.carry(cout[5]),.in1(a1[5]),.in2(a2[5]),.cin(a3[5]));
	full_adder fa6(.sum(sum[6]),.carry(cout[6]),.in1(a1[6]),.in2(a2[6]),.cin(a3[6]));
	full_adder fa7(.sum(sum[7]),.carry(cout[7]),.in1(a1[7]),.in2(a2[7]),.cin(a3[7]));
	full_adder fa8(.sum(sum[8]),.carry(cout[8]),.in1(a1[8]),.in2(a2[8]),.cin(a3[8]));
	full_adder fa9(.sum(sum[9]),.carry(cout[9]),.in1(a1[9]),.in2(a2[9]),.cin(a3[9]));
	full_adder fa10(.sum(sum[10]),.carry(cout[10]),.in1(a1[10]),.in2(a2[10]),.cin(a3[10]));
	full_adder fa11(.sum(sum[11]),.carry(cout[11]),.in1(a1[11]),.in2(a2[11]),.cin(a3[11]));
	full_adder fa12(.sum(sum[12]),.carry(cout[12]),.in1(a1[12]),.in2(a2[12]),.cin(a3[12]));
	full_adder fa13(.sum(sum[13]),.carry(cout[13]),.in1(a1[13]),.in2(a2[13]),.cin(a3[13]));
	full_adder fa14(.sum(sum[14]),.carry(cout[14]),.in1(a1[14]),.in2(a2[14]),.cin(a3[14]));
	full_adder fa15(.sum(sum[15]),.carry(cout[15]),.in1(a1[15]),.in2(a2[15]),.cin(a3[15]));

endmodule


module carry_save_adder_9(output [19:0] sum,input [15:0] a0,input [15:0] a1,input [15:0] a2,input [15:0] a3,input [15:0] a4,input [15:0] a5,input [15:0] a6,input [15:0] a7,input [15:0] a8 
    );
	 //16*7
	wire [15:0] inter_sums0,inter_sums1,inter_sums2,inter_sums3,inter_sums4,inter_sums5,inter_sums6;
	wire [15:0] car0,car1,car2,car3,car4,car5,car6;
	wire zero_always;
	assign zero_always = 0;
	
	csa_block c0(.sum(inter_sums0),.cout(car0),.a1(a0),.a2(a1),.a3(a2));
	csa_block c1(.sum(inter_sums1),.cout(car1),.a1(a3),.a2(a4),.a3(a5));
	csa_block c2(.sum(inter_sums2),.cout(car2),.a1(a6),.a2(a7),.a3(a8));
	csa_block c3(.sum(inter_sums3),.cout(car3),.a1(inter_sums0),.a2(inter_sums1),.a3(inter_sums2));
	csa_block c4(.sum(inter_sums4),.cout(car4),.a1(car0),.a2(car1),.a3(car2));
	csa_block c5(.sum(inter_sums5),.cout(car5),.a1({zero_always,inter_sums3[15:1]}),.a2(inter_sums4[15:0]),.a3(car3[15:0]));

	csa_block c6(.sum(inter_sums6),.cout(car6),.a1(car4),.a2({zero_always,inter_sums5[15:1]}),.a3(car5));
	wire [3:0] ripple_carries;
	cla_adder cla0(.sum(sum[6:3]),.cout(ripple_carries[0]),.in1(inter_sums6[4:1]),.in2(car6[3:0]),.cin(zero_always));
	cla_adder cla1(.sum(sum[10:7]),.cout(ripple_carries[1]),.in1(inter_sums6[8:5]),.in2(car6[7:4]),.cin(ripple_carries[0]));
	cla_adder cla2(.sum(sum[14:11]),.cout(ripple_carries[2]),.in1(inter_sums6[12:9]),.in2(car6[11:8]),.cin(ripple_carries[1]));
	cla_adder cla3(.sum(sum[18:15]),.cout(ripple_carries[3]),.in1({zero_always,inter_sums6[15:13]}),.in2(car6[15:12]),.cin(ripple_carries[2]));

	assign sum[0] = inter_sums3[0];
	assign sum[1] = inter_sums5[0];
	assign sum[2] = inter_sums6[0];
	assign sum[19] = ripple_carries[3];


endmodule
