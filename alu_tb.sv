//-----------------------------------------------------
// File Name   : alu_tb.sv
// Function    : testbench for picoMIPS alu module
// Author:  yelin
// Last revised: 26 Mar 2024
//-----------------------------------------------------


`include "alucodes.sv"

module alu_tb;

parameter n = 8; //data bus width

logic [n-1:0] a, b; 		// ALU operands
logic [2:0] func; 		// ALU function code	
logic flag;					// ALU flag
logic [n-1:0] result; 	// ALU result

alu #(.n(n)) dut (.a(a), .b(b),
						.func(func),
						.flag(flag),
						.result(result)
);

initial
begin
	a = 8'b00000100;		//4
	b = 8'b00001000;		//8
	func = `RLD;
	#10ns func = `RADD;	//12
	#10ns func = `RADDI;	//12
	#10ns 
	a = 8'b01100000;		//0.75
	b = 8'b00000110;		//6	
	func = `RMUL;			//4
	#10ns
	
	a = 8'b11100000;		//-0.25
	b = 8'b00010100;		//20	
	func = `RMUL;			//-5
	#10ns	
	
	a = 8'b00000000;  	//SW8 = 0, Rdata1 = {7'b0000000, SW[8]};
	b = 8'b00000000;		//%0	b1 = ~b + 1'b1 = n{1'b0}
	func = `RBEQ;			//    ar = a + b1 = n{1'b0} + n{1'b0} = n{1'b0}
	#10ns						//    flag = 1
		 
	a = 8'b00000001;		//SW8 = 1, Rdata1 = 8'b00000001;							
	b = 8'b00000000;		//%0	b1 = ~b + 1'b1 = n{1'b0}
	func = `RBNE;			//    ar = a + b1 = 8'b00000001 + n{1'b0} = 8'b00000001
								//		flag = 0
							
end

endmodule


