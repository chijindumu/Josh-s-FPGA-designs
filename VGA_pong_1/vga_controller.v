`timescale 1ns/1ps
module vga_controller(
    input clk_100Mhz,
    input reset,
    output hsync,
    output vsync,
    output video_on,
    output p_tick, // pixel tick
    output [9:0] x, y // pixel count/position for x and y, for x = 799 pixels per line, y = 524 lines per frame
);

    // from vesa standards
    // total horizontal width X of screens = 800 pixels per line
    // partitioning into sections we have
    parameter HD = 640;                     // display area width
    parameter HF = 48;                      // front porch
    parameter HB = 16;                      // back porch
    parameter HR = 96;                      // retrace width
    parameter HMAX = HD + HF + HB + HR - 1; // MAXIMUM VALUE = 799

    // total vertical width Y of screens = 525 lines per frame
    //partitioning them we have
    parameter VD = 480;                     // display area length
    parameter VF = 10;                      // front porch
    parameter VB = 33;                      // back porch
    parameter VR = 2;                       // retrace length
    parameter VMAX = VD + VF + VB + VR - 1; // MAXIMUM VALUE = 524

    // clock divider
    reg [1:0] r_clk25Mhz;
    wire clk_25Mhz;
    always @(posedge clk_100Mhz, posedge reset) begin
        if (reset) begin
            r_clk25Mhz <= 0;
        end else begin
            r_clk25Mhz <= r_clk25Mhz + 1;
        end
    end

    assign clk_25Mhz = (r_clk25Mhz == 0) ? 1'b1 : 1'b0; // since 2 bits can count up to 4, then we count 1 after 4 cycles (1/4 clk)

    // counter registers
    reg [9:0] v_count_reg, v_count_next;
    reg [9:0] h_count_reg, h_count_next;

    // output buffers

    reg v_sync_reg, h_sync_reg;
    wire v_sync_next, h_sync_next;

    //register control
    always @(posedge clk_100Mhz, posedge reset) begin
        if(reset)begin
            v_sync_reg <= 0;
            h_sync_reg <= 0;
            v_count_reg <= 0;
            h_count_reg <= 0;
        end else begin
            v_sync_reg <= v_sync_next;
            h_sync_reg <= h_sync_next;
            v_count_reg <= v_count_next;
            h_count_reg <= h_count_next;
        end
    end

    // horizontal controller
    always @(posedge clk_25Mhz, posedge reset) begin
        if(reset)begin
            h_count_next = 0;
        end else begin
            if (h_count_next == HMAX) begin
                h_count_next = 0;
            end else begin
                h_count_next = h_count_reg + 1;
            end
        end
    end

    // vertical controller
    always @(posedge clk_25Mhz, posedge reset) begin
        if(reset)begin
            v_count_next = 0;
        end else begin
            if(h_count_next == HMAX) begin          // checks if the h_count has reached max, so it can count v_count up! (begin a new line)
                if (v_count_next == VMAX) begin
                    v_count_next = 0;
                end else begin
                    v_count_next = v_count_reg + 1;
                end
            end
        end
    end

    assign h_sync_next = (h_count_reg >= (HD + HF + HB)) && (h_count_reg <= (HD + HF + HB + HR - 1 ));

    assign v_sync_next = (v_count_reg >= (VD + VF + VB)) && (v_count_reg <= (VD + VF + VB + VR - 1));

    assign video_on = (v_count_reg < VD) && (h_count_reg < HD);

    // outputs 

    assign vsync = v_sync_reg;
    assign hsync = h_sync_reg;
    assign x = h_count_reg;
    assign y = v_count_reg;
    assign p_tick = clk_25Mhz; // pixel tick

endmodule