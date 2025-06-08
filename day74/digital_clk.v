module digital_clk(clk,reset,load,load_ms_hr,load_ms_min,load_ls_hr,load_ls_min,time_ms_hr,time_ms_min,time_ls_hr,time_ls_min);

    input clk,reset,load;
    input [3:0] load_ms_hr,load_ms_min,load_ls_hr,load_ls_min;
    output reg [3:0] time_ms_hr,time_ms_min,time_ls_hr,time_ls_min;
    
    reg [5:0]count;
    reg one_minute_reg;

    always@(posedge clk or posedge reset)
        begin
        // Upon reset, set the one_minute_reg value to zero
            if (reset)
                begin
                    count<=6'b0;
                    one_minute_reg<=0;
                end
            else if (load)
                begin
                    count<=6'b0;
                    one_minute_reg<=0;
            end 
        // Else check if the count value reaches 59 to generate 1 minute pulse
            else if (count== 6'd59)
                begin
                    count<=6'b0;
                    one_minute_reg<=1'b1;
            end 
        // Else for every posedge of clock just increment the count.
            else
                begin
                    count<=count+1'b1;
                    one_minute_reg<=1'b0;
                end
            end
    always@( posedge clk or posedge reset)
        begin
            if(reset)
                begin
                    time_ms_hr <= 4'd0;
                    time_ms_min <= 4'd0;
                    time_ls_hr <= 4'd0;
                    time_ls_min <= 4'd0;
                    end 
            else if(load)
                begin
                    time_ms_hr <= load_ms_hr;
                    time_ms_min <= load_ms_min;
                    time_ls_hr <= load_ls_hr;
                    time_ls_min <= load_ls_min;
                end
    // 0 0 0 9 -> 00:10
            else if (one_minute_reg == 1)
                begin
    // If the current_time is 23:59, then the next current_time will be 00:00
                    if(time_ms_hr == 4'd2 && time_ms_min == 4'd5 && time_ls_hr == 4'd3 && time_ls_min == 4'd9)
                        begin
                            time_ms_hr <= 4'd0;
                            time_ms_min <= 4'd0;
                            time_ls_hr <= 4'd0;
                            time_ls_min <= 4'd0;
                        end
            // Else check if the current_time is 09:59, then the next current_time will be 10:00
                    else if(time_ls_hr == 4'd9 && time_ms_min ==4'd5 && time_ls_min == 4'd9)
                        begin
                            time_ms_hr <= time_ms_hr + 1'd1;
                            time_ls_hr <= 4'd0;
                            time_ms_min <= 4'd0;
                            time_ls_min <= 4'd0;
                        end
            // Else check if the time represented by minutes is 59,Increment the LS_HR by 1 and set MS_MIN and LS_MIN to 1'b0
                    else if(time_ms_min==4'd5&&time_ls_min==4'd9)
                        begin
                            time_ls_hr <= time_ls_hr + 1'd1;
                            time_ms_min <= 4'd0;
                            time_ls_min <= 4'd0;
                        end 
            // Else check if the LS_MIN is equal to 9, Increment the MS_MIN by 1 and set MS_MIN to 1'b0
                    else if(time_ls_min == 4'd9)
                        begin
                            time_ms_min <= time_ms_min+1'd1;
                            time_ls_min <= 4'd0;
                        end
            // Else just increment the LS_MIN by 1
                    else
                        begin
                            time_ls_min <=time_ls_min+1'b1;
                        end
                end
        end
endmodule
