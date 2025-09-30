module PositiveEdge (
	input D,
	input clk,
	output [1:0] O_Q
	);
	
	wire [1:0] Q;
	
	DLatch_0 dlatch0 (D, ~clk, Q);
	DLatch_0 dlatch1 (Q[0], clk, O_Q);

endmodule
