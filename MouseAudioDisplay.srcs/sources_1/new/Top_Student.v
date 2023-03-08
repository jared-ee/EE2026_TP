`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input basys_clk,
    input [11:0] sw,
    output J_MIC3_Pin1,   
    input  J_MIC3_Pin3,   
    output J_MIC3_Pin4,    
    output reg [8:0]led,
    output reg [3:0] an = 4'b1111,
    output reg [7:0] seg = 8'b11111111
    );
    
    wire clk20khz;
    //wire clk100Mhz;
    wire clk10hz;                      
    reg [11:0]mic_in = 12'b000000000000;
    wire [11:0]mic_out;
    reg my_chosen_clock;
    
    //This count variable is used for the Audio Volume Indicator Task
    reg [31:0] count_AVI = 0;
    reg [11:0] curr_mic_val = 0;
    reg [11:0] peak_val = 0;
    reg [8:0] state_val = 0;
  
    
    clk20k dut1(basys_clk, clk20khz);
    clk100MHz dut2(basys_clk, clk100Mhz);
    clk10Hz dut3(basys_clk, clk10hz);
    Audio_Input audioInput(basys_clk, clk20khz, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, mic_out); 
     
//    always @ (posedge basys_clk) begin
//        my_chosen_clock <= (sw[1] == 1) ? clk10hz : clk20khz;
//    end
    
//    always @ (posedge my_chosen_clock)
//    begin
//        led[11:0] <= mic_out;
//    end

    //This count variable is used for the Audio Volume Indicator Task
//    reg [31:0] count_AVI = 0;
//    reg [11:0] curr_mic_val = 0;
//    reg [11:0] peak_val = 0;
//    reg [8:0] led_on = 0;

    always @ (posedge clk20khz)
    begin
        count_AVI <= count_AVI + 1;
        curr_mic_val <= mic_out;
        if (curr_mic_val > peak_val)
            peak_val <= curr_mic_val;
        if (count_AVI == 2000)
        begin
            if (peak_val < 2200)
                state_val <= 0;
            else if (peak_val >= 2200 && peak_val < 2400)
                state_val <= 1;
            else if (peak_val >= 2400 && peak_val < 2600)
                state_val <= 2;
            else if (peak_val >= 2600 && peak_val < 2800)
                state_val <= 3;
            else if (peak_val >= 2800 && peak_val < 3000)
                state_val <= 4;                
            else if (peak_val >= 3000 && peak_val < 3200)
                state_val <= 5;
            else if (peak_val >= 3200 && peak_val < 3400)
                state_val <= 6;
            else if (peak_val >= 3400 && peak_val < 3600)
                state_val <= 7;
            else if (peak_val >= 3600 && peak_val < 3800)
                state_val <= 8;
            else
                state_val <= 9;
            count_AVI <= 0;
            peak_val <= 0;
        end
    end
    
   always @ (posedge clk100Mhz)begin
   an <= 4'b1111;
   seg <= 8'b11111111;
   case(state_val)
       0:
       begin
           seg <= 8'b11000000;
           an <= 4'b1110;
           led <= 9'b000000000;
       end
       1:
       begin
           seg <= 8'b11111001;
           an <= 4'b1110;
           led <= 9'b000000001;
       end
       2:
       begin
           seg <= 8'b10100100;
           an <= 4'b1110;
           led <= 9'b000000011;
       end
       3:
       begin
           seg <= 8'b10110000;
           an <= 4'b1110;
           led <= 9'b000000111;
       end
       4:
       begin
           seg <= 8'b10011001;
           an <= 4'b1110;
           led <= 9'b000001111;
       end
       5:
       begin
           seg <= 8'b10010010;
           an <= 4'b1110;
           led <= 9'b000011111;
       end
       6:
       begin
           seg <= 8'b10000011;
           an <= 4'b1110;
           led <= 9'b000111111;
       end
       7:
       begin
           seg <= 8'b11111000;
           an <= 4'b1110;
           led <= 9'b001111111;
       end
       8:
       begin
           seg <= 8'b10000000;
           an <= 4'b1110;
           led <= 9'b011111111;
       end
       9:
       begin
           seg <= 8'b10011000;
           an <= 4'b1110;
           led <= 9'b111111111;
       end
       default:
       begin
           an <= 4'b1110;
           led <= 9'b111111111;
       end
   endcase   
   end
       


        
//   assign led[11:0] = mic_out;

    // Delete this comment and write your codes and instantiations here
    
endmodule