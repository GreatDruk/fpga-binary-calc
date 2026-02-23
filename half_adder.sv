module half_adder(
		input a, b, 
		output q, cout
);
		always_comb begin
				q = a ^ b;
				cout = a & b;
		end
endmodule