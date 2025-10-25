`default_nettype none

module FSM_WordDetector(
	input clk,
	input reset,
	input [7:0] RXD_data,
	input [7:0] char2seg,
	input i_busy,
	input counter_done,
	output counter_start,
	output [7:0] HEX0,
	output [7:0] HEX1,
	output [7:0] HEX2,
	output [7:0] HEX3,
	output [7:0] HEX4
	//output [2:0] o_state
);

	reg [2:0] state, next_state;
	reg [1:0] LCounter;
	
	//states
	localparam [2:0] s_H = 3'b000, s_E = 3'b001, s_L = 3'b010, s_O = 3'b011, s_Hello = 3'b100;
	
	// 1. State Register (sequential)
	always @(posedge clk) begin
		if(reset)
			state <= s_H;
		else
			state <= next_state;
	end
	
	//2. Next_State logic (combinational)
	always @(*) begin
	
		next_state = s_H; //default
		
		case(state)
			
			s_H: next_state = (RXD_data == 8'h68) ? s_E : s_H;
			s_E:  if(RXD_data == 8'h65) begin
						next_state = s_L;
					end
					else if(RXD_data == 8'h68) begin
						next_state = s_E;
					end
					else begin
						next_state = s_H;
					end
			s_L:  if(LCounter == 2'b10)
						next_state = s_O;
					else if(RXD_data == 8'h65 | RXD_data == 8'h6C) begin
						next_state = s_L;
					end
					else begin
						next_state = s_H;
					end
			s_O:  if(RXD_data == 8'h6F) begin
						next_state = s_Hello;
					end
					else if(RXD_data == 8'h6C) begin
						next_state = s_O;
					end
					else begin
						next_state = s_H;
					end
			s_Hello: next_state = s_Hello;
			
		endcase
	end
	
	// 3. Output Logic (combinational)
	
	assign HEX0 = (state == s_Hello) ? 8'b10100011: char2seg;
	assign HEX1 = (state == s_Hello) ? 8'b11000111: 8'hFF;
	assign HEX2 = (state == s_Hello) ? 8'b11000111: 8'hFF;
	assign HEX3 = (state == s_Hello) ? 8'b10000110: 8'hFF;
	assign HEX4 = (state == s_Hello) ? 8'b10001001: 8'hFF;
	
	always @(posedge i_busy) begin
		if(~(state == s_L))
			LCounter <= 2'd0;
		else if(RXD_data == 8'h6C)
			LCounter <= LCounter + 1;
	end
	
	//assign o_state = state;
		
endmodule

`default_nettype wire