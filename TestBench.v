`timescale 1ns / 1ps 

module testBench;

	// Inputs
	reg clk = 0;
	reg sim_led_data = 0;
	reg flag_de_escrita = 1; // mudar flag
	reg c_print_flag = 1;
	


	// Outputs
	wire PWM_signal;
	wire mem_out;
	wire [57:0] saida_dados;
	wire wr_ack;
	wire entrada_PWM;
	// Wires
	wire ready;
	wire PWM_select;
	wire flag_de_leitura;
	wire valid;
	wire C_valid_PWM;
	wire R_data_C;
	wire R_bus_C;
	reg [57:0] entrada_dados = 1;
	
	
	// Instantiate the Unit Under Test (UUT)

/*
	memoria_fifo uut_memoria (
		.clk(clk), // input clk
		//.rst(rst), // input rst
		.din(entrada_dados), // input [57 : 0] din
		.wr_en(flag_de_escrita), // input wr_en
		.rd_en(flag_de_leitura), // input rd_en
		.dout(saida_dados), // output [57 : 0] dout
		//.full(full), // output full
		.wr_ack(wr_ack), // output wr_ack
		//.empty(empty), // output empty
		.valid(valid) // output valid
		//.data_count(data_count) // output [8 : 0] data_count
	);
*/

	RAM uut_RAM (
	  //.a(a), // input [11 : 0] a
	  //.d(d), // input [7 : 0] d
	  .dpra(R_bus_C), // input [11 : 0] dpra
	  .clk(clk), // input clk
	  //.we(we), // input we
	  //.spo(spo), // output [7 : 0] spo
	  .dpo(R_data_C) // output [7 : 0] dpo
	);

	PWM uut_PWM (
	//entradas
		.clk(clk),
		.data(entrada_PWM),
		.select(PWM_select),
		.PWM_valid_I(C_valid_PWM),
	//saidas
		.PWM_signal(PWM_signal),
		.PWM_TOP(ready)
		
	);
	
	
	Controlador uut_controlador (
		//entradas
		.clk(clk),
		.entrada_dados(saida_dados),
		.ready(ready),
		.controlador_valid(valid),
		//saidas
		.C_valid_O(C_valid_PWM),
		.write_pwm(PWM_select),
		.saida_dados(entrada_PWM),
		//.read_fifo(flag_de_leitura)
		//.print_flag(c_print_flag)
	);
	
always #10 clk = ~clk;  // simula o relogio interno de 100MHz criando um ciclo de 10ns devido a nossa time scale estar a 1ns

      
endmodule

