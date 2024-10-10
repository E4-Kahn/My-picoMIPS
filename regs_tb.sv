//-----------------------------------------------------
// File Name   : regs_tb.sv
// Function    : testbench for picoMIPS regs module
// %0 = 0
// %1 - gpr[0]
// %2 - gpr[1]
// %3 - gpr[2]
// %4 - gpr[3] - LED
// %5 - SW0~7
// %6 - sw8
// Author:  yelin
// Last revised: 26 Mar 2024
//-----------------------------------------------------

`include "alucodes.sv"

module regs_tb;

parameter n = 8; //data bus width

logic clk, w; // clk and write control
logic [n-1:0] Wdata;
logic [2:0] Raddr1, Raddr2;//Raddr1=%s, Raddr2=%d
logic [8:0] SW;
 
logic [n-1:0] Rdata1, Rdata2;
logic [7:0] out;

regs #(.n(n)) dut (.clk(clk), .w(w),
						.Wdata(Wdata),
						.SW(SW),
						.Raddr1(Raddr1),
						.Raddr2(Raddr2),
						.Rdata1(Rdata1),
						.Rdata2(Rdata2),
						.out(out)
);

initial
begin
	clk = 1'b0;
	forever #5ns clk= ~clk;
end

initial
begin
	w = 1'b0;
	Wdata = 7'b0;
	
	//BEQ %0, %6, -1;
	SW = 9'b100000100;	//SW8 = 1, x1 = 4
	Raddr1 = 3'b110;		//%d = %0, %s = %6
	Raddr2 = 3'b000;
	//result: Rdata1=8'b00000001, Rdata2=n{1'b0}
	
	//MUL %1, %5, 0.75
	#30ns
	w = 1'b1;
	Wdata = 8'b00000011;	//4 * 0.75 = 3
	Raddr1 = 3'b101;		//%s = %5
	Raddr2 = 3'b001;		//%d = %1
	//result: Rdata1=8'b00000100, Rdata2=gpr[0]
	//			 gpr[0]=8'b00000011
	
	//ADDI %4, %1, 20
	#30ns
	w = 1'b1;
	Wdata = 8'b00010111;	//3 + 20 = 23
	Raddr1 = 3'b001;		//%s = %1
	Raddr2 = 3'b100;		//%d = %4
	//result: Rdata1=gpr[0]=8'b00000011
	//			 Rdata2=gpr[3]
	//			 gpr[3]=8'b00010111 --> out
end

endmodule
