module FSM_ChessTimer(
	input clk,
	input reset,
	input [1:0] buttons,
	input [9:0] counter_1,
	input [9:0] counter_2,
	output     [1:0] load_counters,
	output     [1:0] en_counters,
	output reg [1:0] state_displays,
	output     [1:0] o_state
);

	reg [1:0] state, next_state;

	// States
	localparam [1:0] s_idle = 2'b00, s_player1 = 2'b01, s_player2 = 2'b10, s_win = 2'b11;

	// 1. State Register (sequential)
	always @(posedge clk) begin
		if(reset)
			state <= s_idle;
		else
			state <= next_state;
	end
	
	// 2. Next-State Logic (combinational)
	always @(*) begin
	
		next_state = s_idle; //default
		
		case(state)
		
			s_idle:  if(buttons[1]) begin
							next_state = s_player1;
						end
						else if(buttons[0]) begin
							next_state = s_player2;
						end
						else begin
							next_state = s_idle;
						end
			  
			s_player1:  if(buttons[0]) begin
								next_state = s_player2;
							end
							else if(counter_1 == 10'd0) begin
								next_state = s_win;
							end
							else begin
								next_state = s_player1;
							end
	
			s_player2: if(buttons[1]) begin
								next_state = s_player1;
							end
							else if(counter_2 == 10'd0) begin
								next_state = s_win;
							end
							else begin
								next_state = s_player2;
							end
			s_win: next_state = s_win;
	
		endcase
	end
	
	// 3. Output Logic (combinational)
	assign en_counters[0] = (state == s_player1);
	assign en_counters[1] = (state == s_player2);
	assign load_counters[0] = (state == s_idle | state == s_player2);
	assign load_counters[1] = (state == s_idle | state == s_player1);
	
	always@(posedge clk) begin
		if(state == s_idle) begin
			state_displays <= 2'b00;
		end
		else if(state == s_win) begin
			state_displays <= 2'b10;
		end
		else begin
			state_displays <= 2'b01;
		end
	end
	
	assign o_state = state;

endmodule
