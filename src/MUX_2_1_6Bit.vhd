----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity MUX_2_1_6Bit is
	port( inputA: in std_logic_vector(5 downto 0);
			inputB: in std_logic_vector(5 downto 0);
			output: out std_logic_vector(5 downto 0);
			sel: in std_logic
			);
end MUX_2_1_6Bit;

architecture Arh_MUX_2_1_6Bit of MUX_2_1_6Bit is
	
begin

	output <= inputA when sel = '0' else inputB;

end Arh_MUX_2_1_6Bit;

