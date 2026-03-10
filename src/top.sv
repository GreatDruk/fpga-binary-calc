module top(
	input logic clk, btn1, btn2,
	input logic [9:0] sw,
	output logic [17:0] display_value
);

	// Calculator states
	typedef enum logic [1:0] {
		ENTER_A,
		ENTER_OPCODE,
		ENTER_B,
		SHOW_RESULT
	} state_t;

	state_t state, next_state;

	// Input
	logic [8:0] A;
	logic [8:0] B;
	logic [1:0] opcode;

	// Output
	logic [8:0] sum;
	logic cout;
	logic [8:0] diff;
	logic [17:0] product;
	
	// Result
	logic [17:0] result;


	// Arithmetic blocks
	adder add0(.a(A), .b(B), .sum(sum), .cout(cout));
	subtractor sub0(.a(A), .b(B), .diff(diff));
	multiplier mul0(.a(A), .b(B), .product(product));


	// Register state
	always_ff @(posedge clk) begin
		if(btn2)
			state <= ENTER_A;  // reset
		else
			state <= next_state;
	end


	// Transitions
	always_comb begin
		next_state = state;
		case(state)
			ENTER_A:
				if(btn1) next_state = ENTER_OPCODE;
				
			ENTER_OPCODE:
				if(btn1) next_state = ENTER_B;
				
			ENTER_B:
				if(btn1) next_state = SHOW_RESULT;
				
			SHOW_RESULT:
				if(btn2) next_state = ENTER_A;
		endcase
	end


	// Entering numbers
	always_ff @(posedge clk) begin
		if(btn2) begin
			A <= 0;
			B <= 0;
		end
		else begin
			if(state == ENTER_A && btn1)
				A <= sw[8:0];
			if(state == ENTER_B && btn1)
				B <= sw[8:0];
		end
	end


endmodule