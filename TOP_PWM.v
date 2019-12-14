`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:08:00 12/11/2019 
// Design Name: 
// Module Name:    TOP_PWM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module TOP_test_2(
	input wire clk,
	input wire entrada_PWM,
	input wire C_valid_PWM,
	input wire PWM_select,
	output wire ready,
	output wire PWM_signal
	
	
	);
	PWM PWM_real (
	//entradas
		.clk(clk),
		.data(entrada_PWM),
		.select(PWM_select),
		.PWM_valid_I(C_valid_PWM),
	//saidas
		.PWM_signal(PWM_signal),
		.PWM_TOP(ready)
		
	);
		
	
endmodule
