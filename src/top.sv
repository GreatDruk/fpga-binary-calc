module top(
	input logic clk, btn1, btn2,
	input logic [9:0] sw,
	output logic [6:0] seg,
	output logic [5:0] an
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
	
	// Buttons
	logic btn1_clean;
	logic btn2_clean;


	// Arithmetic blocks
	adder add0(.a(A), .b(B), .sum(sum), .cout(cout));
	subtractor sub0(.a(A), .b(B), .diff(diff));
	multiplier mul0(.a(A), .b(B), .product(product));


	// Register state
	stable_pulse sp1(.clk(clk), .btn_in(btn1), .btn_pulse(btn1_clean));
	stable_pulse sp2(.clk(clk), .btn_in(btn2), .btn_pulse(btn2_clean));
	
	always_ff @(posedge clk) begin
		if(btn2_clean)
			state <= ENTER_A;  // reset
		else
			state <= next_state;
	end


	// Transitions
	always_comb begin
		next_state = state;
		case(state)
			ENTER_A:
				if(btn1_clean) next_state = ENTER_OPCODE;
				
			ENTER_OPCODE:
				if(btn1_clean) next_state = ENTER_B;
				
			ENTER_B:
				if(btn1_clean) next_state = SHOW_RESULT;
				
			SHOW_RESULT:
				if(btn2_clean) next_state = ENTER_A;
		endcase
	end


	// Entering numbers
	always_ff @(posedge clk) begin
		if(btn2_clean) begin
			A <= 0;
			B <= 0;
		end
		else begin
			if(state == ENTER_A && btn1_clean)
				A <= sw[8:0];
			if(state == ENTER_B && btn1_clean)
				B <= sw[8:0];
		end
	end


	// Choosing operation
	always_comb begin
		if(sw[9]) opcode = 2'b00;  // +
		else if(sw[8]) opcode = 2'b01;  // -
		else if(sw[7]) opcode = 2'b10;  // *
		else opcode = 2'b00;
	end


	// ALU
	always_comb begin
		case(opcode)
			2'b00: result = {8'b0, sum};
			2'b01: result = {8'b0, diff};
			2'b10: result = product;
			default: result = 0;
		endcase
	end


	// What to show on display
	logic [17:0] display_value;
	
	always_comb begin
		case(state)
			ENTER_A:
				display_value = {8'b0, sw};
			ENTER_OPCODE:
				display_value = {16'b0, opcode};
			ENTER_B:
				display_value = {8'b0, sw};
			SHOW_RESULT:
				display_value = result;
			default:
				display_value = 0;
		endcase
	end
	
	
	// Converting number to decimal
	logic [23:0] bin_decimal;
	binary_to_bin_decimal btbd0(.binary(display_value), .bin_decimal(bin_decimal));
	
	
	// Show operation symbol
	logic show_opcode;

	always_comb begin
		if(state == ENTER_OPCODE)
			show_opcode = 1;
		else
			show_opcode = 0;
	end

	seven_seg_driver disp0(
		.clk(clk), .bin_decimal(bin_decimal),
		.show_opcode(show_opcode), .opcode(opcode),
		.seg(seg), .an(an),
	);

endmodule