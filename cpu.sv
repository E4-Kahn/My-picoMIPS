//------------------------------------
// File Name   : cpu.sv
// Function    : picoMIPS CPU top level encapsulating module
// Author:  yelin
// PC , prog memory, regs, ALU and decoder, no RAM
// Last revised: 24 Mar 2024
//------------------------------------

`include "alucodes.sv"
module cpu #( parameter n = 8) // data bus width
(input logic clk,  
  input reset, // master reset
  input [8:0] SW,
  output logic[n-1:0] outport // need an output port, tentatively this will be the ALU output
);       

// declarations of local signals that connect CPU modules
// ALU
logic [2:0] ALUfunc; // ALU function
logic flag; // ALU flags, routed to decoder
logic imm; // immediate operand signal
logic [n-1:0] Alub; // output from imm MUX
//
// registers
logic [n-1:0] Rdata1, Rdata2, Wdata; // Register data
logic w; // register write control
//
// Program Counter 
parameter Psize = 4; // up to 16 instructions
logic PCincr, PCrelbranch; // program counter control
logic [Psize-1 : 0] ProgAddress;
// Program Memory
parameter Isize = 20; // Isize - instruction width
logic [Isize-1 : 0] I; // I - instruction code

//------------- code starts here ---------
// module instantiations
pc  #(.Psize(Psize)) progCounter (.clk(clk),.reset(reset),
        .PCincr(PCincr),
        .PCrelbranch(PCrelbranch),
        .Branchaddr(I[Psize-1:0]), 
        .PCout(ProgAddress) );

prog #(.Psize(Psize),.Isize(Isize)) 
      progMemory (.address(ProgAddress),.I(I));

decoder  D (.opcode(I[Isize-4:Isize-6]),
            .PCincr(PCincr), 
            .PCrelbranch(PCrelbranch),
            .flag(flag), // ALU flags
				.ALUfunc(ALUfunc),.imm(imm),.w(w));

regs   #(.n(n))  gpr(.clk(clk),.w(w),
			.Wdata(Wdata),
			.Raddr2(I[Isize-7:Isize-9]),  // reg %d number
			.Raddr1(I[Isize-10:Isize-12]), // reg %s number
			.Rdata1(Rdata1),.Rdata2(Rdata2),
			.SW(SW), .out(outport));

alu    #(.n(n))  iu(.a(Rdata1),.b(Alub),
       .func(ALUfunc),.flag(flag),
       .result(Wdata)); // ALU result -> destination reg

// create MUX for immediate operand
assign Alub = (imm ? I[n-1:0] : Rdata2);

endmodule