  module ram(
  input clk,rst,en,
  input [7:0] d,
  input [9:0] a,
  output reg [7:0] do);
  reg [7:0] ram [1023:0];
  always@(posedge clk)
  begin
  if(rst)
  do <= 0;
  else if(en)
  ram[a] <= d;       
  else
  do <= ram[a];      
  end
  endmodule