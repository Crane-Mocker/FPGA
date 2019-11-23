module y38(a0,a1,a2,s1,s2,s3,y);
 input a0,a1,a2,s1,s2,s3;
 output[7:0] y;
 reg[7:0] y;
 reg s;
reg[2:0]a;
always@(a0,a1,a2,s1,s2,s3)
 begin
  s<=s2|s3;
  a<={a2,a1,a0};
   if(s1==0)
  y<=8'b11111111;
else
   if(s==1)
		y<=8'b111111;
	else
	  begin
		   case(a)
		3'b000:y<=8'b11111110;
		3'b001:y<=8'b11111101;
		3'b010:y<=8'b11111011;
		3'b011:y<=8'b11110111;
		3'b100:y<=8'b11101111;
		3'b101:y<=8'b11011111;
		3'b110:y<=8'b10111111;
		default: y<=8'b01111111;
		endcase
   end
	end
 endmodule