module full_adder(
		input cin, a, b,
		output q, cout
);
		wire w, c1, c2;
		
		half_adder ha1 (.a(a), .b(b), .q(w),  .cout(c1));
				
		half_adder ha2 (.a(cin), .b(w), .q(q), .cout(c2));

		assign cout = c1 | c2;
endmodule