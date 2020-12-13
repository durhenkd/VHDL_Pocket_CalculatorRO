
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SumatorComplet_7Bit is
	port( inputA: in std_logic_vector(6 downto 0);
			inputB: in std_logic_vector(6 downto 0);
			cin: in std_logic;
			output: out std_logic_vector(6 downto 0);
			co: out std_logic
			);
			
end SumatorComplet_7Bit;

architecture Arh_SumatorComplet_7Bit of SumatorComplet_7Bit is

	component SumatorComplet_1Bit is
    Port ( cin : in  STD_LOGIC;
           a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           s : out  STD_LOGIC;
           co : out  STD_LOGIC);
	end component SumatorComplet_1Bit;

	signal carries: std_logic_vector(6 downto 0);
begin

	C0: SumatorComplet_1Bit port map (cin, inputA(0), inputB(0), output(0), carries(0)); 
	C1: SumatorComplet_1Bit port map (carries(0), inputA(1), inputB(1), output(1), carries(1)); 
	C2: SumatorComplet_1Bit port map (carries(1), inputA(2), inputB(2), output(2), carries(2)); 
	C3: SumatorComplet_1Bit port map (carries(2), inputA(3), inputB(3), output(3), carries(3)); 
	C4: SumatorComplet_1Bit port map (carries(3), inputA(4), inputB(4), output(4), carries(4)); 
	C5: SumatorComplet_1Bit port map (carries(4), inputA(5), inputB(5), output(5), carries(5)); 
	C6: SumatorComplet_1Bit port map (carries(5), inputA(6), inputB(6), output(6), carries(6)); 
	
	co <= carries(6);
	
end Arh_SumatorComplet_7Bit;

