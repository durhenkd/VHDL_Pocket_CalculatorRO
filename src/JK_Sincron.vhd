
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity JK_FlipFlop is

	port(j, k, clk: in std_logic;
	qa: out std_logic );
end entity;


architecture logic_flow of JK_FlipFlop is

	signal q_temp: std_logic;
	
begin

	process(clk)
		begin		
			if (rising_edge(clk)) then
				if(j='0' and k='0') then
					q_temp <= q_temp ;
				elsif(j='0' and k='1') then
					q_temp <='0';
				elsif(j='1' and k='0') then
					q_temp <='1';
				else
					q_temp <= not q_temp;
				end if;
			end if;
			end process;
			
qa<= q_temp;

end architecture;
