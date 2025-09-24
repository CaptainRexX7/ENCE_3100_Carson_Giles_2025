module main (SW,HEX0,HEX1);

input [8:0] SW; // toggle switches
output [7:0] HEX0; // seven segment display 1
output [7:0] HEX1; // seven segment display 1*/

assign C0 = SW[0]&SW[8] | SW[4]&SW[8] | SW[0]&SW[4];
assign S0 = ~SW[0]&~SW[4]&SW[8] | ~SW[0]&SW[4]&~SW[8] | SW[0]&~SW[4]&~SW[8] | SW[0]&SW[4]&SW[8];
assign C1 = SW[1]&C0 | SW[5]&C0 | SW[1]&SW[5];
assign S1 = ~SW[1]&~SW[5]&C0 | ~SW[1]&SW[5]&~C0 | SW[1]&~SW[5]&~C0 | SW[1]&SW[5]&C0;
assign C2 = SW[2]&C1 | SW[6]&C1 | SW[2]&SW[6];
assign S2 = ~SW[2]&~SW[6]&C1 | ~SW[2]&SW[6]&~C1 | SW[2]&~SW[6]&~C1 | SW[2]&SW[6]&C1;
assign Cout = SW[3]&C2 | SW[7]&C2 | SW[3]&SW[7];
assign S3 = ~SW[3]&~SW[7]&C2 | ~SW[3]&SW[7]&~C2 | SW[3]&~SW[7]&~C2 | SW[3]&SW[7]&C2;
assign S4 = Cout;

assign i_m0 = S0;
assign i_m1 = S4&~S1 | ~S4&~S3&S1 | S3&S2&~S1;
assign i_m2 = S4&~S1 | ~S3&S2 | S2&S1;
assign i_m3 = S4&S1 | S3&~S2&~S1;
assign i_m4 = S4 | S3&S1 | S3&S2;

assign HEX0[0] = ~(~i_m2&~i_m0 | i_m1 | i_m2&i_m0 | i_m3);
assign HEX0[1] = ~(~i_m2 | ~i_m1&~i_m0 | i_m1&i_m0);
assign HEX0[2] = ~(~i_m1 | i_m0 | i_m2);
assign HEX0[3] = ~(~i_m2&~i_m0 | ~i_m2&i_m1 | i_m2&~i_m1&i_m0 | i_m1&~i_m0 | i_m3);
assign HEX0[4] = ~(~i_m2&~i_m0 | i_m1&~i_m0);
assign HEX0[5] = ~(~i_m1&~i_m0 | i_m2&~i_m1 | i_m2&~i_m0 | i_m3);
assign HEX0[6] = ~(~i_m2&i_m1 | i_m2&~i_m1 | i_m3 | i_m1&~i_m0);
assign HEX0[7] = 1;

assign HEX1[0] = i_m4;
assign HEX1[1] = 0;
assign HEX1[2] = 0;
assign HEX1[3] = i_m4;
assign HEX1[4] = i_m4;
assign HEX1[5] = i_m4;
assign HEX1[6] = 1;
assign HEX1[7] = 1;

endmodule