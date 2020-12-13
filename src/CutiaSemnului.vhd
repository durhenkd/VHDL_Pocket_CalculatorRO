
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CutiaSemnului is
	port( INoperatii: in std_logic_vector(3 downto 0);
			comparator: in std_logic_vector(2 downto 0);
			semnA: in std_logic;
			semnB: in std_logic;
			OUToperatii: out std_logic_vector(3 downto 0);
			semnfinal: out std_logic
			);
end CutiaSemnului;

architecture Arh_CutiaSemnului of CutiaSemnului is
	
	signal temp_semn, xor_semn: std_logic;
	signal temp_operatii: std_logic_vector(3 downto 0);
	
begin

	xor_semn <= semnA xor semnB;
	temp_operatii(3) <= (INoperatii(3) or INoperatii(2)) and ( INoperatii(3) xor xor_semn);
	temp_operatii(2) <= (INoperatii(3) or INoperatii(2)) and ( INoperatii(2) xor xor_semn);
	temp_operatii(1) <= INoperatii(1);
	temp_operatii(0) <= INoperatii(0);
	
	temp_semn <= ( (INoperatii(1) or INoperatii(0)) and xor_semn) or 
	((temp_operatii(3) or temp_operatii(2)) and (((comparator(2) or comparator(1)) and semnA) or (comparator(0) and (semnB))));
	
	OUToperatii <= temp_operatii;
	semnfinal <= temp_semn;
	
end Arh_CutiaSemnului;

