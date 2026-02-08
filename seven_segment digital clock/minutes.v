`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Joshuia
// 
// Create Date: 02/08/2026 02:34:59 AM
// Design Name: Minutes module
// Module Name: minutes
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


module minutes(
    input inc_mins,
    input reset,
    output inc_hours,
    output [5:0] minutes
    );
    
    reg [5:0] minute_ctrl;
    
    always@(negedge inc_mins, posedge reset)begin
        if(reset)begin
            minute_ctrl <= 0;
        end else begin
            if(minute_ctrl == 59)begin
                minute_ctrl <= 0;
            end else begin
                minute_ctrl <= minute_ctrl + 1;
            end
        end
    end
    
    assign minutes = minute_ctrl;
    assign inc_hours = (minute_ctrl == 59) ? 1 : 0;
    
endmodule
