`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Joshua
// 
// Create Date: 02/08/2026 02:46:08 AM
// Design Name: hours module
// Module Name: hours
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


module hours(
    input inc_hours,
    input reset,
    output [3:0] hours
    );
    
    reg [3:0] r_hours = 12; 
    
    always@(negedge inc_hours, posedge reset)begin
        if(reset)begin
            r_hours <= 12;
        end else begin
            if(r_hours == 12)begin
                r_hours <= 1;
            end else begin
                r_hours <= r_hours + 1;
            end
        end
    end
    
    assign hours = r_hours;
    
endmodule
