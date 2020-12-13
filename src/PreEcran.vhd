----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:21:33 05/14/2020 
-- Design Name: 
-- Module Name:    PreEcran - Arh_PreEcran 
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

entity PreEcran is
	port (inputUSER: in std_logic_vector(7 downto 0);
			inputREZ: in std_logic_vector(7 downto 0);
			LC1: in std_logic;
			LC0: in std_logic;
			RC1: in std_logic;
			RC0: in std_logic;
			CMUXJ: std_logic;
			CMUXK: std_logic;
			CLK: std_logic;
			outputA: out std_logic_vector(7 downto 0);
			outputB: out std_logic_vector(7 downto 0)
			);
end PreEcran;

architecture Arh_PreEcran of PreEcran is

	component MUX_2_1_8Bit is
		port( inputA: in std_logic_vector(7 downto 0);
			inputB: in std_logic_vector(7 downto 0);
			output: out std_logic_vector(7 downto 0);
			sel: in std_logic
			);
	end component MUX_2_1_8Bit;
	
	component Registru_8bit is
		port (
			input : in std_logic_vector(7 downto 0);
			clk: in std_logic;
			reset: in std_logic;
			load: in std_logic;
			output: out std_logic_vector(7 downto 0)
			);
	end component Registru_8bit;
	
	component JK_FlipFlop is
		port(j, k, clk: in std_logic;
			qa: out std_logic );
	end component JK_FlipFlop;

	signal muxout: std_logic_vector(7 downto 0);
	signal chamber_1_out: std_logic_vector(7 downto 0);
	signal setMUX: std_logic;
	
	
begin

	CMUX_CONTROLLER: JK_FlipFlop port map(CMUXJ, CMUXK, CLK, setMUX);
	CMUX: MUX_2_1_8Bit port map(inputREZ, inputUSER, muxout, setMUX);
	CHAMBER1: Registru_8bit port map (muxout, CLK, RC1, LC1, chamber_1_out);
	CHAMBER0: Registru_8bit port map (chamber_1_out, CLK, RC0, LC0, outputA);
	
	outputB <= chamber_1_out;
	
end Arh_PreEcran;

