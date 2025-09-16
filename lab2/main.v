// Simple module that connects the SW switches to the LEDR lights
module main (SW, HEX0,HEX1);
input [7:0] SW; // toggle switches
output [7:0] HEX0; // seven segment display 1
output [7:0] HEX1; // seven segment display 1

assign i_m0 = SW[0];
assign i_m1 = SW[1];
assign i_m2 = SW[2];
assign i_m3 = SW[3];

assign i_m4 = SW[4];
assign i_m5 = SW[5];
assign i_m6 = SW[6];
assign i_m7 = SW[7];

assign HEX0[0] = ~(~i_m2&~i_m0 | i_m1 | i_m2&i_m0 | i_m3);
assign HEX0[1] = ~(~i_m2 | ~i_m1&~i_m0 | i_m1&i_m0);
assign HEX0[2] = ~(~i_m1 | i_m0 | i_m2);
assign HEX0[3] = ~(~i_m2&~i_m0 | ~i_m2&i_m1 | i_m2&~i_m1&i_m0 | i_m1&~i_m0 | i_m3);
assign HEX0[4] = ~(~i_m2&~i_m0 | i_m1&~i_m0);
assign HEX0[5] = ~(~i_m1&~i_m0 | i_m2&~i_m1 | i_m2&~i_m0 | i_m3);
assign HEX0[6] = ~(~i_m2&i_m1 | i_m2&~i_m1 | i_m3 | i_m1&~i_m0);
assign HEX0[7] = 1;

assign HEX1[0] = ~(~i_m6&~i_m4 | i_m5 | i_m6&i_m4 | i_m7);
assign HEX1[1] = ~(~i_m6 | ~i_m5&~i_m4 | i_m5&i_m4);
assign HEX1[2] = ~(~i_m5 | i_m4 | i_m6);
assign HEX1[3] = ~(~i_m6&~i_m4 | ~i_m6&i_m5 | i_m6&~i_m5&i_m4 | i_m5&~i_m4 | i_m7);
assign HEX1[4] = ~(~i_m6&~i_m4 | i_m5&~i_m4);
assign HEX1[5] = ~(~i_m5&~i_m4 | i_m6&~i_m5 | i_m6&~i_m4 | i_m7);
assign HEX1[6] = ~(~i_m6&i_m5 | i_m6&~i_m5 | i_m7 | i_m5&~i_m4);
assign HEX1[7] = 1;
endmodule