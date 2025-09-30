module main (SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	wire [1:0] Q;
	
	DLatch_0 dlatch0 (SW[0],~SW[2], Q);
	DLatch_0 dlatch1 (Q[0],SW[2], LEDR[1:0]);
	
	assign LEDR[3] = SW[2];

endmodule
