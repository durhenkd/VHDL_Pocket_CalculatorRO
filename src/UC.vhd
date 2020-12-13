----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC is
	port( CLK_HALF: in std_logic;
			CLK: in std_logic;
			intrari_operatii: in std_logic_vector(4 downto 0);
			in_semnale_de_test: in std_logic_vector(7 downto 0);
			out_semnal_command: out std_logic_vector(34 downto 0)
		);
end UC;

architecture Behavioral of UC is

	component ROM_COMENZI is
	 Port (CLK: in std_logic;
			 Adresa: in std_logic_vector(5 downto 0);
			 CS: in std_logic;
          D_ROM: out std_logic_vector(41 downto 0));
	end component ROM_COMENZI;
	
	component Registru_35bit is
		port (
			input : in std_logic_vector(34 downto 0);
			clk: in std_logic;
			reset: in std_logic;
			load: in std_logic;
			output: out std_logic_vector(34 downto 0)
	);
	end component Registru_35bit;
	
	component MUX_2_1_6Bit is
		port( inputA: in std_logic_vector(5 downto 0);
			inputB: in std_logic_vector(5 downto 0);
			output: out std_logic_vector(5 downto 0);
			sel: in std_logic
			);
	end component MUX_2_1_6Bit;
	
	component Registru_6bit is
		port (
			input : in std_logic_vector(5 downto 0);
			clk: in std_logic;
			reset: in std_logic;
			load: in std_logic;
			output: out std_logic_vector(5 downto 0)
			);
	end component Registru_6bit;
	
	component T is
		port(	Test_ROM: in std_logic_vector(8 downto 0);
				Test_UE: in std_logic_vector(8 downto 0);
				E: in std_logic;
				Set_NextAdress: out std_logic
			);
	end component T;
	
	component Generator_de_puls is
    Port (  CLK: in STD_LOGIC;
				intrare : in  STD_LOGIC;
				iesire : out  STD_LOGIC);
end component Generator_de_puls;
	
	
	signal CMD_bus: std_logic_vector(41 downto 0);
	signal adress_CTRL: std_logic;
	signal E, nE: std_logic;
	signal out_MUX: std_logic_vector(5 downto 0);
	signal out_REG: std_logic_vector(5 downto 0);
	
	signal este_input: std_logic;
	
	signal vector_de_test: std_logic_vector(8 downto 0);
	
	signal always_ON, always_OFF: std_logic;
	
	signal Register_reset: std_logic;
	signal Register_load: std_logic;

begin

	always_on <= '1';
	always_off <= '0';
	
	E <= CMD_bus(41);
	nE <= not E;
	
	CMD_ROM: ROM_COMENZI port map(CLK_HALF, out_REG, always_ON, CMD_bus);
	CMD_REG: Registru_35bit port map(CMD_bus(40 downto 6), CLK, Register_reset, Register_load , out_semnal_command);
	
	Register_reset <= E or (CLK_HALF);
	Register_load <= nE and (not CLK_HALF);
	
	MUX: MUX_2_1_6Bit port map(CMD_bus(5 downto 0), CMD_bus(11 downto 6), out_MUX, adress_CTRL);
	
	ADRESS_REG: Registru_6bit port map(out_MUX, CLK_HALF, always_Off, always_ON, out_REG);
	
	ADRESS_DECISION: T port map(CMD_bus(20 downto 12), vector_de_test, E, adress_CTRL);

	este_input <= intrari_operatii(0) or intrari_operatii(1) or intrari_operatii(2) or intrari_operatii(3) or intrari_operatii(4);
	
	vector_de_test(0) <= in_semnale_de_test(0);
	vector_de_test(8 downto 2) <= in_semnale_de_test(7 downto 1);
	
	PULSE: Generator_de_puls port map(CLK_HALF, este_input, vector_de_test(1));
	
end Behavioral;

