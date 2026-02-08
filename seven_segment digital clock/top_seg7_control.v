`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Joshua
// 
// Create Date: 02/08/2026 11:09:38 AM
// Design Name: 
// Module Name: top_seg7_control
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


module top_seg7_control(
    input clk_100Mhz,
    input reset,
    input inc_hrs,
    input inc_mins,
    output blink,
    output [0:6] seg,
    output [3:0] an
    );
    
    wire [3:0] v_hours;
    wire [5:0] v_minutes, hours_pad;
    wire [2:0] hrs_tens, mins_tens;
    wire [3:0] hrs_ones, mins_ones;
    
    top_bin_clk bin(.clk_100Mhz(clk_100Mhz), .reset(reset), .inc_hrs(inc_hrs), .inc_mins(inc_mins),
                      .sig_1Hz(blink), .hours(v_hours), .minutes(v_minutes));
    
    // seven seg display
    bin2bcd hrs(.b_in(hours_pad), .tens(hrs_tens), .ones(hrs_ones));
    bin2bcd mins(.b_in(v_minutes), .tens(mins_tens), .ones(mins_ones));
    
    seg7_control seg7(.clk_100Mhz(clk_100Mhz), .reset(reset), .hrs_tens(hrs_tens), .mins_tens(mins_tens), .hrs_ones(hrs_ones), .mins_ones(mins_ones), .seg(seg), .an(an));
    
    assign hours_pad = {2'b00, v_hours};  
    
endmodule
