module FSM_LetterDetector(
input clk,
input reset,
input i_enable,
input [8:0] i_instructions,
output reg [8:0] o_instructions,
output reg o_enable
);

	reg [2:0] state, next_state;
	reg [8:0] HangManPosition;
	
	//states
	localparam [3:0] s_Input = 4'b0000, s_DPosition = 4'b0001, s_IPosition1 = 4'b0010, s_ILetter = 4'b0011, s_IPosition2 = 4'b0100, s_GPosition = 4'b0101, s_TPosition = 4'b0110, s_APosition = 4'b0111, s_LPosition = 4'b1000, s_hangman = 4'b1001, s_Letter = 4'b1010, s_GameOver = 4'b1011;
	
	// 1. State Register (sequential)
	always @(posedge clk) begin
		if(reset) begin
			state <= s_Input;
			HangManPosition <= 9'b011000000;
		end
		else begin
			state <= next_state;
		end
	end
	
	//2. Next_State logic (combinational)
	always @(*) begin
	
		next_state = s_Input; //default
		
		case(state)
		
			s_Input: if(i_enable) begin
							if(i_instructions == 9'b101000100) begin
								next_state = s_DPosition;
							end
							else if(i_instructions == 9'b101001001) begin
								next_state = s_DPosition;//s_IPosition1;
							end
							else if(i_instructions == 9'b101000111) begin
								next_state = s_GPosition;
							end
							else if(i_instructions == 9'b101010100) begin
								next_state = s_TPosition;
							end
							else if(i_instructions == 9'b101000001) begin
								next_state = s_APosition;
							end
							else if(i_instructions == 9'b101001100) begin
								next_state = s_LPosition;
							end
							else if(i_instructions == 9'd0) begin
								next_state = s_Input;
							end
							else if(HangManPosition == 9'b011000110) begin
								next_state = s_GameOver;
							end
							else begin
								next_state = s_hangman;
							end
						end
						else begin
								next_state = s_Input;
						end
			
			s_DPosition: next_state = ~i_enable ? s_Letter : s_DPosition;
			
			s_IPosition1: next_state = ~i_enable ? s_ILetter : s_IPosition1;
			s_ILetter: next_state = i_enable ? s_IPosition2 : s_ILetter;
			s_IPosition2: next_state = ~i_enable ? s_Letter : s_IPosition2;
			
			s_GPosition: next_state = ~i_enable ? s_Letter : s_GPosition;
			
			s_TPosition: next_state = ~i_enable ? s_Letter : s_TPosition;
			
			s_APosition: next_state = ~i_enable ? s_Letter : s_APosition;
			
			s_LPosition: next_state = ~i_enable ? s_Letter : s_LPosition;
			
			s_Letter: next_state = i_enable ? s_Input : s_Letter;
			
			s_hangman: next_state = ~i_enable ? s_Letter : s_hangman;
			
			s_GameOver: next_state = s_GameOver;
			
		endcase
	end
			
	// 3. Output Logic (combinational)
	always @(posedge clk) begin
		if(state == s_DPosition) begin
			o_instructions <= 9'b0010001000;
		end
		
		else if(state == s_IPosition1) begin
			o_instructions <= 9'b0010001001;
		end
		
		else if(state == s_ILetter) begin
			o_instructions <= 9'b101001001;
		end
		
		else if(state == s_IPosition2) begin
			o_instructions <=  9'b0010001010;
		end
		
		else if(state == s_GPosition) begin
			o_instructions <= 9'b0010001011;
		end
		
		else if(state == s_TPosition) begin
			o_instructions <= 9'b0010001100;
		end
		
		else if(state == s_APosition) begin
			o_instructions <= 9'b0010001101;
		end
		
		else if(state == s_LPosition) begin
			o_instructions <= 9'b0010001110;
		end
		else if(state == s_hangman) begin
			o_instructions <= HangManPosition;
			HangManPosition <= HangManPosition + 1;
		end
		else if(state == s_Letter) begin
			o_instructions <= i_instructions;
		end
		else begin
			o_instructions <=  9'd0;
		end
		
	end
	
	always @(*) begin
		if(state != next_state)
			o_enable <= 1'b1;
		else
			o_enable <= 1'b0;
	end
	
endmodule