module rom(
input clk,rst,
input[9:0]a,
output reg [9:0]do );
reg[7:0] rom[1023:0];
initial 
begin
rom[10'd100]=8'd100;
rom[10'd1023]=8'd125;
end
always@(posedge clk)
begin
if(rst)
do<=8'b0;
else
do<=rom[a];
end
endmodule