`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2026 12:04:03 AM
// Design Name: 
// Module Name: top
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


module top (
    input clk_100Mhz,
    input reset,
    output [11:0] rgb,
    output vsync,
    output hsync
);

    wire video_on, p_tick;
    wire [9:0] x, y;
    reg [11:0] rgb_reg;
    wire [11:0] rgb_next;

    vga_controller controller(.clk(clk_100Mhz), .reset(reset), .hsync(hsync), .vsync(vsync), .video_on(video_on), .p_tick(p_tick), .x(x), .y(y));
    pixel_gen pixel_generator(.video_on(video_on), .x(x), .y(y), .rgb(rgb_next));

    always @(posedge clk_100Mhz)
        if(p_tick)
            rgb_reg <= rgb_next;
            
    assign rgb = rgb_reg;
    
endmodule