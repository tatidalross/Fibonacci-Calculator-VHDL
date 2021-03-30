library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg is
    generic (	width : positive := 8);
   
    port 
	(clk    : in  std_logic;
    rst    : in  std_logic;
    en     : in  std_logic;
    input  : in  std_logic_vector(width-1 downto 0);
    output : out std_logic_vector(width-1 downto 0));
end reg;

architecture reg1 of reg is
	subtype State is std_logic_vector(width-1 downto 0);
---- never change (or delete or add) the internal states ----

signal nextState, currentState, resetState: State;

begin

resetState <= (others=>'0');


nextState <= 	input when EN = '1' else
					currentState;

output <= currentState;


-- memory element (never change it)
ME: process(clk, rst) is
begin
if rst='1' then
currentState <= resetState;
elsif rising_edge(clk) then
currentState <= nextState;
end if;
end process;

end reg1;