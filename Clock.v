`timescale 1ns / 1ps
`default_nettype none
module PWM(
	input wire clk, // 50MHz
	input wire data,
	input wire select, // so pode mudar este estado apos enviar o PWM_TOP !
	input wire PWM_valid_I,
	output reg PWM_signal = 0, // 1Hz sempre que usamos um always block a saida deste tem de ser um registo
	output reg PWM_TOP = 0  // indica quando podemos receber um bit
    );
	 
//localparam H0 = 12; // para calcularmos este valor temos de fazer 50MHz/(freq desejada)
//localparam H1 = 30;
localparam Full_time = 	125;
integer counter_value = 0;
integer div_value = 0;
reg select_flag = 0;
reg data_gravada;

reg select_delay;
always @ (posedge clk) begin   // sistema para detectar quando select vai 0->1
    select_delay = select; //grava o numero anterior
end
wire select_Rising = select && !select_delay;


/*always@ (posedge clk)
begin
	if (select_Rising)
	begin
		PWM_signal <= 1;
		select_flag <= 1;
	end else // 1->0
	begin
	
	end
	
end
*/

/*
always@ (posedge clk)
begin
	if (PWM_valid_I== 1)
		begin
			data_gravada <= data;
			PWM_TOP <= 0;	// meter tudo na mesma maquina
			/*if (PWM_TOP == 1)  // se tivermos a espera de um bit podemos ler
			begin
				data_gravada <= data;
				PWM_TOP = 0;	
			end
		end
end
*/

always@ (posedge clk) // sempre que o clk vai de 0 -> 1 este codigo corre 1 vez
begin

	if (PWM_valid_I== 1)
		begin
			data_gravada <= data;
			PWM_TOP <= 0;
		end


	if (select_Rising)
	begin
		PWM_signal <= 1;
		select_flag <= 1;
		
		$display("PWM to 1");
	end else // 1->0
	begin
	end
	
	
	
	if (select_flag == 1) // verifica se podemos imprimir
	begin

		if (data_gravada == 0)
			begin
				if (counter_value == 24)
				PWM_signal <= 0;
				
			end
			
		if (counter_value == 60)  // deste modo quando se troca de 1->0 com o counter_value > 24 evitamos ficar sempre a 1 forçando o max ser 60 
			begin
				PWM_signal <= 0;
				
				$display("duty cycle signal swap");
			end
		
			
			
		if (counter_value == Full_time)
			begin
				//PWM_TOP = 0;
				PWM_TOP <= 1; // podemos receber o procimo bit
				counter_value <= 0;	
				if (select == 0 ) // deste modo n paramos o pwm a meio de um cilco
					begin
						select_flag <= 0;
						PWM_signal <= 0;
					end
				else
				begin
				PWM_signal <= 1;
				end
				$display("reset");
			end
		else
			begin
				counter_value <= counter_value +1;
				
			end
	end
	
	/*else
		begin
			if (select == 1 ) // inica o PWM
				begin
					PWM_signal = 1;
					PWM_TOP = 0; // assim que obtemos a flag para ler desativamos a flag para pedir bits pois so lemos 1 de cada vez (e outras rasoes)
					select_flag <= 1; 
				end
		end*/
	
end

endmodule
