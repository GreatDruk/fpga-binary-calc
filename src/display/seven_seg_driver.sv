module seven_seg_driver(
	input logic clk,
	input logic [23:0] bin_decimal,
	input logic show_opcode,
	input logic [1:0] opcode,
	output logic [6:0] seg0,
	output logic [6:0] seg1,
	output logic [6:0] seg2,
	output logic [6:0] seg3,
	output logic [6:0] seg4,
	output logic [6:0] seg5
);
	logic [3:0] d0, d1, d2, d3, d4, d5;

	assign d0 = bin_decimal[3:0];
	assign d1 = bin_decimal[7:4];
	assign d2 = bin_decimal[11:8];
	assign d3 = bin_decimal[15:12];
	assign d4 = bin_decimal[19:16];
	assign d5 = bin_decimal[23:20];
	
	logic [6:0] seg_d0, seg_d1, seg_d2, seg_d3, seg_d4, seg_d5;

	// decoder
	seven_seg_decoder dec0(.digit(d0), .seg(seg_d0));
	seven_seg_decoder dec1(.digit(d1), .seg(seg_d1));
	seven_seg_decoder dec2(.digit(d2), .seg(seg_d2));
	seven_seg_decoder dec3(.digit(d3), .seg(seg_d3));
	seven_seg_decoder dec4(.digit(d4), .seg(seg_d4));
	seven_seg_decoder dec5(.digit(d5), .seg(seg_d5));
	
	// operation symbol
	logic [6:0] op_seg_left;
	logic [6:0] op_seg_right;
	
	operation_symbol op_left(
		.opcode(opcode),
		.digit_sel(0),
		.seg(op_seg_left)
	);

	operation_symbol op_right(
		.opcode(opcode),
		.digit_sel(1),
		.seg(op_seg_right)
	);
	
	always_comb begin
		seg0 = 7'b1111111;
		seg1 = 7'b1111111;
		seg2 = 7'b1111111;
		seg3 = 7'b1111111;
		seg4 = 7'b1111111;
		seg5 = 7'b1111111;

		if(show_opcode) begin
			seg2 = op_seg_left;
			seg3 = op_seg_right;
		end
		else begin
			seg0 = seg_d0;
			seg1 = seg_d1;
			seg2 = seg_d2;
			seg3 = seg_d3;
			seg4 = seg_d4;
			seg5 = seg_d5;
		end
	end

endmodule