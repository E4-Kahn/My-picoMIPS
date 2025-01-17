//-----------------------------------------------------
// File Name   : decoder.sv
// Function    : decoder module for mypicoMIPS
// modified from the reference version of tjk
// Author:  yelin
// Last revised: 23 Mar 2024
//-----------------------------------------------------

`include "opcodes.sv"
//---------------------------------------------------------
module decoder #(parameter n =8) (

	input logic [2:0] opcode, // second 3 bits of instruction
	input flag,
	
	output logic PCincr, PCrelbranch, // PC control
	output logic [2:0] ALUfunc, // ALU control
	output logic imm, // imm mux control
	output logic w// register file control
 );
   
//------------- code starts here ---------
// instruction decoder
logic takeBranch;
always_comb 
begin
  // set default output signal values for NOP instruction
   PCincr = 1'b1; // PC increments by default
	PCrelbranch = 1'b0;
   ALUfunc = opcode[2:0]; 
   imm = 1'b0; w = 1'b0;
	takeBranch = 1'b0;

   case(opcode)
		`LD:  begin
			w = 1'b1;
		   imm = 1'b0;//use data from switches
		   end
		`ADD: begin // register-register
			w = 1'b1; // write result to dest register
			imm = 1'b0;//use data from regs
	      end
		`ADDI,`MUL: begin // register-immediate
			w = 1'b1; // write result to dest register
			imm = 1'b1; //use imm
			end
		
		//branches
		`BEQ: takeBranch = flag;
		`BNE: takeBranch = ~flag;

		default:
			$error("unimplemented opcode %h",opcode);
   endcase // opcode

	if (takeBranch)
	begin
		PCincr = 1'b0;
		PCrelbranch = 1'b1;
	end
	
end // always_comb


endmodule //module decoder --------------------------------