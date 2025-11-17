module inputLetter(
	input clk,
	input [7:0] i_char,
	input i_enable,
	output reg [7:0] o_char
);

	always @(posedge clk) begin
		if(i_enable) begin
			o_char <= i_char;
		end
		else begin
			 o_char <= 8'd0;
		end
	end

endmodule