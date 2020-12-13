----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Registru_8bit is
	port (
	input : in std_logic_vector(7 downto 0);
	clk: in std_logic;
	reset: in std_logic;
	load: in std_logic;
	output: out std_logic_vector(7 downto 0)
	);
end Registru_8bit;

architecture Arh_Registru_8bit of Registru_8bit is

		signal q_temp: std_logic_vector(7 downto 0);

begin


	process(clk, reset, load)
		begin
			if (rising_edge(clk)) then
				if (load='1') then
					q_temp <= input;
				elsif (reset='1') then
					q_temp <= "00000000";
				else q_temp <= q_temp;
				end if;
			end if;
	end process;	
			
output <= q_temp;

end Arh_Registru_8bit;


