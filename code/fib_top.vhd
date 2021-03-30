library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; --permite usar bibliotecas do tipo tipo UNSIGNED

entity fib_top is
	generic
	(	width:	positive:=	8);
	port
	(  rst, clk	: in std_logic;
		n			: in std_logic_vector(width-1 downto 0); --numero da sequencia 
		go			: in std_logic;
		done		: out std_logic; --acabou de executar 
		output		: out std_logic_vector(width-1 downto 0) );--valor do numero na sequencia 
	
end entity;





architecture top_lv of fib_top is

COMPONENT fib_control is 
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
		END COMPONENT;

COMPONENT fib_datapath is

			generic (	width	:positive	:= 8);
			
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

			END COMPONENT;

	signal i_sel	 :std_logic;
	signal x_sel	 :std_logic;
	signal y_sel	 :std_logic;
	signal i_ld		 :std_logic;
	signal x_ld		 :std_logic;
	signal y_ld		 :std_logic;
	signal n_ld		 :std_logic;
	signal result_ld :std_logic;
	signal i_le_n	 :std_logic;
	
	
begin

	controle : entity work.fib_control port map 
		(  clk       => clk,
			rst       => rst,
			go        => go,
			done      => done,
			i_sel	  => i_sel,
			x_sel     => x_sel,
			y_sel     => y_sel,
			i_ld	  => i_ld,
			x_ld      => x_ld,
			y_ld      => y_ld,
			n_ld	  => n_ld,
			result_ld => result_ld,
			i_le_n    => i_le_n);

    data: entity work.fib_datapath generic map (width => width) port map 
		(  clk       => clk,
         rst       => rst,
         i_sel	  => i_sel,
			x_sel     => x_sel,
			y_sel     => y_sel,
			i_ld	  => i_ld,
			x_ld      => x_ld,
			y_ld      => y_ld,
			n_ld	  => n_ld,
			result_ld => result_ld,
			i_le_n    => i_le_n,
         n         => n,
         output    => output);
end top_lv;