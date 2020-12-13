----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Numarator_3Bit is
	port( reset: in std_logic;
			clk: in std_logic;
			output: out std_logic_vector(2 downto 0)
			);
end Numarator_3Bit;

architecture Arh_Numarator_3Bit of Numarator_3Bit is

	signal q_temp: std_logic_vector(2 downto 0);
	signal q_temp_buffer: std_logic_vector(2 downto 0);

begin

	process(clk, reset)
		begin
			if	(reset = '1') then
					q_temp_buffer <= "000";
			elsif (falling_edge(clk)) then
				if (q_temp = "UUU") then
					q_temp_buffer <= "000";
				else
				q_temp_buffer(0) <= not q_temp(0);
				q_temp_buffer(1) <= ((not q_temp(0)) and q_temp(1)) or ((not q_temp(1)) and q_temp(0));
				q_temp_buffer(2) <= (q_temp(2) and (not q_temp(1))) or ( (not q_temp(2)) and q_temp(1) and q_temp(0)) or ( q_temp(2) and (not q_temp(0)) and q_temp(1));
				end if;
			end if;
	end process;	
	
	process(clk)
		begin
			if(rising_edge(clk)) then
				q_temp <= q_temp_buffer;
			end if;
	end process;
	
	output <= q_temp;

end Arh_Numarator_3Bit;

