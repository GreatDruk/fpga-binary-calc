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


	

endmodule