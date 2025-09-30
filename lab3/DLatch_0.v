module DLatch_0 (
input D,
input clk,
output [1:0] Q
);

	wire R_g, S_g, Qa, Qb /* synthesis keep */ ;
	nand (R_g, ~D, clk);
	nand (S_g, D, clk);
	nand (Qa, R_g, Qb);
	nand (Qb, S_g, Qa);
	assign Q[0] = Qa;
	assign Q[1] = Qb;
endmodule