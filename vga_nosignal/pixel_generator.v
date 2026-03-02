`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2026 12:09:25 AM
// Design Name: 
// Module Name: pixel_generator
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


module pixel_gen(
    input video_on,
    input wire [9:0] x, y,
    output reg [11:0] rgb
);

    // rgb colour values

    parameter RED    = 12'h00F;
    parameter GREEN  = 12'h0F0;
    parameter BLUE   = 12'hF00;
    parameter YELLOW = 12'h0FF;     // RED and GREEN
    parameter AQUA   = 12'hFF0;     // GREEN and BLUE
    parameter VIOLET = 12'hF0F;     // RED and BLUE
    parameter WHITE  = 12'hFFF;     // all ON
    parameter BLACK  = 12'h000;     // all OFF
    parameter GRAY   = 12'hAAA;     // some of each color

    // upper part of the display
    wire up_white, up_yellow, up_aqua, up_green, up_violet, up_red, up_blue;
    wire low_blue, low_black1, low_violet, low_gray, low_aqua, low_black2, low_white;

    //setting boundaries foir object mapped scheme

    // Upper Section
    assign up_white  = ((x >= 0)   && (x < 91)   &&  (y >= 0) && (y < 412));
    assign up_yellow = ((x >= 91)  && (x < 182)  &&  (y >= 0) && (y < 412));
    assign up_aqua   = ((x >= 182) && (x < 273)  &&  (y >= 0) && (y < 412));
    assign up_green  = ((x >= 273) && (x < 364)  &&  (y >= 0) && (y < 412));
    assign up_violet = ((x >= 364) && (x < 455)  &&  (y >= 0) && (y < 412));
    assign up_red    = ((x >= 455) && (x < 546)  &&  (y >= 0) && (y < 412));
    assign up_blue   = ((x >= 546) && (x < 640)  &&  (y >= 0) && (y < 412));
    // Lower Sections
    assign low_blue   = ((x >= 0)   && (x < 91)   &&  (y >= 412) && (y < 480));
    assign low_black1 = ((x >= 91)  && (x < 182)  &&  (y >= 412) && (y < 480));
    assign low_violet = ((x >= 182) && (x < 273)  &&  (y >= 412) && (y < 480));
    assign low_gray   = ((x >= 273) && (x < 364)  &&  (y >= 412) && (y < 480));
    assign low_aqua   = ((x >= 364) && (x < 455)  &&  (y >= 412) && (y < 480));
    assign low_black2 = ((x >= 455) && (x < 546)  &&  (y >= 412) && (y < 480));
    assign low_white  = ((x >= 546) && (x < 640)  &&  (y >= 412) && (y < 480));

    // conditions for display

    always @* begin
        if(!video_on)begin
            rgb = BLACK;
        end else begin
            if (up_white) begin
                rgb = WHITE;
            end else if (up_yellow) begin
                rgb = YELLOW;
            end else if (up_aqua) begin
                rgb = AQUA;
            end else if (up_green) begin
                rgb = GREEN;
            end else if (up_violet) begin
                rgb = VIOLET;
            end else if (up_red) begin
                rgb = RED;
            end else if (up_blue) begin
                rgb = BLUE;
            end else if (low_blue) begin
                rgb = BLUE;
            end else if (low_black1) begin
                rgb = BLACK;
            end else if (low_violet) begin
                rgb = VIOLET;
            end else if (low_gray) begin
                rgb = GRAY;
            end else if (low_aqua) begin
                rgb = AQUA;
            end else if (low_black2) begin
                rgb = BLACK;
            end else if (low_white) begin
                rgb = WHITE;
            end
        end
    end

endmodule