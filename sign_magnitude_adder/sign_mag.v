`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: JOSHUA
// 
// Create Date: 02/14/2026 09:57:04 AM
// Design Name: sign magnitude module
// Module Name: sign_mag
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


module sign_mag #(parameter WIDTH = 8)(
    input wire [WIDTH-1:0] a, b,
    output reg [WIDTH-1:0] sum
);
    // the variables for holding sign and magnitude
    reg [WIDTH-2:0] mag_a, mag_b, max, min, mag_sum;
    reg sign_a, sign_b, sign_sum;

    

    always @* begin
        mag_a = a[WIDTH-2:0];
        mag_b = b[WIDTH-2:0];
        sign_a = a[WIDTH-1];
        sign_b = b[WIDTH-1];
        // compare magnitudes
        if(mag_a > mag_b)begin
            max = mag_a;
            min = mag_b;
            sign_sum = sign_a;
        end else begin
            max = mag_b;
            min = mag_a;
            sign_sum = sign_b;
        end
        // perform the adder or subtractor
        if(sign_a == sign_b)begin
            mag_sum = max + min;
            sum = {sign_sum, mag_sum};
        end else begin
            mag_sum = max - min;
            sum = {sign_sum, mag_sum};
        end
    end


endmodule