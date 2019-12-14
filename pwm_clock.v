`timescale 1ns / 1ps

odule pwm_clock(
	input wire clk, // 50MHz
	output reg divided_clk = 0 // 1Hz sempre que usamos um always block a saida deste tem de ser um registo
    );
	 
localparam div_value = 31; // para calcularmos este valor temos de fazer 50MHz/(2*a freq desejada)

integer counter_value = 1;

always@ (posedge clk ) // sempre que o clk vai de 0 -> 1 este codigo corre 1 vez
begin
	if (counter_value == div_value)
		begin
			counter_value <= 0; // <= todas as linhas com esse simbolo correm ao mesmo tempo (da reset ao counter)
			divided_clk <= ~divided_clk;
		end
	else
		begin
			counter_value <= counter_value + 1; // suma um em cada ciclo
			divided_clk <= divided_clk;
		end
end

endmodule
