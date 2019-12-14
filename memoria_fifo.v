`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:42:51 11/13/2019
// Design Name:   Memoria_Leds
// Module Name:   /home/joao/Documents/FPGA/basys2usertest/Basys2UserTest/WS2811/memoria_fifo.v
// Project Name:  WS2811
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Memoria_Leds
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module memoria_fifo;

	// Inputs
	reg clk;
	reg [55:0] din;
	reg wr_en;
	reg rd_en;

	// Outputs
	wire [55:0] dout;
	wire full;
	wire empty;

	// Instantiate the Unit Under Test (UUT)
	Memoria_Leds uut (
		.clk(clk), 
		.din(din), 
		.wr_en(wr_en), 
		.rd_en(rd_en), 
		.dout(dout), 
		.full(full), 
		.empty(empty)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		din = 0;
		wr_en = 0;
		rd_en = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

