module four_bit_counter(
	input clk,
	input clr,
	output reg Q);

	always@(posedge clk or posedge clr) begin
		if(clr)
			Q <= 4'b0000;
		else 
			Q <= Q + 1'b1;
	end

endmodule
