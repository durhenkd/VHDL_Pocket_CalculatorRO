----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:28:09 05/14/2020 
-- Design Name: 
-- Module Name:    Afisor7Seg - Arh_Afisor7Seg 
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

entity Afisor7Seg is
	Port (  CLK : in STD_LOGIC;
           reset : in STD_LOGIC; 
			  data: in STD_LOGIC_VECTOR (27 downto 0);
           anode_SELECT : out STD_LOGIC_VECTOR (3 downto 0);
           cathode_OUT : out STD_LOGIC_VECTOR (6 downto 0)
			  );
end Afisor7Seg;

architecture Arh_Afisor7Seg of Afisor7Seg is

	component DivizorHz_19 is
		port( CLK: in std_logic;
			reset: in std_logic;
			Q: out std_logic_vector(1 downto 0)
			);
	end component DivizorHz_19;
	
	signal counter: STD_LOGIC_VECTOR (1 downto 0);
	signal active: STD_LOGIC_VECTOR (1 downto 0);
	
begin

	DIVIZOR: DivizorHz_19 port map(CLK, reset, counter);
	
	active <= counter;
	
	process(active, data)
		begin
			case active is
    when "00" =>
        anode_SELECT <= "0111";
		  cathode_OUT <= data(27 downto 21);
        
    when "01" =>
        anode_SELECT <= "1011"; 
        cathode_OUT <= data(20 downto 14);
		  
    when "10" =>
        anode_SELECT <= "1101";
		  cathode_OUT <= data(13 downto 7);
        
    when others =>
        anode_SELECT <= "1110"; 
		  cathode_OUT <= data(6 downto 0);
 
			end case;
	end process;
end Arh_Afisor7Seg;

