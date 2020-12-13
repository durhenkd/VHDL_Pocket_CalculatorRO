----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:20:46 05/14/2020 
-- Design Name: 
-- Module Name:    SumatorComplet_1Bit - Behavioral 
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

entity SumatorComplet_1Bit is
    Port ( cin : in  STD_LOGIC;
           a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           s : out  STD_LOGIC;
           co : out  STD_LOGIC);
end SumatorComplet_1Bit;

architecture Behavioral of SumatorComplet_1Bit is

begin
	
	s <= (cin and ( not(a xor b))) or ((not cin) and (a xor b));
	co <= (cin and (a or b)) or (a and b);
	
end Behavioral;

