//-----------------------------------------------------
// File Name : regs.sv
// Function : picoMIPS 8 x n registers
// %0 = 0
// %1 - gpr[0]
// %2 - gpr[1]
// %3 - gpr[2]
// %4 - gpr[3] - LED
// %5 - SW0~7
// %6 - sw8
// Author:  yelin
// Last revised: 24 Mar 2024
//-----------------------------------------------------
module regs #(parameter n = 8) (// n - data bus width

	input logic clk, w, // clk and write control
	input logic [n-1:0] Wdata,
	input logic [2:0] Raddr1, Raddr2,
	input logic [8:0] SW,
 
	output logic [n-1:0] Rdata1, Rdata2,
	output logic [7:0] out
);

 	// Declare 32 n-bit registers 
	logic [n-1:0] gpr [3:0];
	assign out = gpr [3];	//%4 for LED display

	
	// write process, dest reg is Raddr2
	always_ff @ (posedge clk)
	begin
		if (w)
            gpr[Raddr2-1] <= Wdata;

	end

	// read process, output 0 if %0 is selected
	always_comb
	begin
	   if (Raddr1 == 3'b000)				//%0
	         Rdata1 = {n{1'b0}};
		else if (Raddr1 == 3'b101)			//%5
				Rdata1 = SW[7:0];
		else if (Raddr1 == 3'b110)			//%6
				Rdata1 = {7'b0000000, SW[8]};
      else  Rdata1 = gpr[Raddr1-1];		//%1-%4
	 
      if (Raddr2 == 3'b000)				//%0
				Rdata2 = {n{1'b0}};
//		else if (Raddr2 == 3'b101)			//%5
//				Rdata2 = SW[7:0];
	   else  Rdata2 = gpr[Raddr2-1];		//%1-%4
	end	
	

endmodule // module regs