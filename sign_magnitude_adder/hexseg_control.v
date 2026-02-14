`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: JOSHUA
// 
// Create Date: 02/14/2026 11:18:47 AM
// Design Name: control for seven segment 
// Module Name: hexseg_control
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


module hexseg_control(
    input wire clk, reset, 
    input wire [7:0] mag,
    input wire sign,
    output reg [0:6] segs,
    output reg [3:0] an

);

wire [3:0] hundred, tens, unit;
reg [16:0] an_counter; 
reg [1:0] an_state;
wire [1:0] an_nextstate;

hundreds magnitude(.mag(mag), .hundred(hundred), .tens(tens), .unit(unit));
 // count the anode 
always @(posedge clk, posedge reset) begin
    if(reset) begin
        an_state <= 0;
        an_counter <= 0;
    end else begin 
        if(an_counter == 99_999) begin
            an_counter <= 0;
            an_state <= an_nextstate;
        end else begin
            an_counter <=  an_counter + 1;
        end
    end
end

assign an_nextstate = an_state + 1;

always @* begin
    case (an_state)
        2'b00: 
            begin
                an = 4'b0111;
                if (sign) begin
                    segs <= 7'b1111110;
                end else begin
                    segs <= 7'b1111111;
                end
            end
        2'b01: 
            begin
                an = 4'b1011;
                case(hundred)
                    4'h0: segs =  7'b0000001;
                    4'h1: segs =  7'b1001111;
                    4'h2: segs =  7'b0010010;
                    4'h3: segs =  7'b0000110;
                    4'h4: segs =  7'b1001100;
                    4'h5: segs =  7'b0100100;
                    4'h6: segs =  7'b0100000;
                    4'h7: segs =  7'b0001111;
                    4'h8: segs =  7'b0000000;
                    4'h9: segs =  7'b0000100;
                endcase
            end
        2'b10: 
            begin
                an = 4'b1101;
                case(tens)
                    4'h0: segs =  7'b0000001;
                    4'h1: segs =  7'b1001111;
                    4'h2: segs =  7'b0010010;
                    4'h3: segs =  7'b0000110;
                    4'h4: segs =  7'b1001100;
                    4'h5: segs =  7'b0100100;
                    4'h6: segs =  7'b0100000;
                    4'h7: segs =  7'b0001111;
                    4'h8: segs =  7'b0000000;
                    4'h9: segs =  7'b0000100;
                endcase
            end
        2'b11: 
            begin
                an = 4'b1110;
                case(unit)
                    4'h0: segs =  7'b0000001;
                    4'h1: segs =  7'b1001111;
                    4'h2: segs =  7'b0010010;
                    4'h3: segs =  7'b0000110;
                    4'h4: segs =  7'b1001100;
                    4'h5: segs =  7'b0100100;
                    4'h6: segs =  7'b0100000;
                    4'h7: segs =  7'b0001111;
                    4'h8: segs =  7'b0000000;
                    4'h9: segs =  7'b0000100;
                endcase
            end
    endcase
end


endmodule