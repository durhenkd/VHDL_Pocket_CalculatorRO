library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Registru_35bit is
	port (
	input : in std_logic_vector(34 downto 0);
	clk: in std_logic;
	reset: in std_logic;
	load: in std_logic;
	output: out std_logic_vector(34 downto 0)
	);
end Registru_35bit;

architecture Arh_Registru_35bit of Registru_35bit is

		signal q_temp: std_logic_vector(34 downto 0);

begin


	process(clk, reset, load)
		begin
			if (rising_edge(clk)) then
				if (load='1') then
					q_temp <= input;
				elsif (reset='1') then
					q_temp <= "00000000000000000000000000000000000";
				else q_temp <= q_temp;
				end if;
				end if;
	end process;	
			
output <= q_temp;

end Arh_Registru_35bit;


