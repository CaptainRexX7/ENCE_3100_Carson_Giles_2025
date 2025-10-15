
`default_nettype none

module multiplier_8x8(
	input 	[7:0] i_A,
	input 	[7:0] i_B,
	output 	[15:0] o_P,
	output 			o_Overflow
);

	// First Stage of Adders
	wire [7:0] w_A0;
	wire [7:0] w_B0;
	wire [8:0] w_S0;
	
	assign o_P[0] = i_A[0] & i_B[0];
	
	assign w_A0[0] = i_A[1]&i_B[0];
	assign w_B0[0] = i_A[0]&i_B[1];
	
	assign w_A0[1] = i_A[2]&i_B[0];
	assign w_B0[1] = i_A[1]&i_B[1];
	
	assign w_A0[2] = i_A[3]&i_B[0];
	assign w_B0[2] = i_A[2]&i_B[1];
	
	assign w_A0[3] = i_A[4]&i_B[0];
	assign w_B0[3] = i_A[3]&i_B[1];
	
	assign w_A0[4] = i_A[5]&i_B[0];
	assign w_B0[4] = i_A[4]&i_B[1];
	
	assign w_A0[5] = i_A[6]&i_B[0];
	assign w_B0[5] = i_A[5]&i_B[1];
	
	assign w_A0[6] = i_A[7]&i_B[0];
	assign w_B0[6] = i_A[6]&i_B[1];
	
	assign w_A0[7] = 1'b0;
	assign w_B0[7] = i_A[7]&i_B[1];
	
	RippleCarry8bit RCA0(
	.i_A(w_A0),
	.i_B(w_B0),
	.i_C(1'b0),
	.o_C(w_S0[8]),
	.o_S(w_S0[7:0])
	);
	
	assign o_P[1] = w_S0[0];
		
	// Second Stage of Adders	
	wire [7:0] w_B1;
	wire [8:0] w_S1;
	
	assign w_B1[0] = i_A[0]&i_B[2];
	assign w_B1[1] = i_A[1]&i_B[2];
	assign w_B1[2] = i_A[2]&i_B[2];
	assign w_B1[3] = i_A[3]&i_B[2];
	assign w_B1[4] = i_A[4]&i_B[2];
	assign w_B1[5] = i_A[5]&i_B[2];
	assign w_B1[6] = i_A[6]&i_B[2];
	assign w_B1[7] = i_A[7]&i_B[2];
	
	RippleCarry8bit RCA1(
	.i_A(w_S0[8:1]),
	.i_B(w_B1),
	.i_C(1'b0),
	.o_C(w_S1[8]),
	.o_S(w_S1[7:0])
	);
	
	assign o_P[2] = w_S1[0];
	
	// Third Stage of Adders
	wire [7:0] w_B2;
	wire [8:0] w_S2;
	
	assign w_B2[0] = i_A[0]&i_B[3];
	assign w_B2[1] = i_A[1]&i_B[3];
	assign w_B2[2] = i_A[2]&i_B[3];
	assign w_B2[3] = i_A[3]&i_B[3];
	assign w_B2[4] = i_A[4]&i_B[3];
	assign w_B2[5] = i_A[5]&i_B[3];
	assign w_B2[6] = i_A[6]&i_B[3];
	assign w_B2[7] = i_A[7]&i_B[3];
	
	RippleCarry8bit RCA2(
	.i_A(w_S1[8:1]),
	.i_B(w_B2),
	.i_C(1'b0),
	.o_C(w_S2[8]),
	.o_S(w_S2[7:0])
	);
	
	assign o_P[3] = w_S2[0];
	
	// Fourth Stage of Adders
	wire [7:0] w_B3;
	wire [8:0] w_S3;
	
	assign w_B3[0] = i_A[0]&i_B[4];
	assign w_B3[1] = i_A[1]&i_B[4];
	assign w_B3[2] = i_A[2]&i_B[4];
	assign w_B3[3] = i_A[3]&i_B[4];
	assign w_B3[4] = i_A[4]&i_B[4];
	assign w_B3[5] = i_A[5]&i_B[4];
	assign w_B3[6] = i_A[6]&i_B[4];
	assign w_B3[7] = i_A[7]&i_B[4];
	
	RippleCarry8bit RCA3(
	.i_A(w_S2[8:1]),
	.i_B(w_B3),
	.i_C(1'b0),
	.o_C(w_S3[8]),
	.o_S(w_S3[7:0])
	);
	
	assign o_P[4] = w_S3[0];
	
	// 5th Stage of Adders
	wire [7:0] w_B4;
	wire [8:0] w_S4;
	
	assign w_B4[0] = i_A[0]&i_B[5];
	assign w_B4[1] = i_A[1]&i_B[5];
	assign w_B4[2] = i_A[2]&i_B[5];
	assign w_B4[3] = i_A[3]&i_B[5];
	assign w_B4[4] = i_A[4]&i_B[5];
	assign w_B4[5] = i_A[5]&i_B[5];
	assign w_B4[6] = i_A[6]&i_B[5];
	assign w_B4[7] = i_A[7]&i_B[5];
	
	RippleCarry8bit RCA4(
	.i_A(w_S3[8:1]),
	.i_B(w_B4),
	.i_C(1'b0),
	.o_C(w_S4[8]),
	.o_S(w_S4[7:0])
	);
	
	assign o_P[5] = w_S4[0];
		
	// 6th Stage of Adders
		wire [7:0] w_B5;
	wire [8:0] w_S5;
	
	assign w_B5[0] = i_A[0]&i_B[6];
	assign w_B5[1] = i_A[1]&i_B[6];
	assign w_B5[2] = i_A[2]&i_B[6];
	assign w_B5[3] = i_A[3]&i_B[6];
	assign w_B5[4] = i_A[4]&i_B[6];
	assign w_B5[5] = i_A[5]&i_B[6];
	assign w_B5[6] = i_A[6]&i_B[6];
	assign w_B5[7] = i_A[7]&i_B[6];
	
	RippleCarry8bit RCA5(
	.i_A(w_S4[8:1]),
	.i_B(w_B5),
	.i_C(1'b0),
	.o_C(w_S5[8]),
	.o_S(w_S5[7:0])
	);
	
	assign o_P[6] = w_S5[0];
		
	// 7th Stage of Adders	
	wire [7:0] w_B6;
	wire [8:0] w_S6;
	
	assign w_B6[0] = i_A[0]&i_B[7];
	assign w_B6[1] = i_A[1]&i_B[7];
	assign w_B6[2] = i_A[2]&i_B[7];
	assign w_B6[3] = i_A[3]&i_B[7];
	assign w_B6[4] = i_A[4]&i_B[7];
	assign w_B6[5] = i_A[5]&i_B[7];
	assign w_B6[6] = i_A[6]&i_B[7];
	assign w_B6[7] = i_A[7]&i_B[7];
	
	RippleCarry8bit RCA6(
	.i_A(w_S5[8:1]),
	.i_B(w_B6),
	.i_C(1'b0),
	.o_C(o_P[15]),
	.o_S(o_P[14:7])
	);
	
endmodule

`default_nettype wire
