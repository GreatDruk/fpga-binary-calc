module adder(
		input  logic [8:0] a,
		input  logic [8:0] b,
		output logic [8:0] sum,
		output logic cout
);

	 logic [8:0] carry;

	 half_adder ha0 (
		.a(a[0]), .b(b[0]),
		.q(sum[0]), .cout(carry[0])
	 );

	 full_adder fa1 (
		.a(a[1]), .b(b[1]),
		.cin(carry[0]),
		.q(sum[1]), .cout(carry[1])
	 );

	 full_adder fa2 (
	  .a(a[2]), .b(b[2]),
	  .cin(carry[1]),
	  .q(sum[2]), .cout(carry[2])
	 );

	 full_adder fa3 (
			.a(a[3]), .b(b[3]),
			.cin(carry[2]),
			.q(sum[3]), .cout(carry[3])
	 );

	 full_adder fa4 (
		.a(a[4]), .b(b[4]),
		.cin(carry[3]),
		.q(sum[4]), .cout(carry[4])
	 );

	 full_adder fa5 (
		.a(a[5]),
		.b(b[5]),
		.cin(carry[4]),
		.q(sum[5]),
		.cout(carry[5])
	 );

	 full_adder fa6 (
	  .a(a[6]), .b(b[6]),
	  .cin(carry[5]),
	  .q(sum[6]), .cout(carry[6])
	 );

	 full_adder fa7 (
		.a(a[7]), .b(b[7]),
		.cin(carry[6]),
		.q(sum[7]), .cout(carry[7])
	 );

	 full_adder fa8 (
		.a(a[8]), .b(b[8]),
		.cin(carry[7]),
		.q(sum[8]), .cout(cout)
	);

endmodule