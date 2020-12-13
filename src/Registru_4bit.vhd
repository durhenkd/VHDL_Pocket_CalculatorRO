----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:13:49 05/13/2020 
-- Design Name: 
-- Module Name:    Registru_4bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Registru_4bit is
	port (
	input : in std_logic_vector(3 downto 0);
	clk: in std_logic;
	reset: in std_logic;
	load: in std_logic;
	output: out std_logic_vector(3 downto 0)
	);
end Registru_4bit;

architecture Arh_Registru_4bit of Registru_4bit is

		signal q_temp: std_logic_vector(3 downto 0);

begin


	process(clk, reset, load)
		begin
			if (rising_edge(clk)) then
				if (load='1') then
					q_temp <= input;
				elsif (reset='1') then
					q_temp <= "0000";
				else q_temp <= q_temp;
				end if;
			end if;
	end process;	
			
output <= q_temp;

end Arh_Registru_4bit;

