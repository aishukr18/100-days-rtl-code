module router_fifo(clock,resetn,soft_reset,write_enb,read_enb,lfd_state,data_in,empty,full,data_out);
    input clock,resetn,soft_reset,write_enb,read_enb,lfd_state;
    input [7:0]data_in;
    output empty,full;
    output reg [7:0]data_out;
    
    reg [8:0] mem[15:0];
    reg [4:0]wp,rp;
    reg [5:0]count;
    reg temp_lfd;
    integer i;
    
    //write block
    always@(posedge clock)
        begin
            if(resetn==1'b0)
                begin
                    wp<=5'b0;       
                    for(i=0;i<16;i=i+1)
                        mem[i]<=9'b0;
                end
            else if(soft_reset)
                begin
                    for(i=0;i<16;i=i+1)
                        mem[i]<=9'b0;
                end
            else if(write_enb==1'b1&&full==1'b0)
                begin
                    mem[wp[3:0]]<={temp_lfd,data_in};
                    wp<=wp+1;
                end
        end
    //lfd_state_delsy
    always@(posedge clock)
        begin
            if(resetn==1'b0)
                temp_lfd<=1'b0;
            else if(soft_reset)
                temp_lfd<=1'b0;
            else
                temp_lfd<=lfd_state;
        end
    //read block
    always@(posedge clock)
    begin
        if(resetn==1'b0)
            begin
                rp<=0;
                data_out<=8'b0; 
            end
        
        else if(read_enb==1'b1&&empty==1'b0)
            begin
                data_out<=mem[rp[3:0]];
                rp<=rp+1;
                //count<=count-1;
            end
        else if(soft_reset)
            begin
                data_out<=8'bz;
            end
        else if(count==1'b0)begin
              data_out<=8'bz;
        end
    end
    //reverse count block
    always@(posedge clock)
        begin
            if(resetn==1'b0)
                begin  
                    count<=6'b0; 
                end
            else if(soft_reset)
                count<=6'b0;
            else if(read_enb==1'b1&&empty==1'b0)
                begin
                    if(mem[rp[3:0]][8]==1'b1)
                         begin  
                            count<=mem[rp[3:0]][7:2]+1'b1;  
                         end
                     else if(count!=0)
                           count<=count-1;
                end
        end
    assign full=(wp==5'd16 && rp=='d0)?1'b1:1'b0;
    assign empty=(wp==rp)?1'b1:1'b0;
endmodule
