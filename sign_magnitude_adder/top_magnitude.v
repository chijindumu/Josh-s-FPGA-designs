`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: JOSHUA
// 
// Create Date: 02/14/2026 09:49:13 AM
// Design Name: top module
// Module Name: top_magnitude
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

module top(
    input wire clk, reset,
    input wire [2:0] btn,
    input wire [15:0] sw,
    output wire [3:0] an,
    output wire [0:6] seg
);

    wire [7:0] sum;
    wire [7:0] oct;
    reg [7:0] mout;
    wire [6:0] led3, led2, led1, led0; 
    wire [2:0] btn_out;

    // instantiating the adder
    sign_mag sum_add(.a(sw[7:0]), .b(sw[15:8]), .sum(sum));

    // magnitude displayed ont the rightmost part
    btn_debouncer debounce(.clk_100Mhz(clk), .btn_in(btn), .btn_out(btn_out));
                 
    always @*
    begin
        case(btn_out)
            3'b001: mout = sw[7:0];
            3'b010: mout = sw[15:8];
            3'b100: mout = sum;
        endcase
    end              
    assign oct = {1'b0, mout[6:0]};
    //instantiate the hexdecoder to display the input
    hexseg_control controller(.clk(clk), .reset(reset), .mag(oct), .sign(mout[7]), .segs(seg), .an(an)); 

    
endmodule