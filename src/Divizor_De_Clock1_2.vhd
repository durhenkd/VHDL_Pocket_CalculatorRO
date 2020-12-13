----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Divizor_De_Clock1_2 is
		port(	CLKin: in std_logic;
				CLKout: out std_logic
				);
end Divizor_De_Clock1_2;

architecture ARh_Divizor_De_Clock1_2 of Divizor_De_Clock1_2 is

	signal q_temp: std_logic := '0';

begin

	process(CLKin)
		begin
			if(rising_edge(CLKin)) then
				q_temp <= not q_temp;
			end if;
	end process;
	
	CLKout <= q_temp;
end ARh_Divizor_De_Clock1_2;

