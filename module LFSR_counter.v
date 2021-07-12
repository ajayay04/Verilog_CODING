module LFSR_counter(
	input clk,
	input clr,
	input reset,
	output reg[3:0]lfsr_out);

	wire [3:0] Q;
	wire clk_out;

	//instantiate Clock_1Hz module and four_bit_counter module
	Clock_1Hz u1(clk, clr_out);
	four_bit_counter u2(clk_out, clr,Q);

	always@(posedge clk_out or posedge reset);
		begin
			if(reset)
				lfsr_out <= 4'b0000;
			else
				begin
					case(Q)
						4'b0000: lfsr_out <= 4'b0000;
						4'b0001: lfsr_out <= 4'b0001;
						4'b0010: lfsr_out <= 4'b0010;

						4'b0011: lfsr_out <= 4'b0101;

						4'b0100: lfsr_out <= 4'b1010;
						4'b0101: lfsr_out <= 4'b0100;
						4'b0110: lfsr_out <= 4'b1001;
						4'b0111: lfsr_out <= 4'b0011;
						
						4'b1000: lfsr_out <= 4'b0110;
						4'b1001: lfsr_out <= 4'b1101;
						4'b1010: lfsr_out <= 4'b1011;
						4'b1011: lfsr_out <= 4'b0111;
						
						4'b1100: lfsr_out <= 4'b1110;
						4'b1101: lfsr_out <= 4'b1100;
						4'b1110: lfsr_out <= 4'b1000;
						4'b1111: lfsr_out <= 4'b0000;

						default: lfsr_out <= 4'b0000;
					endcase
				end
		end

endmodule
