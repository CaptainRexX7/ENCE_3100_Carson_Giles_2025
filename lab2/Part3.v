// Simple module that connects the SW switches to the LEDR lights
module main (SW, LEDR);
input [8:0] SW; // toggle switches
output [9:0] LEDR; // leds

assign C0 = SW[0]&SW[8] | SW[4]&SW[8] | SW[0]&SW[4];
assign S0 = ~SW[0]&~SW[4]&SW[8] | ~SW[0]&SW[4]&~SW[8] | SW[0]&~SW[4]&~SW[8] | SW[0]&SW[4]&SW[8];
assign C1 = SW[1]&C0 | SW[5]&C0 | SW[1]&SW[5];
assign S1 = ~SW[1]&~SW[5]&C0 | ~SW[1]&SW[5]&~C0 | SW[1]&~SW[5]&~C0 | SW[1]&SW[5]&C0;
assign C2 = SW[2]&C1 | SW[6]&C1 | SW[2]&SW[6];
assign S2 = ~SW[2]&~SW[6]&C1 | ~SW[2]&SW[6]&~C1 | SW[2]&~SW[6]&~C1 | SW[2]&SW[6]&C1;
assign Cout = SW[3]&C2 | SW[7]&C2 | SW[3]&SW[7];
assign S3 = ~SW[3]&~SW[7]&C2 | ~SW[3]&SW[7]&~C2 | SW[3]&~SW[7]&~C2 | SW[3]&SW[7]&C2;

assign LEDR[0] = S0;
assign LEDR[1] = S1;
assign LEDR[2] = S2;
assign LEDR[3] = S3;
assign LEDR[4] = Cout;

endmodule