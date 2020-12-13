
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity Compartor_7Bit is
	port (inputA: in std_logic_vector(6 downto 0);
			inputB: in std_logic_vector(6 downto 0);
			output: out std_logic_vector(2 downto 0)
			);
end Compartor_7Bit;

architecture Arh_Compartor_7Bit of Compartor_7Bit is
	
	component Comparator_1Bit is
		Port ( inputA : in  STD_LOGIC;
           inputB : in  STD_LOGIC;
           bigger : out  STD_LOGIC;
           equal : out  STD_LOGIC;
           smaller : out  STD_LOGIC);
	end component Comparator_1Bit;

	signal bigger: std_logic_vector(6 downto 0);
	signal equal:	std_logic_vector(6 downto 0);
	signal smaller: std_logic_vector(6 downto 0);
	signal equals:	std_logic_vector(6 downto 0);
	
begin

	CMP6: Comparator_1Bit port map(inputA(6), inputB(6), bigger(6), equal(6), smaller(6));
	CMP5: Comparator_1Bit port map(inputA(5), inputB(5), bigger(5), equal(5), smaller(5));
	CMP4: Comparator_1Bit port map(inputA(4), inputB(4), bigger(4), equal(4), smaller(4));
	CMP3: Comparator_1Bit port map(inputA(3), inputB(3), bigger(3), equal(3), smaller(3));
	CMP2: Comparator_1Bit port map(inputA(2), inputB(2), bigger(2), equal(2), smaller(2));
	CMP1: Comparator_1Bit port map(inputA(1), inputB(1), bigger(1), equal(1), smaller(1));
	CMP0: Comparator_1Bit port map(inputA(0), inputB(0), bigger(0), equal(0), smaller(0));
	
	equals(6) <= equal(6);
	equals(5) <= equal(6) and equal(5);
	equals(4) <= equal(6) and equal(5) and equal(4);
	equals(3) <= equal(6) and equal(5) and equal(4) and equal(3);
	equals(2) <= equal(6) and equal(5) and equal(4) and equal(3) and equal(2);
	equals(1) <= equal(6) and equal(5) and equal(4) and equal(3) and equal(2) and equal(1);
	equals(0) <= equal(6) and equal(5) and equal(4) and equal(3) and equal(2) and equal(1) and equal(0);
	
	output(2) <= bigger(6) or (bigger(5) and equals(6)) or (bigger(4) and equals(5)) or
	(bigger(3) and equals(4)) or (bigger(2) and equals(3)) or (bigger(1) and equals(2)) or (bigger(0) and equals(1));
	
	output(1) <= equals(0);
	
	output(0) <= smaller(6) or (smaller(5) and equals(6)) or (smaller(4) and equals(5)) or (smaller(3) and equals(4))
	or (smaller(2) and equals(3)) or (smaller(1) and equals(2)) or (smaller(0) and equals(1));
	
	
end Arh_Compartor_7Bit;

