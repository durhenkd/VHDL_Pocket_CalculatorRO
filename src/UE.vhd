----------------------------------------------------------------------------------
 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity UE is
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
end UE;

architecture ARH_UE of UE is

	component JK_FlipFlop is
		port(j, k, clk: in std_logic;
			qa: out std_logic );
	end component;
	
	component Afisor7Seg is
		Port (  CLK : in STD_LOGIC;
           reset : in STD_LOGIC; 
			  data: in STD_LOGIC_VECTOR (27 downto 0);
           anode_SELECT : out STD_LOGIC_VECTOR (3 downto 0);
           cathode_OUT : out STD_LOGIC_VECTOR (6 downto 0)
			  );
	end component Afisor7Seg;
	
	component Screen_ROM is
		Port (CLK: in std_logic;
				Adresa: in std_logic_vector(6 downto 0);
          CS: in std_logic;
          D_ROM: out std_logic_vector(20 downto 0) );
	end component Screen_ROM;
	
	component DecizieDeInversare is
		port( inputA: in std_logic_vector(6 downto 0);
			inputB: in std_logic_vector(6 downto 0);
			adunare: in std_logic;
			scadere: in std_logic;
			outputA: out std_logic_vector(6 downto 0);
			outputB: out std_logic_vector(6 downto 0);
			comparator: out std_logic_vector(2 downto 0)
			);
	end component DecizieDeInversare;
	
	component CutiaSemnului is
		port( INoperatii: in std_logic_vector(3 downto 0);
			comparator: in std_logic_vector(2 downto 0);
			semnA: in std_logic;
			semnB: in std_logic;
			OUToperatii: out std_logic_vector(3 downto 0);
			semnfinal: out std_logic
			);
	end component CutiaSemnului;
	
	component PreEcran is
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
	end component PreEcran;
	
	component UAL is
		port( inputA: in std_logic_vector(6 downto 0);
			inputB: in std_logic_vector(6 downto 0);
			setSum: in std_logic;
			setDif: in std_logic;
			SLrA: in std_logic;
			SLrB: in std_logic;
			RRA: in std_logic;
			LRA: in std_logic;
			RRB: in std_logic;
			LRB: in std_logic;
			RRC: in std_logic;
			LRC: in std_logic;
			SETJ: in std_logic;
			RESK: in std_logic;
			LMUXJ: in std_logic;
			LMUXK: in std_logic;
			RMUXJ: in std_logic;
			RMUXK: in std_logic;
			TMUXJ: in std_logic;
			TMUXK: in std_logic;
			INC: in std_logic;
			RNR: in std_logic;
			output: out std_logic_vector(6 downto 0);
			rest: out std_logic_vector(6 downto 0);
			error_overflow: out std_logic;
			error_div0: out std_logic;
			CLK: in std_logic;
			numarator_full: out std_logic;
			registerA6: out std_logic
			);
	end component UAL;
	
	component Registru_4bit is
		port (
			input : in std_logic_vector(3 downto 0);
			clk: in std_logic;
			reset: in std_logic;
			load: in std_logic;
			output: out std_logic_vector(3 downto 0)
			);
		end component Registru_4bit;
		
	component Registru_8bit is
		port (
			input : in std_logic_vector(7 downto 0);
			clk: in std_logic;
			reset: in std_logic;
			load: in std_logic;
			output: out std_logic_vector(7 downto 0)
			);
	end component Registru_8bit;
		
		signal bus_rezult: std_logic_vector(7 downto 0);
		signal bus_A: std_logic_vector(7 downto 0);
		signal bus_B: std_logic_vector(7 downto 0);
		signal bus_rest: std_logic_vector(7 downto 0);
		
		signal bus_temp: std_logic_vector(7 downto 0);
		
		signal Screen: std_logic_vector(27 downto 0);
		
		signal bus_compare: std_logic_vector(2 downto 0);
		signal bus_operations: std_logic_vector(3 downto 0);
		signal bus_operations_buffer: std_logic_vector(3 downto 0);
		signal bus_newA: std_logic_vector(6 downto 0);
		signal bus_newB: std_logic_vector(6 downto 0);
		
		signal semn_carry: std_logic;
		
		signal High_value, Low_value: std_logic; 
		
begin
	
	High_value <= '1';
	Low_value <= '0';
	
	PRESCREEN: PreEcran port map(data_input, bus_rezult, command_input(30), command_input(29), 
	command_input(32), command_input(31), command_input(15), command_input(14), CLK, bus_A, bus_B);
	S_ROM: Screen_ROM port map (CLK, bus_B(6 downto 0), High_value, Screen(20 downto 0));
	
	Screen(27 downto 22) <= "111111";
	Screen(21) <= not(bus_B(7));
	
	SWITCH: DecizieDeInversare port map(bus_A(6 downto 0), bus_B(6 downto 0), bus_operations(3),
	bus_operations(2), bus_newA, bus_newB, bus_compare);
	
	OPERATION_BUFFER: Registru_4bit port map(operation_input, CLK, command_input(28), command_input(26), bus_operations_buffer);
	OPERATION: Registru_4bit port map(bus_operations_buffer, CLK, command_input(27), command_input(26), bus_operations);
	
	MAGIC_BOX: CutiaSemnului port map(bus_operations, bus_compare, bus_A(7), bus_B(7), operation_output, semn_carry);
	
	UAL_C: UAL port map(bus_newA, bus_newB, command_input(9), command_input(8), command_input(19), command_input(18),
	command_input(24), command_input(25), command_input(22), command_input(23), command_input(20), command_input(21),
	command_input(17), command_input(16), command_input(13), command_input(12), command_input(11), command_input(10),
	command_input(34), command_input(33), command_input(3), command_input(2), bus_temp(6 downto 0), bus_rest(6 downto 0),
	error_signals(1), error_signals(0), CLK, numarator_full, registerA6);
	
	bus_temp(7) <= semn_carry; 
	bus_rest(7) <= bus_B(7);
	
	REZULTAT: Registru_8bit port map(bus_temp, CLK, command_input(5), command_input(4), bus_rezult);
	REST_REG: Registru_8bit port map(bus_rest, CLK, command_input(7), command_input(6), rest);
	
	ERROR_CELL: JK_FlipFlop port map(command_input(1), command_input(0), CLK, error_LED);
	
	SCREEN_COMP: Afisor7Seg port map(CLK, Low_Value, Screen, Anode_SELECT, Cathode_OUT);
	
end ARH_UE;

