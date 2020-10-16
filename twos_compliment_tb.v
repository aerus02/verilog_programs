/*
Assignment - 4
Problem - 1
Semester - 5
Group no. : G26
K Rahul Sai - 18CS10028
D Jaswanth - 18CS10014
*/

//test bench for FSM to print twos compliment


`timescale 1ns / 10ps


module twos_compliment_tb();
//input bits should be provided consecutively on successive cyles
//only for input is 0 ,the overflow bit is not showed.

    reg in, rst, clk;
    wire out;
    twos_compliment inst(.out(out),.in(in),.clk(clk),.rst(rst));
    initial
        begin
            clk = 0;
        forever #5 clk = ~clk;
        end
        initial
        begin
            rst = 1;
            #10
            rst = 0;
            in = 1;
            #10
            $display("Output is %b",out);          
            in = 0;
            #10
            $display("Output is %b",out);            
            in = 1;
            #10
            $display("Output is %b",out);
            $finish;
        end
        /*
        For input : 101 output will be 011
        111 - 001
        100 - 100

        */
endmodule
