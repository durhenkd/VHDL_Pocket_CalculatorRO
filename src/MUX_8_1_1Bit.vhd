----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity MUX_8_1_1Bit is
	port( input: in std_logic_vector(7 downto 0);
			output: out std_logic;
			sel: in std_logic_vector(2 downto 0)
			);
end MUX_8_1_1Bit;

architecture Arh_MUX_8_1_1Bit of MUX_8_1_1Bit is

begin

	output <= input( to_integer( unsigned(sel)));


end Arh_MUX_8_1_1Bit;

