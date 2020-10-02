/*
Assignment - 3
Problem - 2
Semester - 5
Group no. : G26
K Rahul Sai - 18CS10028
D Jaswanth - 18CS10014
*/

//code for unsigned sequential multiplication left to right


module unsigned_seq_mult_ls(output reg [11:0] product,input clk, input rst, input load, input [5:0] a, input [5:0] b);
    integer counter;//to keep track of number of additions performed
    reg [5:0] in1,in2;//to store loaded inputs
    reg [11:0] out;//to store value to be added to product to reach final state
    always@(posedge clk)
    begin
        if(rst)//resets all values to zero initially
        begin
            in1 = 6'b0;
            in2 = 6'b0;
            counter = 0;
            out = 12'b0;
            product = 12'b0;
        end
        else
        begin
            if(load) //load and store inputs
            begin
                in1 = a;
                in2 = b;
                counter = 0;
                out = a;
                product = 12'b0;
            end
            else  
            begin
                if(counter < 6)//execute addition 6 times
                begin
                    if(counter > 0) out = out << 1;
                    if(in2[counter])
                    begin        //update product accordingly       
                        product = product + out;             
                    end
                    counter = counter+1;
                end
            end
        end
    end

endmodule