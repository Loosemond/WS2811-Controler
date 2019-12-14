`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:42:02 11/27/2019 
// Design Name: 
// Module Name:    Controlador 
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
//o controlador vai ler os dados do fifo e enviar a volucidade necessaria os dados para o PWM
module Controlador(
	input wire clk,
	input wire [7:0] entrada_dados,
	//input wire print_flag, // vai receber do modulo do sensor quando é para passar a proxima tira
	input wire ready,    // vai receber do pwm quando é que é para enviar o proximo bit
	input wire controlador_valid,
	output reg saida_dados,
	output reg write_pwm = 0,
	output reg C_valid_O,
	output reg C_endereco_O
    );
reg print_flag = 1;	 
reg timer_flag = 0;	 // em prencipio assume como 1bit
reg dados_lidos_flag = 0;
integer state = 0;  // primeiro estado verifica se pode enviar o segundo envia
integer counter_50us = 0;
integer bit_counter = 0;
integer coluna = 0;

// exite o delay de 1 ciclo para ler os dados (desde que mandamos o sinal para ler)
// usar valid para indicar quando podemos ler do fifo

// para iniciar é preciso que o C_rea

reg c_ready_delay;
always @ (posedge clk) begin   // sistema para detectar quando select vai 0->1
    c_ready_delay = ready; //grava o numero anterior
end
wire c_ready_Rising = ready && !c_ready_delay;


always@ (posedge clk)
begin


	if (c_ready_Rising) // ativa a leitura de dados sempre que recebe o pedido do PWM
	begin
	state = 3; // reduces the bit usage
	end

	if (print_flag == 1)
	begin
		if (state == 1)
		begin
			C_valid_O = 0;
			state = 0;
		end
		
		if (state == 2)
		begin
//			read_fifo = 0; // para n darmos skip a nenhum bit
			if ( controlador_valid == 1) // flag que nos indica que podemos ler o barramento de dados
			begin
				saida_dados = entrada_dados [coluna]; // le do barramento que representa coluna que estamos a motrar
				bit_counter = bit_counter + 1;
				C_valid_O = 1; // indica que vamos enviar um bit temos de dar um atraso pq demora 1 ciclo a ler do fifo !				
				state = 1;						
			end
			
		end
		if (state == 3) 
		begin
			if (timer_flag == 0) // verificamos se podemos escrever no pwm
			write_pwm = 1; //ativamos o PWM (arranca antes de saber que bit vai escrever !)
			begin
//				read_fifo = 1; // indica a memoria que vamos ler (pode so ler no ciclo seguinte)
				state = 2;
			end
		end
		if (bit_counter == 400)
			begin
				bit_counter = 0;
				timer_flag = 1;
				coluna = coluna + 1;
			if (coluna == 8) // pq so temos 50 colunas logo fazemos o reset a 51
				begin
				coluna = 0;
				end
			end
	end
	if (timer_flag == 1) // delay nesseçario para mudarmos de coluna
		begin		
		counter_50us = counter_50us + 1;
		write_pwm = 0;
		if (counter_50us == 2500) // define quanto tempo fica desligado
			begin
			counter_50us = 0;
			timer_flag = 0;
			print_flag = 1;
			state = 3;
			end			
		end
	



end


endmodule
