`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Joshua
// 
// Create Date: 02/07/2026 10:47:43 PM
// Design Name: Seconds module
// Module Name: seconds
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


module seconds(
    input clk_1Hz,
    input reset,
    output inc_mins
    );
    
    reg [5:0] r_inc_mins = 0;
    
    always@(posedge clk_1Hz, posedge reset)begin
        if(reset)begin
            r_inc_mins <= 0;
        end else begin
            if(r_inc_mins == 59)begin
                r_inc_mins <= 0;
            end else begin
                r_inc_mins <= r_inc_mins + 1;
            end
        end
    end
    
    assign inc_mins = (r_inc_mins == 59) ? 1 : 0;
    
endmodule
