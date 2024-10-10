//-----------------------------------------------------
// File Name   : picoMIPS_tb.sv
// Function    : testbench for picoMIPS
// Author:  yelin
// Last revised: 25 Mar 2024
//-----------------------------------------------------

module picoMIPS_tb;

logic fastclk;
logic [9:0] SW;

logic [7:0] LED;

picoMIPS4test #(.n(2)) p0 (
		.fastclk(fastclk),
		.SW(SW),
		.LED(LED)
);

initial
begin
	fastclk = 1'b0;
	forever #10 fastclk = ~fastclk;
end

initial
begin
	SW[8] = 1'b0;
	SW[9] = 1'b0;
	#100ns SW[9] = 1'b1;
	#100ns SW[9] = 1'b0;
	
	#100ns SW[7:0]= 8'b00000100;
	
	#100ns SW[8] = 1'b1;
	
	//MUL MUL
	
	#200ns SW[8] = 1'b0;
	
	#100ns SW[7:0]= 8'b00001000;
	
	#100ns SW[8] = 1'b1;
	
	//MUL ADD MUL
	
	#300ns SW[8] = 1'b0;
	
	//ADDI ADD
	
	#200ns SW[8] = 1'b1;
	
	//ADDI
	
	#100ns SW[8] = 1'b0;
	
	#100ns $stop;
end

endmodule