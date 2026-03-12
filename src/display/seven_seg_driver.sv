module seven_seg_driver(
	input  logic clk,
	input  logic [23:0] bin_decimal,
	output logic [6:0] seg,
	output logic [5:0] an,
	input logic show_opcode,
	input logic [1:0] opcode
);

	logic [2:0] digit_sel;
	logic [15:0] refresh_cnt;
	logic [3:0] curr_digit;

	seven_seg_decoder dec0(.digit(curr_digit), .seg(seg));
	
	
	logic [6:0] op_seg;
	operation_symbol op0(.opcode(opcode), .digit_sel(digit_sel), .seg(op_seg));

	always_ff @(posedge clk)
		refresh_cnt <= refresh_cnt + 1;

	assign digit_sel = refresh_cnt[15:13];

	always_comb begin
		if(show_opcode) begin
			case(digit_sel)
				3'd0: begin
					an = 6'b111101;
					seg = op_seg;
				end
				
				3'd1: begin
					an = 6'b111110;
					seg = op_seg;
				end
				
				default: begin
					an = 6'b111111; 
					seg = 7'b1111111; 
				end
			endcase
		end
		else begin
			case(digit_sel)
				3'd0: begin
					an = 6'b111110;
					curr_digit = bin_decimal[3:0];
				end
				
				3'd1: begin
					an = 6'b111101;
					curr_digit = bin_decimal[7:4];
				end
				
				3'd2: begin
					an = 6'b111011;
					curr_digit = bin_decimal[11:8];
				end
				
				3'd3: begin
					an = 6'b110111; 
					curr_digit = bin_decimal[15:12];
				end
				
				3'd4: begin 
					an = 6'b101111; 
					curr_digit = bin_decimal[19:16];
				end
				
				3'd5: begin
					an = 6'b011111; 
					curr_digit = bin_decimal[23:20]; 
				end

				default: begin
					an = 6'b111111; 
					curr_digit = 0;
				end
			endcase 
		end
	end

endmodule