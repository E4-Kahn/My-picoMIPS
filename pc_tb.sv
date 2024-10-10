//-----------------------------------------------------
// File Name   : pc_tb.sv
// Function    : testbench for picoMIPS pc module
// Author:  yelin
// Last revised: 27 Mar 2024
//-----------------------------------------------------


module pc_tb;

parameter Psize = 4; //data bus width

logic clk, reset, PCincr, PCrelbranch;
logic [Psize-1:0] Branchaddr;
logic [Psize-1:0] Rbranch;
logic [Psize-1 : 0]PCout;

pc #(.Psize(Psize)) dut (
		.clk(clk), .reset(reset),
		.PCincr(PCincr),
		.PCrelbranch(PCrelbranch),
		.Branchaddr(Branchaddr),
		.PCout(PCout)
);

initial
begin
	clk = 1'b0;
	forever #5ns clk= ~clk;
end

initial
begin
	reset = 1'b0;	
	#10ns	reset = 1'b1;
	#10ns	reset = 1'b0;
	
	PCincr = 1'b0;
	PCrelbranch = 1'b0;
	Branchaddr = 4'b0000;
	
	
	// pc increment
	#10ns
	PCincr = 1'b1;
	PCrelbranch = 1'b0;
	//result: PCout=1
	
	// pc relative branch
	//BEQ %0, %6, -1;
	//takeBranch = flag = 1
	//Branchaddr = I[Psize-1:0]
	#10ns
	PCincr = 1'b0;
	PCrelbranch = 1'b1;
	Branchaddr = 4'b0000;
	//result: PCout=1
	
	// pc increment
	#10ns
	PCincr = 1'b1;
	PCrelbranch = 1'b0;
	//result: PCout=2
	$stop;
							
end

endmodule

