module Clock_1Hz(
	input clk_in,   // input clk from FPGA board
	output clk_out  // 1Hz clk output
	);

	reg [25:0] count = 0; // set counter value for reducing clk frequency

	reg clk_out;

	always@(posedge clk_in) begin

		count <= count+1;
		if(count == 50_000_000) begin
			count <= 0;
			clk_out = ~clk_out
		end
	end

endmodule
