library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fib_datapath is
	generic 
	(	width	:positive	:= 8);
	port
	(clk	:in std_logic;
rst		:in std_logic;
i_sel		:in std_logic;--sina de seleção do mux
x_sel		:in std_logic;--sina de seleção do mux
y_sel		:in std_logic;--sina de seleção do mux
i_ld		:in std_logic;
x_ld		:in std_logic;
y_ld		:in std_logic;
n_ld		:in std_logic;
result_ld	:in std_logic;
i_le_n		:out std_logic;
n		:in std_logic_vector(width-1 downto 0); --n termo
output 	:out std_logic_vector(width-1 downto 0));
end fib_datapath;


architecture structure of fib_datapath is

COMPONENT mux_2x1 is
	generic (	width	:positive	:=8);
	port
	(input0	:in std_logic_vector(width-1 downto 0);
	input1	:in std_logic_vector(width-1 downto 0);
	sel		:in std_logic;
	output	:out std_logic_vector(width-1 downto 0));
	END COMPONENT;

		COMPONENT reg is
    generic (	width : positive := 8);
   
    port 
	(clk    : in  std_logic;
    rst    : in  std_logic;
    en     : in  std_logic;
    input  : in  std_logic_vector(width-1 downto 0);
    output : out std_logic_vector(width-1 downto 0));
	END COMPONENT;
	

COMPONENT	add is
  generic 
  (	width : positive := 8);
  
  port 
  (
    input1   : in  std_logic_vector(width-1 downto 0);
    input2   : in  std_logic_vector(width-1 downto 0);
    output   : out std_logic_vector(width-1 downto 0)
    );
END COMPONENT;

COMPONENT comp is
    generic 
	(	width : positive := 8);
    port 
	( input1	: in  std_logic_vector(width-1 downto 0);
     input2	: in  std_logic_vector(width-1 downto 0);
     ne		: out std_logic );

	END COMPONENT;
	
	
	signal i_mux_out, x_mux_out, y_mux_out				:std_logic_vector(width-1 downto 0);
	signal i_reg_out, x_reg_out, y_reg_out, n_reg_out	:std_logic_vector(width-1 downto 0);
	signal add_out_1, add_out_2 						:std_logic_vector(width-1 downto 0);	
begin

	l0	:entity work.mux_2x1 generic map (	width => width)
		port map
		(input0 	=> add_out_1,
		input1 	=> std_logic_vector(to_unsigned(3, width)),
		sel 	=> i_sel, --sina de seleção do mux
		output 	=> i_mux_out);
		
	l1	:entity work.mux_2x1 generic map (	width => width)
		port map
		(input0 	=> y_reg_out,
		input1 	=> std_logic_vector(to_unsigned(1, width)),
		sel 	=> x_sel,
		output 	=> x_mux_out);
		
	l2	:entity work.mux_2x1 generic map (	width => width)
		port map
		(input0 	=> add_out_2,
		input1 	=> std_logic_vector(to_unsigned(1, width)),
		sel 	=> y_sel,
		output 	=> y_mux_out);
		
	l3 : entity work.reg generic map(	width => width)
        port map 
		(  clk    => clk,
			rst    => rst,
			en     => i_ld,
			input  => i_mux_out,
			output => i_reg_out);
		
	l4 : entity work.reg generic map(	width => width)
        port map 
		(clk    => clk,
		rst    => rst,
		en     => x_ld,
		input  => x_mux_out,
		output => x_reg_out);
		
	l5 : entity work.reg generic map(	width => width)
        port map 
		(clk    => clk,
		rst    => rst,
		en     => y_ld,
		input  => y_mux_out,
		output => y_reg_out);
		
	l6 : entity work.reg generic map(	width => width)
        port map 
		(clk    => clk,
		rst    => rst,
		en     => n_ld,
		input  => n,
		output => n_reg_out);
		
	l7: entity work.comp generic map (	width => width)
        port map 
		(	input1 => i_reg_out,
         input2 => n_reg_out,
			ne  => i_le_n);
	
	l8 : entity work.add  generic map (	width => width)
        port map 
		(	input1	=> i_reg_out,
			input2  => std_logic_vector(to_unsigned(1, width)),
			output 	=> add_out_1);
	
	l9 : entity work.add generic map (	width => width)
        port map 
		(	input1	=> x_reg_out,
			input2  => y_reg_out,
			output 	=> add_out_2);
		
	l10: entity work.reg generic map(	width => width)
        port map 
		( clk    => clk,
			rst    => rst,
			en     => result_ld,
			input  => y_reg_out,
			output => output);

end structure;