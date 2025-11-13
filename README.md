# Exp-5-Design-and-Simulate the-Memory-Design-using-Verilog-HDL
#Aim
To design and simulate a RAM,ROM,FIFO using Verilog HDL, and verify its functionality through a testbench in the Vivado 2023.1 environment.
Apparatus Required
Vivado 2023.1
Procedure
1. Launch Vivado 2023.1
Open Vivado and create a new project.
2. Design the Verilog Code
Write the Verilog code for the RAM,ROM,FIFO
3. Create the Testbench
Write a testbench to simulate the memory behavior. The testbench should apply various and monitor the corresponding output.
4. Create the Verilog Files
Create both the design module and the testbench in the Vivado project.
5. Run Simulation
Run the behavioral simulation to verify the output.
6. Observe the Waveforms
Analyze the output waveforms in the simulation window, and verify that the correct read and write operation.
7. Save and Document Results
Capture screenshots of the waveform and save the simulation logs. These will be included in the lab report.

# Code
# RAM
```

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
  ```
// Test bench
```
module ram_tb;
reg clk_t, rst_t, en_t;
reg [7:0] datain_t;
reg [9:0] address_t;
wire [7:0] dataout_t;
ram dut (
.clk(clk_t),
.rst(rst_t),
.en(en_t),
.datain(datain_t),
.address(address_t),
.dataout(dataout_t)
);

initial begin
clk_t = 1'b0;
rst_t = 1'b1;
#100
rst_t = 1'b0;
en_t=1'b1;
address_t = 10'd800;
datain_t = 8'd50;
#100;
address_t = 10'd950;
datain_t = 8'd60;
#100;
en_t = 1'b0;
address_t = 10'd800;
#100;
address_t = 10'd950;
#100;
end
endmodule
```
// output Waveform

<img width="1483" height="855" alt="image" src="https://github.com/user-attachments/assets/fa9c5045-8ffe-4fd9-af1a-362b0dc37e0a" />

# ROM
 // write verilog code for ROM using $random
 ```
 
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
```
 // Test bench
```
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
```
// output Waveform

<img width="1797" height="900" alt="image" src="https://github.com/user-attachments/assets/d70e6c63-d7b1-4195-a157-f0f028b579e5" />

 # FIFO
 // write verilog code for FIFO
 ```
 module fifo1 #(parameter DEPTH=8, DATA_WIDTH=8) (input clk, rst_n,
input w_en, r_en,
input [DATA_WIDTH-1:0] data_in,
output reg [DATA_WIDTH-1:0] data_out,
output full, empty
);

reg [$clog2(DEPTH)-1:0] w_ptr, r_ptr;
reg [DATA_WIDTH-1:0] fifo[DEPTH-1:0];

// Set Default values on reset.
always@(posedge clk) begin
if(!rst_n) begin
 w_ptr <= 0; r_ptr <= 0;
 data_out <= 0;
end
end

// To write data to FIFO
always@(posedge clk) begin
if(w_en & !full)begin
 fifo[w_ptr] <= data_in;
 w_ptr <= w_ptr + 1;
 end
 end

// To read data from FIFO
always@(posedge clk) begin
if(r_en & !empty) begin
 data_out <= fifo[r_ptr];
 r_ptr <= r_ptr + 1;
end
end

assign full = ((w_ptr+1'b1) == r_ptr);
assign empty = (w_ptr == r_ptr);
endmodule
```
 // Test bench
```
module fifo1_tb;
reg clk_t, rst_t;
reg w_en_t, r_en_t;
reg [7:0] data_in_t;
wire [7:0] data_out_t;
wire full_t, empty_t;

fifo1 dut (.clk(clk_t),.rst_n(rst_t),.w_en(w_en_t),.r_en(r_en_t),.data_in(data_in_t),
.data_out(data_out_t),
.full(full_t),
.empty(empty_t)
);

always #10 clk_t = ~clk_t;

initial begin
clk_t = 1'b0;
rst_t = 1'b0;
w_en_t = 1'b0;
r_en_t = 1'b0;
data_in_t = 8'd0;

#50 rst_t = 1'b1;
#20 w_en_t = 1'b1; data_in_t = 8'd10;
#20 data_in_t = 8'd20;
#20 data_in_t = 8'd30;
#20 data_in_t = 8'd40;
#20 w_en_t = 1'b0;
#40 r_en_t = 1'b1;
#100 r_en_t = 1'b0;
end
endmodule
```
// output Waveform

<img width="1590" height="832" alt="image" src="https://github.com/user-attachments/assets/b6fb177a-211d-49ce-92a9-308d05e780c2" />

# Conclusion
The RAM, ROM, FIFO memory with read and write operations was designed and successfully simulated using Verilog HDL. The testbench verified both the write and read functionalities by simulating the memory operations and observing the output waveforms. The experiment demonstrates how to implement memory operations in Verilog, effectively modeling both the reading and writing processes.
 
 

