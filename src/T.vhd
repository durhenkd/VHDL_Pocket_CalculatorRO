----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T is
		port(	Test_ROM: in std_logic_vector(8 downto 0);
				Test_UE: in std_logic_vector(8 downto 0);
				E: in std_logic;
				Set_NextAdress: out std_logic
			);
end T;

architecture Behavioral of T is

	signal Test_temp: std_logic_vector(8 downto 0);
	signal OR_sig: std_logic;
	
begin

	Test_temp <= Test_rom and Test_UE;
	
	OR_sig <= Test_temp(0) or Test_temp(1) or Test_temp(2) or Test_temp(3) or Test_temp(4) or Test_temp(5)
	or Test_temp(6) or Test_temp(7) or Test_temp(8);
	
	Set_NextAdress <= E and OR_sig;

end Behavioral;

