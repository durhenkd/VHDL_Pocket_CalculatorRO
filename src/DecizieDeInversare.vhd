----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:03:09 05/14/2020 
-- Design Name: 
-- Module Name:    DecizieDeInversare - Arh_DecizieDeInversare 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DecizieDeInversare is
	port( inputA: in std_logic_vector(6 downto 0);
			inputB: in std_logic_vector(6 downto 0);
			adunare: in std_logic;
			scadere: in std_logic;
			outputA: out std_logic_vector(6 downto 0);
			outputB: out std_logic_vector(6 downto 0);
			comparator: out std_logic_vector(2 downto 0)
			);
end DecizieDeInversare;

architecture Arh_DecizieDeInversare of DecizieDeInversare is

	component Compartor_7Bit is
		port (inputA: in std_logic_vector(6 downto 0);
			inputB: in std_logic_vector(6 downto 0);
			output: out std_logic_vector(2 downto 0)
			);
	end component Compartor_7Bit;
	
	component MUX_2_1_7Bit is
		port( inputA: in std_logic_vector(6 downto 0);
			inputB: in std_logic_vector(6 downto 0);
			output: out std_logic_vector(6 downto 0);
			sel: in std_logic
			);
	end component MUX_2_1_7Bit;

	signal setMUX: std_logic;
	signal rezComp: std_logic_vector(2 downto 0);

	
begin
	
	COMP: Compartor_7Bit port map(inputA, inputB, rezComp);
	
	setMUX <= rezComp(0) and (adunare or scadere);
	
	MUXA: MUX_2_1_7Bit port map(inputA, inputB, outputA, setMUX);
	MUXB: MUX_2_1_7Bit port map(inputB, inputA, outputB, setMUX);
	
	comparator <= rezComp;
	
	
end Arh_DecizieDeInversare;

