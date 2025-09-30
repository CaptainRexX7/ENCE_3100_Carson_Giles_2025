module main (SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	assign D = SW[0];
	assign clk = SW[2];
	
	DLatch_0 dlatch (D, clk, LEDR[1:0]);
	PositiveEdge positive (D, clk, LEDR[3:2]);
	NegativeEdge Negative (D, clk, LEDR[5:4]);
	
	assign LEDR[7] = clk;

endmodule
