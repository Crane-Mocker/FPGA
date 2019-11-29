module lig(clk100khz, light);
	input clk100khz;
	output [7:0] light;
	
	reg [7:0]light;
	reg [25:0]count, count1;
	reg clk, clk1, clk2, b;
	reg [2:0]flag;
	reg flag1;
	
	initial 
		begin
			b = 1'b1;
	 		flag1 = 1'b0;
		end
	
	always@(posedge clk100khz)
		begin
			if(count == 'd49999)
				begin
					clk1 = ~clk1;
					count <= 0;
				end
			else
				begin count<=count + 1'b1; end
		end
	always@(posedge clk100khz)
		begin
			if(count == 'd4999)
				begin
					clk2 = ~clk2;
					count1 <= 0;
				end
			else
				begin count1 <= count1 + 1'b1; end
		end
	
	always@(posedge clk100khz)
		begin
			if(b)
				clk <= clk1;
			else
				clk <= clk2;
		end
		
	always@(posedge clk)
		begin
			if(flag == 3'b000)
				begin
					light <= 8'b11111111;
					flag <= 3'b001;
				end
			else if(flag == 3'b001)
				begin
					light <= 8'b00000000;
					flag <= 3'b010;
				end
			else if(flag == 3'b010)
				begin
					if(flag1 == 0)
						begin
							light <= 8'b00000001;
							flag1 <= 1'b1;
						end
					else
						begin 
							light <= light << 1;
							if (light[6] == 1)
								begin
									flag1 <= 0;
									flag <= 3'b011;
								end
						end
				end
			else if(flag == 3'b011)
				begin
					if(flag1 == 0)
						begin
							light <= 8'b01010101;
							flag1 <= 1'b1;
						end
					else
						begin 
							light <= ~light;
							if (flag1 == 1'b1)
								begin
									flag1 <= 0;
									flag <= 3'b100;
								end
						end
				end
			else if(flag == 3'b100)
				begin
					flag <= 3'b000;
					b = ~b;
				end
		end
endmodule