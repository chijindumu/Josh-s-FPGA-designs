`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Joshua
// 
// Create Date: 02/07/2026 09:01:55 PM
// Design Name: One_Hz clock generator
// Module Name: one_hz
// Project Name: seven segment digital clock
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


module one_hz(
    input clk_100Mhz,
    output clk_1hz
    );
    
    reg [25:0] r_count_clk_hz = 0;
    reg r_onehz = 1'b0;
    
    always@(posedge clk_100Mhz)begin
    // checks if count is equal to half a million cycles then assign 1 to it and 0 to the other half, hence
    // it has been reduced to one cycle since 0 is half and 1 is the other half.
        if(r_count_clk_hz == 49_999_999)begin
            r_count_clk_hz <= 0;
            r_onehz <= ~r_onehz;
        end else begin
            r_count_clk_hz = r_count_clk_hz + 1;
        end
    end
    
    assign clk_1hz = r_onehz;
endmodule