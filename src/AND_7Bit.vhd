----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:50:41 05/13/2020 
-- Design Name: 
-- Module Name:    AND_7Bit - Arh_AND_7Bit 
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

entity AND_7Bit is
	port (inputA: in std_logic_vector(6 downto 0);
			inputB: in std_logic_vector(6 downto 0);
			output: out std_logic_vector(6 downto 0)
			);
end AND_7Bit;

architecture Arh_AND_7Bit of AND_7Bit is

begin
	
	output <= inputA and inputB;

end Arh_AND_7Bit;

