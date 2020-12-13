----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:31:17 05/14/2020 
-- Design Name: 
-- Module Name:    DivizorHz_19 - Behavioral 
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

entity DivizorHz_19 is
	port( CLK: in std_logic;
			reset: in std_logic;
			Q: out std_logic_vector(1 downto 0)
			);
end DivizorHz_19;

architecture Behavioral of DivizorHz_19 is

	
	component Numarator_3Bit_CE is
		port( reset: in std_logic;
			clk: in std_logic;
			CE: out std_logic
			);
	end component Numarator_3Bit_CE;
	
	component Numarator_2Bit is
		port( reset: in std_logic;
			clk: in std_logic;
			output: out std_logic_vector(1 downto 0)
			);
	end component Numarator_2Bit;
	
	component Numarator_2Bit_CE is
	port( reset: in std_logic;
			clk: in std_logic;
			CE: out std_logic
			);
	end component Numarator_2Bit_CE;
	
	signal carry: std_logic_vector(5 downto 0); 
	signal temp: std_logic_vector(1 downto 0); 
	
begin

	C0: Numarator_3Bit_CE port map(reset, CLK, carry(0));
	C1: Numarator_3Bit_CE port map(reset, carry(0), carry(1));
	C2: Numarator_3Bit_CE port map(reset, carry(1), carry(2));
	C3: Numarator_3Bit_CE port map(reset, carry(2), carry(3));
	C4: Numarator_3Bit_CE port map(reset, carry(3), carry(4));
	C5: Numarator_2Bit_CE port map(reset, carry(4), carry(5));
	C6: Numarator_2Bit port map(reset, carry(5), temp(1 downto 0));
	

	Q <= temp;
end Behavioral;

