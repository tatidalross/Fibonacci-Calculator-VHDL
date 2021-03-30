library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- biblioteca que premite trabalhar com operações aritimeticas do tipo unsigned //inteiro sem sinal 

entity fib_control is 
port
(clk	:in std_logic;
rst	:in std_logic;
go	:in std_logic;
done:out std_logic;	
	i_le_n		:in std_logic;
	i_sel		:out std_logic;
	x_sel		:out std_logic;
	y_sel		:out std_logic;
	i_ld		:out std_logic;
	x_ld		:out std_logic;
	y_ld		:out std_logic;
	n_ld		:out std_logic;
	result_ld	:out std_logic);
end fib_control;


architecture FSM of fib_control is

	type STATE_TYPE is (S_WAIT, S_RESTART, S_INIT, S_LOOP_COND, S_ELSE, S_DONE, S_WHILE_GO_EQ_1);-- define os tipos de estados 
	signal state, st	: STATE_TYPE; --state é o valor armazenado no reg e next_state é o proximo valor que sera armazenado quando tiver um evento de clk
--sinais que armazenam o estados 
begin
	process(st,go,i_le_n )
	begin

		state <= st; --state = 	proximo estado
		case st is
		
			when S_WAIT => 
			--estado espera verifica se go=1 para ir para o proximo estado 
				if(go='1') then
				state <= S_INIT;
				end if;
				
			when s_RESTART =>
				
				if(go = '1') then
					
					state <= S_INIT;
				end if;
				
			when S_INIT =>	
				state <= S_LOOP_COND;
			
			
			when S_LOOP_COND =>
				if(i_le_n='1') then
				
					state <= S_DONE;
				else
					state <= S_ELSE;
				end if;
				
				
			when S_ELSE =>			
				state <= S_LOOP_COND;
				
				
			when S_DONE =>
				if(go='0') then
					state <= S_WHILE_GO_EQ_1;
				end if;
					
			
			when S_WHILE_GO_EQ_1 =>
				
				if(go='0') then
					state <= S_RESTART; 
					--volata para o 1 estado 
   end if;	
			when others => null;
			
   end case;		
	end process;
	
-- memory element (sequential)
	process(clk, rst) is
	begin
		
		if(rst = '1') then --rst assicrono não depende do clk 
		st <= S_WAIT;
		elsif(clk'event and clk = '1') then -- se não e tiver evento de clk de borda de subida
       st <= state;

	end if;
	end process;
	
--começa logica de saida
	i_sel	<= '1'       when st = S_INIT else '0';
	x_sel	<= '1'       when st = S_INIT else '0';
	y_sel	<= '1'       when st = S_INIT else '0';
	i_ld	<= '1'       when st = S_INIT or st = S_ELSE else '0';
	x_ld	<= '1'       when st = S_INIT or st = S_ELSE else '0';
	y_ld	<= '1'       when st = S_INIT or st = S_ELSE else '0';
	n_ld	<= '1'       when st = S_INIT  else '0';
	result_ld	<= '1' when st = S_DONE else '0';
	done	<= '1'       when st = S_DONE or st = S_WHILE_GO_EQ_1 else '0';

		
end FSM;