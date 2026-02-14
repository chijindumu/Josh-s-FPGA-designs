`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: JOSHUA
// 
// Create Date: 02/14/2026 01:06:08 PM
// Design Name: debouncer module
// Module Name: debouncer
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

module btn_debouncer #(parameter COUNT_SIZE = 10000)(
    input clk_100Mhz,
    input [2:0] btn_in,
    output reg [2:0] btn_out
    );
    
    reg [2:0] r_btn_in = 0;
    //reg r_btn_out;
    reg [13:0] counter;
    
    always@(posedge clk_100Mhz)begin
        if(btn_in != r_btn_in)begin
            if(counter == COUNT_SIZE - 1)begin
                counter <= 0;
                btn_out <= btn_in;
            end else begin
                counter <= counter + 1;
            end
        end else begin
            counter <= 0;
        end
    end
    
endmodule