module operation_symbol(
	input  logic [1:0] opcode,
	input  logic digit_sel,
	output logic [6:0] seg
);

	always_comb begin
		case(opcode)
			// +
			2'b00: begin
				if(digit_sel == 0)
					seg = 7'b0111001; // - + |
				else
					seg = 7'b0001111; // | + -
			end

			// -
			2'b01: begin
				seg = 7'b0111111; // -
			end

			// *
			2'b10: begin
				if(digit_sel == 0)
					seg = 7'b0110000; // = + |
				else
					seg = 7'b0000110; // | + =
			end

			default:
				seg = 7'b1111111;

		endcase
	end

endmodule