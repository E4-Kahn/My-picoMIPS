//-----------------------------------------------------
// File Name   : decoder_tb.sv
// Function    : testbench for picoMIPS decoder module
// Author:  yelin
// Last revised: 26 Mar 2024
//-----------------------------------------------------

`include "opcodes.sv"

module decoder_tb;

logic [2:0] opcode;
logic flag;

logic PCincr,PCrelbranch;
logic [2:0] ALUfunc;
logic imm;
logic w;
	
decoder #(.n(8)) dut (
	.opcode(opcode),
   .ALUfunc(ALUfunc),
	.flag(flag),
   .imm(imm),
	.PCincr(PCincr),
	.PCrelbranch(PCrelbranch),
   .w(w)
);

initial
begin
      opcode=3'b000; //LD
		
#10ns opcode=3'b001; //BNE
		flag = 1'b0;
		
#10ns opcode=3'b010; //BEQ
		flag = 1'b1;
		
#10ns opcode=3'b100; //ADD

#10ns opcode=3'b101; //ADDI

#10ns opcode=3'b110; //MUL

end

endmodule