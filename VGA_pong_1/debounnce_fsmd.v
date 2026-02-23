`timescale 1ns/1ps
module debounce(
    input clk, reset,
    input wire btn,
    output reg db_level
); 

    // states 

    localparam [1:0] 
                zero = 2'b00,
                wait0 = 2'b01,
                one = 2'b10,
                wait1 = 2'b11;

    // instantiate registers
    localparam N=21; // we want a 21 bit register to hold 
    reg [N-1:0] q_reg, q_next;
    reg [1:0] state_reg, state_next;


    // state registers
    always@(posedge clk, posedge reset) begin
        if(reset)begin
            q_reg <= 0;
            state_reg <= 0;
        end else begin
            q_reg <= q_next;
            state_reg <= state_next;
        end
    end

    // nextstate logic and fsmd control path

    always @* begin
        // default values 
        state_next = state_reg;
        q_next = q_reg;
        //db_tick = 1'b0;
        case (state_reg)
            zero : begin
                db_level = 1'b0;
                if(btn)begin
                    q_next = 1;
                    state_next = wait1;
                end
            end
            wait1 : begin
                db_level = 1'b0;
                if(btn)begin
                    q_next = q_reg - 1;
                    if (q_next == 0) begin
                        //db_ticks = 1;
                        state_next = one;
                    end
                end else begin
                    state_next = zero;
                end
            end
            one : begin
                db_level = 1'b1;
                if(!btn)begin
                    q_next = 1;
                    state_next = wait0;
                end
            end
            wait0 : begin
                if(!btn)begin
                    q_next =  q_reg - 1;
                    if(q_next == 0) begin
                        state_next = zero;
                    end
                end else begin
                    state_next = zero;
                end
            end
            default: state_next = zero;
        endcase
    end


endmodule