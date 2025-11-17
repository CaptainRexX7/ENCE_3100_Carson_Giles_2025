module char2Instr(
	input 		[7:0] char,
	output reg	[8:0] Instr
);

	wire [7:0] w_char;

	assign w_char = ((char >= 8'd65) && (char <= 8'd90)) ? (char + 8'd32 ) : char;

	always @(*) begin
	
		Instr = 9'd0;
		
		// ASCII Table Mapping
		case(w_char)
			8'd0: Instr = 9'b000000000;
			8'd97: Instr = 9'b101000001;  // a
			8'd98: Instr = 9'b101000010;  // b
			8'd99: Instr = 9'b101000011;  // c
			8'd100: Instr = 9'b10100100;  // d
			8'd101: Instr = 9'b101000101; // E
			8'd102: Instr = 9'b101000110; // F
			8'd103: Instr = 9'b101000111; // G
			8'd104: Instr = 9'b101001000; // H
			8'd105: Instr = 9'b101001001; // I
			8'd106: Instr = 9'b101001010; // J
			8'd107: Instr = 9'b101001011; // k
			8'd108: Instr = 9'b101001100; // L
			8'd109: Instr = 9'b101001101; // M
			8'd110: Instr = 9'b101001110; // n
			8'd111: Instr = 9'b101001111; // o
			8'd112: Instr = 9'b101010000; // p
			8'd113: Instr = 9'b101010001; // q
			8'd114: Instr = 9'b101010010; // r
			8'd115: Instr = 9'b101010011; // s
			8'd116: Instr = 9'b101010100; // t
			8'd117: Instr = 9'b101010101; // u
			8'd118: Instr = 9'b101010110; // v
			8'd119: Instr = 9'b101010111; // w
			8'd120: Instr = 9'b101011000; // x
			8'd121: Instr = 9'b101011001; // y
			8'd122: Instr = 9'b101011010; // z
		endcase
	end

endmodule
