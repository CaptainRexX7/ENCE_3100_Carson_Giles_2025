// A gated RS latch
module main (SW, LEDR);
	input [2:0] SW;
	output [9:0] LEDR;

	assign R = SW[0];
	assign S = SW[1];
	assign clk = SW[2];

	wire R_g, S_g, Qa, Qb /* synthesis keep */ ;
	/*and (R_g, R, clk);
	and (S_g, S, clk);
	nor (Qa, R_g, Qb);
	nor (Qb, S_g, Qa);*/
	assign R_g = R & clk;
	assign S_g = S &  clk;
	assign Qa = ~(R_g | Qb);
	assign Qb = ~(S_g | Qa);
	assign LEDR[0] = Qa;
	assign LEDR[1] = Qb;
	assign LEDR[3] = clk;
endmodule

