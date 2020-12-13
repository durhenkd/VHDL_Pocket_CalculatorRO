----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Generator_de_puls is
    Port (  CLK: in STD_LOGIC;
				intrare : in  STD_LOGIC;
				iesire : out  STD_LOGIC);
end Generator_de_puls;

architecture Arh_Generator_de_puls of Generator_de_puls is

	signal signal_temp: std_logic;
	signal last_signal: std_logic;
	
begin

	process (CLK)
		begin
			if(rising_edge(CLK)) then
				if(intrare = '0') then
					signal_temp <= '0';
					last_signal <= '0';
				else if (intrare = '1' and signal_temp = '0' and last_signal = '0') then
						signal_temp <= '1';
						last_signal <= '1';
					else 
						signal_temp <= '0';
						end if;
					end if;
				end if;
		end process;
					
iesire <= signal_temp;

end Arh_Generator_de_puls;

