----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Calculator_De_Buzunar is
	port ( CLK: in std_logic;
			 Anode : out STD_LOGIC_VECTOR (3 downto 0);
			 Cathode : out STD_LOGIC_VECTOR (6 downto 0);
			 rest_LED: out std_logic_vector(7 downto 0);
			 error_LED: out std_logic;
			 operation_input: in std_logic_vector(4 downto 0);
			 data_input: in std_logic_vector(7 downto 0)
			 );
			 
end Calculator_De_Buzunar;

architecture Arh_Calculator_De_Buzunar of Calculator_De_Buzunar is

	
	component UE is
		port( CLK: in std_logic;
				data_input: in std_logic_vector(7 downto 0);
				command_input: in std_logic_vector(34 downto 0);
				operation_input: in std_logic_vector(3 downto 0);
				operation_output: out std_logic_vector(3 downto 0);
				Anode_SELECT : out STD_LOGIC_VECTOR (3 downto 0);
				Cathode_OUT : out STD_LOGIC_VECTOR (6 downto 0);
				rest: out std_logic_vector(7 downto 0);
				error_signals: out std_logic_vector(1 downto 0);
				error_LED: out std_logic;
				numarator_full: out std_logic;
				registerA6: out std_logic
			);
	end component UE;

	component UC is
		port( CLK_HALF: in std_logic;
			CLK: in std_logic;
			intrari_operatii: in std_logic_vector(4 downto 0);
			in_semnale_de_test: in std_logic_vector(7 downto 0);
			out_semnal_command: out std_logic_vector(34 downto 0)
		);
	end component UC;
	
	component Divizor_De_Clock1_2 is
		port(	CLKin: in std_logic;
				CLKout: out std_logic
				);
	end component Divizor_De_Clock1_2;
	
	signal test_UE2UC: std_logic_vector(7 downto 0);
	signal command: std_logic_vector(34 downto 0);
	signal CLK_internal_signal: std_logic;
	
begin

	CLOCK_DIVISOR: Divizor_De_Clock1_2 port map(CLK, CLK_internal_signal);

	Unitatea_Executie: UE port map(CLK, data_input, command, operation_input(4 downto 1), test_UE2UC(7 downto 4),
	Anode, Cathode, rest_LED, test_UE2UC(3 downto 2), error_LED, test_UE2UC(1), test_UE2UC(0));
	
	Unitatea_Control: UC port map(CLK_internal_signal, CLK, operation_input, test_UE2UC, command);
	
end Arh_Calculator_De_Buzunar;

