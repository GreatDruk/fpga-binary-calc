module binary_to_bin_decimal(
	input  logic [17:0] binary,
	output logic [23:0] bin_decimal
);

	integer i;
	logic [41:0] shift;

	always_comb begin
		shift = 0;
		shift[17:0] = binary;

		for(i = 0; i < 18; i++) begin
			if(shift[21:18] >= 5) shift[21:18] += 3;
			if(shift[25:22] >= 5) shift[25:22] += 3;
			if(shift[29:26] >= 5) shift[29:26] += 3;
			if(shift[33:30] >= 5) shift[33:30] += 3;
			if(shift[37:34] >= 5) shift[37:34] += 3;
			if(shift[41:38] >= 5) shift[41:38] += 3;

			shift = shift << 1;
		end

		bin_decimal = shift[41:18];
	end

endmodule