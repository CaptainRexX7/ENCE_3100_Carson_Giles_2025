
`default_nettype none

module multiplier_4x4(
	input 	[3:0] i_A,
	input 	[3:0] i_B,
	output 	[7:0] o_P,
	output 			o_Overflow
);
	
	assign o_P[0] = i_A[0] & i_B[0];

	// First Stage of Adders
	
	wire [3:0] w_A0;
	wire [3:0] w_B0;
	wire [4:0] w_S0;
	
	assign w_A0[0] = i_A[1]&i_B[0];
	assign w_B0[0] = i_A[0]&i_B[1];
	
	assign w_A0[1] = i_A[2]&i_B[0];
	assign w_B0[1] = i_A[1]&i_B[1];
	
	assign w_A0[2] = i_A[3]&i_B[0];
	assign w_B0[2] = i_A[2]&i_B[1];
	
	assign w_A0[3] = 1'b0;
	assign w_B0[3] = i_A[3]&i_B[1];
	
	RippleCarryAdder(
	.i_A(w_A0),
	.i_B(w_B0),
	.i_C(1'b0),
	.o_C(w_S0[4]),
	.o_S(w_S0[3:0])
	);
	
	assign o_P[1] = w_S0[0];
		
	// Second Stage of Adders
	wire [3:0] w_B1;
	wire [4:0] w_S1;
	
	assign w_B1[0] = i_A[0]&i_B[2];
	assign w_B1[1] = i_A[1]&i_B[2];
	assign w_B1[2] = i_A[2]&i_B[2];
	assign w_B1[3] = i_A[3]&i_B[2];
	
	RippleCarryAdder(
	.i_A(w_S0[4:1]),
	.i_B(w_B1),
	.i_C(1'b0),
	.o_C(w_S1[4]),
	.o_S(w_S1[3:0])
	);
	
	assign o_P[2] = w_S1[0];
	
	// Third Stage of Adders
	wire [3:0] w_B2;
	
	assign w_B2[0] = i_A[0]&i_B[3];
	assign w_B2[1] = i_A[1]&i_B[3];
	assign w_B2[2] = i_A[2]&i_B[3];
	assign w_B2[3] = i_A[3]&i_B[3];
	
	RippleCarryAdder(
	.i_A(w_S1[4:1]),
	.i_B(w_B2),
	.i_C(1'b0),
	.o_C(o_P[7]),
	.o_S(o_P[6:3])
	);

endmodule

`default_nettype wire
