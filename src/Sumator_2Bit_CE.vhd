----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Numarator_2Bit_CE is
	port( reset: in std_logic;
			clk: in std_logic;
			CE: out std_logic
			);
end Numarator_2Bit_CE;

architecture Arh_Numarator_2Bit_CE of Numarator_2Bit_CE is

	signal q_temp: std_logic_vector(1 downto 0);
	signal q_temp_buffer: std_logic_vector(1 downto 0);
	signal pre_CE: std_logic;
begin

	process(clk, reset)
		begin
			if	(reset = '1') then
					q_temp_buffer <= "00";
			elsif (falling_edge(clk)) then
				if (q_temp = "UU") then
					q_temp_buffer <= "00";
				else
				q_temp_buffer(0) <= not q_temp(0);
				q_temp_buffer(1) <= ((not q_temp(0)) and q_temp(1)) or ((not q_temp(1)) and q_temp(0));
				end if;
			end if;
	end process;	
	
	process(clk)
	 begin 
	 if (rising_edge(clk)) then
		if (q_temp = "11") then
			pre_CE <= '0';
		else
			pre_CE <= '1';
		end if;
	end if;
end process;
	
	process(clk)
		begin
			if(rising_edge(clk)) then
				q_temp <= q_temp_buffer;
			end if;
	end process;

	CE <= pre_CE;

end Arh_Numarator_2Bit_CE;
