module half_adder(
		input a, b, 
		output q, carry
);
		always_comb begin
				q = a ^ b;
				carry = a & b;
		end
endmodule