/*
Assignment - 3
Problem - 2
Semester - 5
Group no. : G26
K Rahul Sai - 18CS10028
D Jaswanth - 18CS10014
*/

//test bench for unsigned sequential multiplication left to right

`timescale 1ns/10ps

module unsigned_seq_mult_ls_tb();
    reg [5:0] a,b;//inputs
    wire [11:0] product;//output
    reg clk,rst,load;
    initial
    begin//clock
        clk = 0;
        forever
        begin
            #5;
            clk = ~clk;            
        end      
    end 

    unsigned_seq_mult_ls multiply(.product(product),.clk(clk),.rst(rst),.load(load),.a(a),.b(b));

    initial
    begin
        #20;
        //in one instruction,either rst = 1 or load = 1 i.e. both should not be 1 at same time but both can be zero.
        rst = 1;//reset all values initially
        #10;
        rst = 0;
        #20;
        load = 1;
        a = 6'b111111;//change inputs here
        b = 6'b111111;
        $display("Product after time %4d is %b,other attributes- %b %b %b %b %4d %b",$time,product,load,rst,a,b,multiply.counter,multiply.out);
        #10;
        load = 0;
        $display("Product after time %4d is %b,other attributes- %b %b %b %b %4d %b",$time,product,load,rst,a,b,multiply.counter,multiply.out);
        #10;
         $display("Product after time %4d is %b,other attributes- %b %b %b %b %4d %b",$time,product,load,rst,a,b,multiply.counter,multiply.out);
        #10;
        $display("Product after time %4d is %b,other attributes- %b %b %b %b %4d %b",$time,product,load,rst,a,b,multiply.counter,multiply.out);
         #10;
        $display("Product after time %4d is %b,other attributes- %b %b %b %b %4d %b",$time,product,load,rst,a,b,multiply.counter,multiply.out);
         #10;
        $display("Product after time %4d is %b,other attributes- %b %b %b %b %4d %b",$time,product,load,rst,a,b,multiply.counter,multiply.out);
         #10;
        $display("Product after time %4d is %b,other attributes- %b %b %b %b %4d %b",$time,product,load,rst,a,b,multiply.counter,multiply.out);
         #10;
        $display("Product after time %4d is %b,other attributes- %b %b %b %b %4d %b",$time,product,load,rst,a,b,multiply.counter,multiply.out);
        #10;
        $display("Product after time %4d is %b,other attributes- %b %b %b %b %4d %b",$time,product,load,rst,a,b,multiply.counter,multiply.out);
        
        $finish;
    end
endmodule
