//-----------------------------------------------------
// File Name   : prog_tb.sv
// Function    : testbench for picoMIPS prog module
// Author:  yelin
// Last revised: 27 Mar 2024
//-----------------------------------------------------

module prog_tb;

parameter Psize = 4;
parameter Isize = 20;

logic [Psize-1:0] address;
logic [Isize-1:0] I;

logic [Isize-1:0] progMem[ (1<<Psize)-1:0];
	
prog #(.Psize(Psize), .Isize(Isize)) dut (
	.address(address),
	.I(I)
);

initial
begin
			address = 4'b0000;	//PCout++
	#10ns	address = 4'b0001;
	#10ns	address = 4'b0010;
	#10ns	address = 4'b0011;
   #10ns address = 4'b0100;
   #10ns address = 4'b0101;
   #10ns address = 4'b0110;
   #10ns address = 4'b0111;
   #10ns address = 4'b1000;
   #10ns address = 4'b1001;
   #10ns address = 4'b1010;
   #10ns address = 4'b1011;
   #10ns address = 4'b1100;
   #10ns address = 4'b1101;
   #10ns address = 4'b1110;
   #10ns address = 4'b1111;
	$stop;
end

endmodule