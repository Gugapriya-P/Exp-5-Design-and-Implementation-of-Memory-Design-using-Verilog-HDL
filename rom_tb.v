module rom_tb;
reg clk_t,rst_t;
reg [9:0] a_t;
wire [7:0] do_t;
rom dut(.clk(clk_t),.rst(rst_t),.a(a_t),.do(do_t));
initial
begin
clk_t=1'b0;
rst_t=1'b1;
a_t=10'd0;
#50 rst_t=1'b0;
a_t=10'd100;
#100;
a_t=10'd1023;
#100;
a_t=10'd200;
#100;
$finish;
end
always #10 clk_t=~clk_t;
endmodule