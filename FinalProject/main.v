`default_nettype none

module main(
	// Board I/Os
	input		MAX10_CLK1_50,
	input 	[9:0]		SW,
	output	[9:0]		LEDR,
	inout		[35:0]	GPIO
);
	
	wire w_Clk;
	
	counter_1s timer(
	.i_clk(MAX10_CLK1_50),
	.i_reset(SW[9]),
	.i_enable(1'b1),
	.o_tick(w_Clk),
	);
	
	wire [8:0] w_instructions1;
	wire w_enable1;
	wire w_enableLetters;
	
	wire [8:0] w_instructions2;
	wire w_enable2;
	
	wire [7:0] w_char;
	wire [8:0] w_instr;
	
	FSM_Hangman hangMan(
	.clk(MAX10_CLK1_50),
	.reset(SW[9]),
	.i_enable(w_Clk),
	.o_instructions(w_instructions1),
	.o_enable(w_enable1),
	.o_enableLetters(w_enableLetters)
	);
	
	inputLetter(
	.clk(MAX10_CLK1_50),
	.i_char(SW[7:0]),
	.i_enable(SW[8]),
	.o_char(w_char)
	);
	
	char2Instr Display(
		.char(w_char),
		.Instr(w_instr)
	);
	
	assign LEDR[8:0] = w_instr;
	
	FSM_LetterDetector(
	.clk(MAX10_CLK1_50),
	.reset(SW[9]),
	.i_enable(w_Clk),
	.i_instructions(w_instr),
	.o_instructions(w_instructions2),
	.o_enable(w_enable2)
	);
	
	LCDDisplay(
	.clk(MAX10_CLK1_50),
	.i_enableLetters(w_enableLetters),
	.i_instructions1(w_instructions1),
	.i_instructions2(w_instructions2),
	.i_enable1(w_enable1),
	.i_enable2(w_enable2),
	.o_instructions(GPIO[34:26]),
	.o_enable(GPIO[35]),
	//.o_led(LEDR[8:0])
	);
	
	/*
	ManualControl(
	.i_instr(SW[8:0]),
	.i_enable(SW[9]),
	.o_instr(GPIO[34:26]),
	.o_enable(GPIO[35])
	);
	*/
	
endmodule

`default_nettype wire
