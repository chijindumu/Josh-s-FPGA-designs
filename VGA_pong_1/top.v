`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2026 04:51:00 PM
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
    input up,
    input down,
    output hsync,
    output vsync,
    output [11:0] rgb
);
    
    wire w_reset, w_up, w_down, w_vid_on, w_p_tick;
    wire [9:0] w_x, w_y;
    reg [11:0] rgb_reg;
    wire [11:0] rgb_next;
    
    // buttons                 
    debounce debounceR(.clk(clk_100Mhz), .btn(reset), .db_level(w_reset));
    debounce debounceU(.clk(clk_100Mhz), .btn(up), .db_level(w_up));
    debounce debounceD(.clk(clk_100Mhz), .btn(down), .db_level(w_down));
    
    //vga controller
    vga_controller vga(.clk_100Mhz(clk_100Mhz), .reset(w_reset), .hsync(hsync), .vsync(vsync), .video_on(w_vid_on), .p_tick(w_p_tick), .x(w_x), .y(w_y));
    
    // pixel generator
    pixel_generator pixel_gen(.clk(clk_100Mhz), .reset(w_reset), .up(w_up), .down(w_down), .video_on(w_vid_on), .x(w_x), .y(w_y), .rgb(rgb_next));
    
    // rgb buffer
    always @(posedge clk_100Mhz)
        if(w_p_tick)
            rgb_reg <= rgb_next;
            
    assign rgb = rgb_reg;

endmodule
