module cnt16(clk100khz,clk1hz,clk10hz,rst,en,din,op,scan,dout);
input rst;
input en;
input din;
input op;
input clk100khz,clk1hz,clk10hz;
output[7:0] dout;
output[5:0] scan;
reg[7:0] dout;
reg[5:0] scan;
reg f1,f2,c;
reg[2:0] cnt;
reg[3:0] dat;
reg[3:0] data1;
reg[3:0] data2;

always@(posedge clk10hz)
	begin if(!din)	c<=1;
		else c<=0;
	end
	
always@(din or clk1hz)
	begin	f1<=(c & en) | (clk1hz & (~en));end
	
always@(posedge f1)
	if(!rst)
		begin
			data1<=0;f2<=1;
		end
	else if(!op)
		begin
			if(data1==15)
				begin
					data1<=0;f2<=1;
				end
			else
				begin
					data1<=data1+1;f2<=0;
				end
		end
	else
		begin
			if(data1==0)
				begin
					if(data2!=0)
						begin
							data1<=15;f2<=1;
						end
				end
			else
				begin
					data1<=data1-1;f2<=0;
				end
		end
	
always@(posedge f2)
	if(!rst) 
		begin data2<=0;end
	else if(!op)
		begin
			if(data2==15)
				begin	data2<=0; end
			else
				begin data2<=data2+1; end
		end
	else
		begin
			if(data2!=0)
				begin
					data2<=data2-1;
			end
		end
		
	always@(posedge clk100khz)
		begin
			if(cnt==3'b001)
				begin cnt<=0;end
			else
				begin cnt<=cnt+1;end
			end
			
	always@(cnt,data1,data2)
		begin
			case(cnt)
				3'b000:begin scan<=6'b00100;dat<=data1;end
				3'b001:begin scan<=6'b01000;dat<=data2;end
				default:begin scan<=6'b00000;end
			endcase
		end
		
	always@(dat)
		begin
			case(dat)
				4'b0000:dout[7:0]<=8'b00111111;
				4'b0001:dout[7:0]<=8'b00000110;
				4'b0010:dout[7:0]<=8'b01011011;
				4'b0011:dout[7:0]<=8'b01001111;
				4'b0100:dout[7:0]<=8'b01100110;
				4'b0101:dout[7:0]<=8'b01101101;
				4'b0110:dout[7:0]<=8'b01111101;
				4'b0111:dout[7:0]<=8'b00000111;
				4'b1000:dout[7:0]<=8'b01111111;
				4'b1001:dout[7:0]<=8'b01101111;
				4'b1010:dout[7:0]<=8'b01110111;
				4'b1011:dout[7:0]<=8'b01111100;
				4'b1100:dout[7:0]<=8'b00111001;
				4'b1101:dout[7:0]<=8'b01011110;
				4'b1110:dout[7:0]<=8'b01111001;
				4'b1111:dout[7:0]<=8'b01110001;
				default:dout[7:0]<=8'b00000000;
			endcase
		end
	endmodule