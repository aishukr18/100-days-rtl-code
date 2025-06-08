module FSM_vending_machine(clk, rst, coin, X);
    input clk, rst;
    input [1:0]coin;
    output reg X;
    
    parameter Idle= 2'b00;
    parameter S1= 2'b01;
    parameter S2= 2'b10;
    parameter S3= 2'b11;
    
    reg soft_rst;
    reg [1:0] ps,ns;
    reg [9:0]count_clk;
    reg [2:0]count_sec;

    always@(posedge clk, posedge rst)
        begin
            if(rst)
                count_clk <= 0;
            else
                begin
                    if ((coin[1] == 1'b0)&& ((ps == S1)||(ps == S2)||(ps== S3)))
                        count_clk <= count_clk + 1'b1;
                    else
                        count_clk <= 0;
                end
        end
    //Logic for counter that counts sec pulses
    always@(posedge clk, posedge rst)
        begin
            if (rst)
                begin
                    count_sec <= 0;
                    soft_rst<=1'b0;
                end
            else
                begin
                    if (coin[1] != 1'b0)
                        begin
                            count_sec <= 0;
                            soft_rst <=1'b0;
                        end 
                    else
                        begin
                            if(count_clk == 1023)
                                begin
                                    if (count_sec == 5)
                                        begin
                                            count_sec <= 0;
                                            soft_rst <=1'b1;
                                        end
                                    else
                                        begin
                                            count_sec <= count_sec + 1'b1;
                                            soft_rst<=1'b0;
                                    end
                                end
                        end
                end
        end 

    always @(posedge clk or posedge rst)
        begin
            if(rst)
                ps <= Idle;
            else if(soft_rst)
                ps<=Idle;
            else
                ps<=ns;
        end
    //next state logic
    always @(*)
        begin
            ns = Idle;
            case(ps)
            Idle:if(coin == 2'b10)
                    ns = S1;
                 else if (coin == 2'b11)
                    ns = S2;
                 else
                    ns = Idle;
            S1 : if(coin == 2'b10)
                    ns = S2;
                 else if (coin == 2'b11)
                    ns = S3;
                 else
                    ns = S1;
            S2 : if(coin == 2'b10)
                    ns = S3;
                 else if (coin == 2'b11)
                    ns = Idle;
                 else
                    ns = S2;
            S3 : if((coin == 2'b10)||(coin == 2'b11))
                    ns = Idle;
                 else
                    ns = S3;
            endcase
       end
    //output logic
    always @(posedge clk or posedge rst)
        begin
            if(rst)
                begin
                    X <=1'b0;
                end
            else if(soft_rst)
                begin
                    X <=1'b0;
                end
            else
                begin
                    case(ps)
                    Idle,S1 : X <= 1'b0;
                    S2 : if (coin == 2'b11)
                            X <= 1'b1;
                         else
                            X <= 1'b0;
                    S3 : if((coin == 2'b10)||(coin == 2'b11))
                            X <=1'b1;
                    default: X <=1'b0;
                    endcase
                end
        end
endmodule
