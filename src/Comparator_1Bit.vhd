----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:15:16 05/14/2020 
-- Design Name: 
-- Module Name:    Comparator_1Bit - Behavioral 
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

entity Comparator_1Bit is
    Port ( inputA : in  STD_LOGIC;
           inputB : in  STD_LOGIC;
           bigger : out  STD_LOGIC;
           equal : out  STD_LOGIC;
           smaller : out  STD_LOGIC);
end Comparator_1Bit;

architecture Arh_Comparator_1Bit of Comparator_1Bit is

begin

	bigger <= inputA and (not inputB);
	equal <=  not (inputA xor inputB);
	smaller <= (not inputA) and inputB;
	
end Arh_Comparator_1Bit;

