`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Joshua
// 
// Create Date: 02/08/2026 11:30:08 AM
// Design Name: 
// Module Name: top_bin_clk
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


module top_bin_clk(
    input clk_100Mhz,
    input reset,
    input inc_mins,
    input inc_hrs,
    output [3:0] hours,
    output sig_1Hz,
    output [5:0] minutes
    );
    
    wire w_1Hz;                                 // 1Hz signal
    wire inc_hrs_db, reset_db, inc_mins_db;     // debounced button signals
    wire w_inc_mins, w_inc_hrs;                 // mod to mod
    wire inc_mins_or, inc_hrs_or;               // from OR gates
    
    one_hz uno(.clk_100Mhz(clk_100Mhz), .clk_1hz(w_1Hz)); // w_1hz is the output which is the one hz clk
    
    btn_debouncer bL(.clk_100Mhz(clk_100Mhz), .btn_in(inc_hrs), .btn_out(inc_hrs_db));
    btn_debouncer bC(.clk_100Mhz(clk_100Mhz), .btn_in(reset), .btn_out(reset_db));
    btn_debouncer bR(.clk_100Mhz(clk_100Mhz), .btn_in(inc_mins), .btn_out(inc_mins_db));
    
    seconds sec(.clk_1Hz(w_1Hz), .reset(reset_db), .inc_mins(w_inc_mins));
    minutes min(.inc_mins(inc_mins_or), .reset(reset_db), .inc_hours(w_inc_hrs), .minutes(minutes));
    hours hr(.inc_hours(inc_hrs_or), .reset(reset_db), .hours(hours));
    
    assign inc_hrs_or = w_inc_hrs | inc_hrs_db; // allows us to increment manually or automatically
    assign inc_mins_or = w_inc_mins | inc_mins_db;  // allows us to increment manually or automatically
    assign sig_1Hz = w_1Hz;
    
endmodule
