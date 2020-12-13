
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Sumator_Scazator_7Bit is
	port( inputA: in std_logic_vector(6 downto 0);
			inputB: in std_logic_vector(6 downto 0);
			set: in std_logic;
			output: out std_logic_vector(6 downto 0);
			overflow: out std_logic
			);
			
end Sumator_Scazator_7Bit;

architecture Behavioral of Sumator_Scazator_7Bit is

	component SumatorComplet_7Bit is
		port( inputA: in std_logic_vector(6 downto 0);
			inputB: in std_logic_vector(6 downto 0);
			cin: in std_logic;
			output: out std_logic_vector(6 downto 0);
			co: out std_logic
			);
			
	end component SumatorComplet_7Bit;
	
	component XOR_7Bit is
		port (inputA: in std_logic_vector(6 downto 0);
			inputB: in std_logic_vector(6 downto 0);
			output: out std_logic_vector(6 downto 0)
			);
	end component XOR_7Bit;

	signal temp: std_logic_vector(6 downto 0);
	signal setv: std_logic_vector(6 downto 0);
	
	
begin

	setv(0) <= set;
	setv(1) <= set;
	setv(2) <= set;
	setv(3) <= set;
	setv(4) <= set;
	setv(5) <= set;
	setv(6) <= set;
	
	YAYORNAY: XOR_7Bit port map(setv, inputB, temp);
	DOIT: SumatorComplet_7Bit port map(inputA, temp, set, output, overflow);
	
end Behavioral;

