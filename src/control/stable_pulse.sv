module stable_pulse(
	input  logic clk, btn_in,
	output logic btn_pulse
);

	logic [15:0] cnt = 0;
	logic btn_sync0, btn_sync1;
	logic btn_state;

	// syncing to clk
	always_ff @(posedge clk) begin
		btn_sync0 <= btn_in;
		btn_sync1 <= btn_sync0;
	end

	// stability counter
	always_ff @(posedge clk) begin
		if (btn_sync1 == btn_state) begin
			cnt <= 0;
		end else begin
			cnt <= cnt + 1;
			if (cnt == 16'hFFFF) begin
				btn_state <= btn_sync1;
				cnt <= 0;
			end
		end
	end

	// pulse when pressed
	logic prev;
	always_ff @(posedge clk) begin
		prev <= btn_state;
		btn_pulse <= btn_state & ~prev;
	end

endmodule