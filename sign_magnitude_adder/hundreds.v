`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: JOSHUA
// 
// Create Date: 02/14/2026 07:16:28 PM
// Design Name: hundred, tens and units module
// Module Name: hundreds
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


module hundreds(
    input wire [7:0] mag,
    output reg [3:0] hundred, tens, unit
    );
    
        always @*
            begin
              hundred <= mag / 100;
              tens <= (mag % 100) / 10;
              unit <= (mag % 100) % 10;
            end
endmodule
