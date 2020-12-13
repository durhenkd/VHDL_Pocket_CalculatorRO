
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity XOR_7Bit is
	port (inputA: in std_logic_vector(6 downto 0);
			inputB: in std_logic_vector(6 downto 0);
			output: out std_logic_vector(6 downto 0)
			);
end XOR_7Bit;

architecture Arh_XOR_7Bit of XOR_7Bit is

begin

	output <= inputA xor inputB;

end Arh_XOR_7Bit;

