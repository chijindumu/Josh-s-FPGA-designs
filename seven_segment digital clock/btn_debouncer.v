`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Joshua
// 
// Create Date: 02/07/2026 10:03:06 PM
// Design Name: Button debouncer
// Module Name: btn_debouncer
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
    input btn_in,
    output btn_out
    );
    
    reg r_btn_in = 0;
    //reg r_btn_out;
    reg [13:0] counter;
    
    always@(posedge clk_100Mhz)begin
        if(btn_in != r_btn_in)begin
            if(counter == COUNT_SIZE - 1)begin
                counter <= 0;
                r_btn_in <= btn_in;
            end else begin
                counter <= counter + 1;
            end
        end else begin
            counter <= 0;
        end
    end
    assign btn_out = r_btn_in;
endmodule
