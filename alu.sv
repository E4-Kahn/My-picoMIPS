//-----------------------------------------------------
// File Name   : alu.sv
// Function    : ALU module for mypicoMIPS
// modified from the reference version of tjk
// Author:  yelin
// Last revised: 24 Mar 2024
//-----------------------------------------------------

`include "alucodes.sv"  
module alu #(parameter n =8) (

   input logic [n-1:0] a, b, 		// ALU operands
   input logic [2:0] func, 		// ALU function code
	
	output logic flag,				// ALU flag
   output logic [n-1:0] result 	// ALU result
);

       
//------------- code starts here ---------

logic [n-1:0] ar, b1;		//temp signals
logic [((2*n)-1):0] mr;		//mul result

	
//multiplier
always_comb
	begin
		mr = {{n{a[7]}}, a[7:0]} * {{n{b[7]}}, b[7:0]};
	end

//adder & suber for BEQ & BNE	
always_comb
begin
   if ((func==`RBEQ) || (func == `RBNE))
      b1 = ~b + 1'b1; // 2's complement subtrahend
   else b1 = b;

   ar = a+b1; // n-bit adder
end // always_comb
   
// create the ALU
always_comb
	begin
	  flag = 1'b0;	
	  result = a;
	  case(func)
			`RLD   : result = a;

			`RADD  : result = ar;
		
			`RADDI : result = ar;
				
			`RMUL  : result = mr [14:7];
			
			`RBEQ  : result = ar;
			
			`RBNE  : result = ar;
			
			default:	result = a;
		endcase
		
		flag = result == {n{1'b0}};	
		
		// if func = BEQ, 
		//    ar = a + b1 = n{1'b0} + n{1'b0} = n{1'b0}
		//    flag = 1 --> takeBranch = 1
		// otherwise func = BNE,
		//    b = 0000 0001
		//    b1 = ~b + 1'b1 = n{1'b0}
		//    ar = a + b1 = 8'b00000001 + n{1'b0} = 8'b00000001
		//    flag = 0 --> takeBranch = 1
		  
	 end //always_comb

endmodule //end of module ALU

