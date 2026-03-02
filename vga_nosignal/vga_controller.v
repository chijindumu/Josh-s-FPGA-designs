`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2026 12:07:40 AM
// Design Name: 
// Module Name: vga_controller
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


module vga_controller(
    input clk,
    input reset, 
    output hsync,
    output vsync,
    output video_on,
    output p_tick,
    output [9:0] x, y
);

    // 640 * 480 resolution
    // vesa standards x = 800 pixel / line
    //                y = 525 lines / screen
    //                refresh rate = 60Hz or 60 screens / sec
    // hence the pixel rate is 800 * 525 * 60 = 25MHz

    // PARAMETERS

    // horizontal periods according to vesa standards
    parameter HD = 640;                     // display width
    parameter HR = 96;
    parameter HF = 48;
    parameter HB = 16;
    parameter HMAX = HD + HR + HF + HB - 1; // max pixels 799

    // vertical periods according to vesa standards
    parameter VD = 480;
    parameter VR = 2;
    parameter VF = 33;
    parameter VB = 10;
    parameter VMAX = VD + VR + VF + VB - 1;

    // CLOCK DIVIDER

    reg [1:0] r_clk25Mhz;
    wire clk_25Mhz;

    always @(posedge clk, posedge reset) begin
        if(reset)begin
            r_clk25Mhz <= 0;
        end else begin
            r_clk25Mhz <= r_clk25Mhz + 1;
        end
    end

    assign clk_25Mhz = (r_clk25Mhz == 0) ? 1'b1 : 1'b0;

    // COUNT REGISTERS
    reg [9:0] v_count_reg, v_count_next;
    reg [9:0] h_count_reg, h_count_next;
    
    // OUTPUT BUFFERS
    reg v_sync_reg, h_sync_reg;
    wire v_sync_next, h_sync_next;
    
    // register control

    always @(posedge clk, posedge reset) begin
        if(reset)begin
            v_count_reg <= 0;
            v_sync_reg <= 0;
            h_count_reg <= 0;
            h_sync_reg <= 0;
        end else begin
            v_count_reg <= v_count_next;
            v_sync_reg <= v_sync_next;
            h_count_reg <= h_count_next;
            h_sync_reg <= h_sync_next;
        end
    end

    // horizontal counter
    always @(posedge clk_25Mhz, posedge reset ) begin
        if(reset)begin
            h_count_next = 0;
        end else begin
            if(h_count_next == HMAX)begin
                h_count_next = 0;
            end else begin
                h_count_next = h_count_reg + 1;
            end
        end
    end

    // vertical counter
    always @(posedge clk_25Mhz, posedge reset) begin
        if(reset)begin
            v_count_next = 0;
        end else begin
            if(h_count_next == HMAX)begin
                if(v_count_next == VMAX)begin
                    v_count_next = 0;
                end else begin
                    v_count_next = v_count_reg + 1;
                end
            end
        end
    end

    assign video_on = (v_count_reg < VD) && (h_count_reg < HD);
    assign h_sync_next = (h_count_reg >= (HD + HB)) && (h_count_reg <= (HD + HB + HR - 1)); // asserted btw 656 and 751
    assign v_sync_next = (v_count_reg >= (VD + VB)) && (v_count_reg <= (VD + VB + VR - 1)); // asserted inbetween 490 and 491 

    // OUTPUT

    assign hsync = h_sync_reg;
    assign vsync = v_sync_reg;
    assign p_tick = clk_25Mhz;
    assign x = h_count_reg;
    assign y = v_count_reg;

endmodule