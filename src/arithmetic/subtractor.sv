module subtractor(
	input  logic [8:0] a,
	input  logic [8:0] b,
	output logic [8:0] diff,
	output logic cout
);

	logic [8:0] b_inv;
	logic [8:0] sum;
	logic carry;

	assign b_inv = ~b;

	adder add0 (
		.a(a), .b(b_inv + 9'b000000001),
		.sum(diff), .cout(cout)
	);

endmodule