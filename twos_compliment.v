/*
Assignment - 4
Problem - 1
Semester - 5
Group no. : G26
K Rahul Sai - 18CS10028
D Jaswanth - 18CS10014
*/

//code for FSM to print twos compliment
/*
Transition chart:
current state  - input - next state - output
S1            -    1    - S2        -  1
S2            -     1   -  S2        - 0
S1          -      0    -  S1        - 0
S2            -     0   -  S2         - 1
*/

`timescale 1ns / 10ps

module twos_compliment(
        input in,
        input clk,
        input rst,
        output reg out
    );
    reg current_state,next_state;
    parameter S1 = 1'b0, S2 = 1'b1;//state representation
    
    always @(posedge clk)
    begin  //update current state to next state on every cycle
        current_state = next_state;
        #1;
    end

    always @(posedge clk)//for next_state
    begin
        if(rst) //reset brings  current and next state to initial state S1.
        begin         
            current_state = S1;
            next_state = S1;
        end
        else
        begin//from transition chart
            if(in)
            begin
                case(current_state)
                    S1: next_state <= S2;
                    S2: next_state <= S2;
                    default: next_state <= S1;
                endcase
            end
        end
    end
    
    always @(posedge clk) //for output
    begin
        if(rst)
            out = 0;
        if(in)
        begin//from transition chart
            case(current_state)
            S1: out <= 1;
            S2: out <= 0;
            default: out <= 0;
            endcase
        end
         else
        begin
            case(current_state)
                S1: out <= 0;
                S2: out <= 1;
                default: out <= 0;
            endcase
        end
    end
endmodule
