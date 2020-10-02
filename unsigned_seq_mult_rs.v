/*
Assignment - 3
Problem - 3
Semester - 5
Group no. : G26
K Rahul Sai - 18CS10028
D Jaswanth - 18CS10014
*/

//code for unsigned sequential multiplication right to left


module unsigned_seq_mult_rs(output reg [11:0] product,input clk, input rst, input load, input [5:0] a, input [5:0] b);
    integer counter;//to keep track of processed bits in second multiplier
    reg [5:0] in1,in2;//to store loaded inputs
    reg [6:0] temp;//to store the values from -perform addition on current product and perform right shift process
    //(in test bench)first use reset to 1 then reset to 0 then load to 1 and give inputs and load again to 0,then execution begins
    always@(posedge clk)
    begin
        if(rst)//resets inputs and product to 0.
        begin
            in1 = 6'b0;
            in2 = 6'b0;
            counter = 7;//to  prevent running of loop below when unnecessary
            product = 12'b0;
            temp = 7'b0;
        end
        else
        begin
            if(load) //loads both inputs parallelly
            begin
                in1 = a;
                in2 = b;
                counter = 0;// to start multiplication
            end
            else  
            begin
                if(counter < 6)
                begin
                    if(in2[counter]) temp = temp + in1;//stores in1+product left till now(last 7 bits)
                    product[counter] = temp[0];//LSB is sent to product's corresponding position
                    temp = temp >> 1;//discard LSB by right shift
                    counter = counter+1;
                end
                else if(counter == 6)
                begin
                    product[11:6] = temp[5:0];//finally send the left over product to corresponding positions
                    counter = counter+1;
                end
            end
        end
    end

endmodule