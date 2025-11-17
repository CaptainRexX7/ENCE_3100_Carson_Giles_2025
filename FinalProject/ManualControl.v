module ManualControl(
	input [8:0] i_instr,
	input i_enable,
	output [8:0] o_instr,
	output o_enable
);

assign o_instr = i_instr;
assign o_enable = i_enable;


endmodule