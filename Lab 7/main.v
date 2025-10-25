
`default_nettype none

module main(
	// Board I/Os
	input		MAX10_CLK1_50,
	input 	[9:0]		SW,
	output	[9:0]		LEDR,
	inout		[35:0]	GPIO,
	output 	[7:0]		HEX0,
	output 	[7:0]		HEX1,
	output 	[7:0]		HEX2,
	output 	[7:0]		HEX3,
	output 	[7:0]		HEX4
	//inout		[15:0]	ARDUINO_IO
);

	
	wire w_clk = MAX10_CLK1_50;

	
	wire RxD_data_ready;
	wire [7:0] RxD_data;
	reg [7:0] GPout;

	async_receiver RX(
		.clk(w_clk), 
		.RxD(GPIO[35]), 
		.RxD_data_ready(RxD_data_ready), 
		.RxD_data(RxD_data)
	);
	
	always @(posedge w_clk) 
		if(RxD_data_ready) 
			GPout <= RxD_data;
			
	wire w_busy;

	async_transmitter TX(
		.clk(w_clk), 
		.TxD(GPIO[33]), 
		.TxD_start(RxD_data_ready), 
		.TxD_data(RxD_data),
		.TxD_busy(w_busy)
	);
	
	assign LEDR[7:0] = GPout;
	
	wire [7:0] w_char2seg;
	
	char2seg Display(
		.char(GPout),
		.HEX0(w_char2seg)
	);
	
	FSM_WordDetector wordDetector(
	.clk(w_clk),
	.reset(SW[9]),
	.RXD_data(GPout),
	.char2seg(w_char2seg),
	.i_busy(w_busy),
	.counter_done(SW[0]),
	.counter_start(),
	.HEX0(HEX0),
	.HEX1(HEX1),
	.HEX2(HEX2),
	.HEX3(HEX3),
	.HEX4(HEX4)
	//.o_state(LEDR[9:7])
	);
	
endmodule

`default_nettype wire
