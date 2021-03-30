library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_2x1 is
	generic (	width	:positive	:=8);
	port
	(input0	:in std_logic_vector(width-1 downto 0);
	input1	:in std_logic_vector(width-1 downto 0);
	sel		:in std_logic;
	output	:out std_logic_vector(width-1 downto 0));
end entity;

architecture mux_2x11 of mux_2x1 is
begin 
	
	output <= 	input0 when sel='0' else
					input1;
					
end mux_2x11;