library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comp is
    generic 
	(	width : positive := 8);
    port 
	( input1	: in  std_logic_vector(width-1 downto 0);
     input2	: in  std_logic_vector(width-1 downto 0);
     ne		: out std_logic );
end comp;


architecture comp1 of comp is

signal less: std_logic;
begin
       
		 less <= '0' when (unsigned(input1) <= unsigned(input2)) else '1';
	 ne  <= less;


				
end comp1;