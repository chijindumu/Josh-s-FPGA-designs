`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Joshua
// 
// Create Date: 02/08/2026 03:13:13 AM
// Design Name: 
// Module Name: seg7_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seg7_control(
    input clk_100Mhz,
    input reset,
    input [2:0] hrs_tens, mins_tens,
    input [3:0] hrs_ones, mins_ones,
    output [0:6] seg,
    output [3:0] an
    );
    
    localparam [0:6]
        NULL = 7'b111_1111,
        ZERO = 7'b000_0001, // ZERO
        ONE = 7'b100_1111, // ONE
        TWO = 7'b001_0010, // TWO
        THREE = 7'b000_0110, // 3
        FOUR  = 7'b100_1100,  // 4
        FIVE  = 7'b010_0100,  // 5
        SIX   = 7'b010_0000,  // 6
        SEVEN = 7'b000_1111,  // 7
        EIGHT = 7'b000_0000,  // 8
        NINE  = 7'b000_0100;  // 9
        
        reg [1:0] anode_select; //selects the anode 
        reg [16:0] anode_timer; // times the anode to ensure its speed
        reg [3:0] r_an;
        reg [0:6] r_seg;
        
        always @(posedge clk_100Mhz or posedge reset) begin
            if(reset) begin
                anode_select <= 0;
                anode_timer <= 0; 
            end
            else
            // every 1ms the anode selects a new digit
                if(anode_timer == 99_999) begin
                    anode_timer <= 0;
                    anode_select <=  anode_select + 1;
                end
                else
                    anode_timer <=  anode_timer + 1;
        end
        
        always @(anode_select) begin
            case(anode_select) // selects which of the 4 digits will be on
            // anode is active low and selects the digits based on the current state of the anode select
            // 4 bits since we have 4 digits
                2'b00 : r_an = 4'b0111;
                2'b01 : r_an = 4'b1011;
                2'b10 : r_an = 4'b1101;
                2'b11 : r_an = 4'b1110;
            endcase
        end
        
        assign an = r_an;
        
        always @*
        case(anode_select)
            2'b00 : begin       // HOURS TENS DIGIT
                        case(hrs_tens)
                            3'b000 : r_seg = NULL; // at zero it is off
                            3'b001 : r_seg = ONE; // at 1, the 1 is displayed
                        endcase
                    end
                    
            2'b01 : begin       // HOURS ONES DIGIT
                        // 4 bits to hold 9 states
                        case(hrs_ones)
                            4'b0000 : r_seg = ZERO;
                            4'b0001 : r_seg = ONE;
                            4'b0010 : r_seg = TWO;
                            4'b0011 : r_seg = THREE;
                            4'b0100 : r_seg = FOUR;
                            4'b0101 : r_seg = FIVE;
                            4'b0110 : r_seg = SIX;
                            4'b0111 : r_seg = SEVEN;
                            4'b1000 : r_seg = EIGHT;
                            4'b1001 : r_seg = NINE;
                        endcase
                    end
                    
            2'b10 : begin       // MINUTES TENS DIGIT
                        case(mins_tens)
                        // 3 bits so it can hold 5 states
                            3'b000 : r_seg = ZERO;
                            3'b001 : r_seg = ONE;
                            3'b010 : r_seg = TWO;
                            3'b011 : r_seg = THREE;
                            3'b100 : r_seg = FOUR;
                            3'b101 : r_seg = FIVE;
                        endcase
                    end
                    
            2'b11 : begin       // MINUTES ONES DIGIT
            // 4 bitss so it can hold 9 states
                        case(mins_ones)
                            4'b0000 : r_seg = ZERO;
                            4'b0001 : r_seg = ONE;
                            4'b0010 : r_seg = TWO;
                            4'b0011 : r_seg = THREE;
                            4'b0100 : r_seg = FOUR;
                            4'b0101 : r_seg = FIVE;
                            4'b0110 : r_seg = SIX;
                            4'b0111 : r_seg = SEVEN;
                            4'b1000 : r_seg = EIGHT;
                            4'b1001 : r_seg = NINE;
                        endcase
                    end
        endcase
        
        assign seg = r_seg;
    
endmodule
