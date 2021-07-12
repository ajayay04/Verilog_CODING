module scrolling_number(
	intput clk,
	input reset,
	input [7:0]sw,
	output [6:0]seg,
	output [3:0]en
	);

	reg[25:0] count;  // for holding count of 50M for number scrolling every 1 second
	wire click;
	reg [3:0] fourth, third, second, first;

	always@(posedge clock or posedge reset) begin
		if(reset)
			count <= 0;
		else if(count == 50_000_000)
			count <= 0;
		else
			count <= count + 1;
	end

	assign click = ((count==50_000_000) ? 1'b1 : 1'b0);

	reg [3:0] clickcount;  //register to hold count upto 8, i.e why 4-bit used here, can be changed

	always@(posedge click or posedge reset) begin
		if(reset)
			clickcount <= 0;
		else if(clickcount == 8)
			clickcount <= 0;
		else
			clickcount <= clickcount + 1;
	end

	wire[3:0] ones, tens, hunds;
	Binary_to_BCD u1(sw, ones,tens, hunds);

	always@(*) begin
		case(clickcount)
		0:
			begin
				fourth = 0;
				third = 0;
				second = 0;
				first = 2;
			end
		1:
			begin
				fourth = 0;
				third = 0;
				second = 2;
				first = hunds;
			end
		2:
			begin
				fourth = 0;
				third = 2;
				second = hunds;
				first = tens;
			end
		3:
			begin
				fourth = 2;
				third = hunds;
				second = tens;
				first = ones;
			end
		4:
			begin
				fourth = 2;
				third = hunds;
				second = tens;
				first = ones;
			end
		5:
			begin
				fourth = 2;
				third = hunds;
				second = tens;
				first = ones;
			end 
		6:
			begin
				fourth = hunds;
				third = tens;
				second = ones;
				first = 2;
			end
		7:
			begin
				fourth = tens;
				third = ones;
				second = 2;
				first = hunds;
			end	
		8:
			begin
				fourth = ones;
				third = 2;
				second = hunds;
				first = tens;
			end
		endcase
	end

// now turing seven segment on-off 

	localparam N = 2; // anything above 2-bits

	always@(posedge clk or posedge reset) begin
		if(reset)
			count <= 0;
		else
			count <= count + 1;
	end

	reg[3:0]Y;  // here number via sw will be displayed
	reg[3:0]an_temp;  // for enableing each of the 7-segment

	always@(*) begin  // input are clk, sw, reset...
		case(count[N-1:N-2])
			2'b00: 
				begin
					Y = first;
					an_temp = 4'b1110;
				end
			2'b01:
				begin
					Y = second;
					an_temp = 4'b1101;
				end	
			2'b10:
				begin
					Y = third;
					an_temp = 4'b1011;
				end
			2'b11:
				begin
					Y = fourth;
					an_temp = 4'b1110;
				end
			endcase
	end

	assign en = an_temp;

	bcd7seg u2(Y, seg);

endmodule
