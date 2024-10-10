
module picoMIPS4test #(parameter n = 24) (
  input logic fastclk,  // 50MHz Altera DE0 clock
  input logic [9:0] SW, // Switches SW0..SW9

  output logic [7:0] LED); // LEDs
  
  logic clk; // slow clock, about 10Hz
  counter #(.n(n)) count (.fastclk(fastclk),.clk(clk)); // slow clk from counter
  

    cpu myDesign (.clk(clk), .reset(SW[9]),.SW(SW[8:0]),.outport(LED)); //change fastclk to clk on fpga
endmodule

