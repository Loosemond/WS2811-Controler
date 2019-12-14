`timescale 1ns / 1ps
`default_nettype none
module PWM_1(
	input wire clk, // 50MHz
	input wire data,
	input wire select,
	output reg PWM_signal = 1, // 1Hz sempre que usamos um always block a saida deste tem de ser um registo
	output reg PWM_TOP = 0
	
    );
	 
//localparam H0 = 12; // para calcularmos este valor temos de fazer 50MHz/(2*a freq desejada)
//localparam H1 = 30;
localparam Full_time = 	125;
integer counter_value = 0;
integer div_value = 0;
//reg state_OFF = data[0];


always@ (posedge clk) // sempre que o clk vai de 0 -> 1 este codigo corre 1 vez
begin

	if (data == 1)
		begin
			div_value = 60;
		end
	else
		begin
			div_value = 24;
		end
		
	if (counter_value == div_value)
		begin
			PWM_signal <= ~PWM_signal;
		end
		
	if (counter_value == Full_time)
		begin
			counter_value <= 0;
			PWM_signal <= ~PWM_signal;
		end
	else
		begin
			counter_value = counter_value +1;
			PWM_signal = PWM_signal;
		end
/*	if (select == 0) // PODE haver problemas de parar de transmitir cedo demais
	begin
	if (counter_value == 60)
	
	begin
		counter_value <= 0;
		PWM_signal <= ~PWM_signal;

		if (data == 1) div_value = 30;
		else div_value = 12;
	end
	
	
	if (counter_value == div_value)
		begin
			//counter_value <= 0; // <= todas as linhas com esse simbolo correm ao mesmo tempo (da reset ao counter)
			PWM_signal <= ~PWM_signal;
		end
	else
		begin
			counter_value <= counter_value + 1; // suma um em cada ciclo
			PWM_signal <= PWM_signal;
		end
	
	end*/
	
end

endmodule
