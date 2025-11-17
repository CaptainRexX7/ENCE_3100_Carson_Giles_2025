module LCDDisplay(
	input clk,
	input i_enableLetters,
	input [8:0] i_instructions1,
	input [8:0] i_instructions2,
	input i_enable1,
	input i_enable2,
	output reg [8:0] o_instructions,
	output reg o_enable,
	output reg [8:0] o_led
);

	always @(posedge clk) begin
		if(i_enableLetters) begin
			o_instructions <= i_instructions2;
			o_led <= i_instructions2;
			o_enable <= i_enable2;
		end
		else begin
			o_instructions <= i_instructions1;
			o_led <= i_instructions1;
			o_enable <= i_enable1;
		end
	end

endmodule