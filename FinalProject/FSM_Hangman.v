module FSM_Hangman(
	input clk,
	input reset,
	input i_enable,
	output reg [8:0] o_instructions,
	output reg o_enable,
	output o_enableLetters
);

	reg [1:0] state, next_state;
	
	//states
	localparam [1:0] S_TurnOn = 2'b00, S_SetUp = 2'b01, S_clear = 2'b10, S_HangMan = 2'b11;
	
	// 1. State Register (sequential)
	always @(posedge clk) begin
		if(reset)
			state <= S_TurnOn;
		else
			state <= next_state;
	end
	
	//2. Next_State logic (combinational)
	always @(*) begin
	
		next_state = S_TurnOn; //default
		
		case(state)
			S_TurnOn: next_state =  i_enable ? S_SetUp : S_TurnOn;
			S_SetUp: next_state = ~i_enable ? S_clear : S_SetUp;
			S_clear: next_state = i_enable ? S_HangMan : S_clear;
			S_HangMan: next_state = S_HangMan;
		endcase
	end
	
	// 3. Output Logic (combinational)
	
	assign o_enableLetters = (state == S_HangMan) ? 1'b1 : 1'b0;
	
	always @(posedge clk) begin
		if(state == S_TurnOn) begin
				o_instructions <=  9'b000001101;
				
		end
		
		else if(state == S_SetUp) begin
			o_instructions <= 9'b000111000;
		end
		
		else if(state == S_clear) begin
			o_instructions <=  9'b000000001;
		end
		
		else begin
			o_instructions <= 9'd0;
		end		
	end
	
	always @(*) begin
		if(state != next_state)
			o_enable <= 1'b1;
		else
			o_enable <= 1'b0;
	end

endmodule