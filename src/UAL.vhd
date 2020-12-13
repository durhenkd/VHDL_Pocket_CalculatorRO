----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity UAL is
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
end UAL;

architecture Behavioral of UAL is

	component Sumator_Scazator_7Bit is
		port( inputA: in std_logic_vector(6 downto 0);
			inputB: in std_logic_vector(6 downto 0);
			set: in std_logic;
			output: out std_logic_vector(6 downto 0);
			overflow: out std_logic
			);
			
	end component Sumator_Scazator_7Bit;
	
	component AND_7Bit is
		port (inputA: in std_logic_vector(6 downto 0);
			inputB: in std_logic_vector(6 downto 0);
			output: out std_logic_vector(6 downto 0)
			);
	end component AND_7Bit;
	
	component Registru_7Bit_Cusshift is
		port (
			input : in std_logic_vector(6 downto 0);
			clk: in std_logic;
			reset: in std_logic;
			load: in std_logic;
			output: out std_logic_vector(6 downto 0);
			serial_input: in std_logic;
			shift_left: in std_logic
			);
	end component Registru_7Bit_Cusshift;

	component Numarator_3Bit is
		port( reset: in std_logic;
			clk: in std_logic;
			output: out std_logic_vector(2 downto 0)
			);
	end component Numarator_3Bit;	
	
	component MUX_8_1_1Bit is
		port( input: in std_logic_vector(7 downto 0);
			output: out std_logic;
			sel: in std_logic_vector(2 downto 0)
			);
	end component MUX_8_1_1Bit;
	
	component JK_FlipFlop is
		port(j, k, clk: in std_logic;
			qa: out std_logic );
	end component;
	
	component MUX_2_1_7Bit is
		port( inputA: in std_logic_vector(6 downto 0);
			inputB: in std_logic_vector(6 downto 0);
			output: out std_logic_vector(6 downto 0);
			sel: in std_logic
			);
	end component MUX_2_1_7Bit;
	
	signal outA: std_logic_vector(6 downto 0); -- semnalele care ies din registrii
	signal outB: std_logic_vector(6 downto 0);
	signal outC: std_logic_vector(6 downto 0);
	signal outSum: std_logic_vector(6 downto 0); --semnalul care iese din Sumator/Scazator
	signal outAnd: std_logic_vector(6 downto 0); --semnalul care iese din AND7
	signal ctrlLMUX: std_logic;						--Semnalele care ies din bistabili care controleaza MUX-urile
	signal ctrlRMUX: std_logic;		
	signal ctrlTMUX: std_logic;
	signal outLMUX: std_logic_vector(6 downto 0);	--Semnalele care ies din Mux-uri
	signal outRMUX: std_logic_vector(6 downto 0);
	signal outTMUX: std_logic_vector(6 downto 0);
	signal out8MUX: std_logic;							
	signal inAND: std_logic_vector(6 downto 0);		--Semnal care intra in AND
	signal counter: std_logic_vector(2 downto 0);	--care iese din numarator
	signal serial: std_logic;								--semnalul care iese din bistabilul pentru 
	signal nu_conteaza: std_logic;						--GND
	signal operation: std_logic;							-- semnalul care iese din bistabilul care decide operatia (scadere/adunare)
	signal MUXfeed: std_logic_vector(7 downto 0);	
	signal in_TMUX: std_logic_vector(6 downto 0);

begin
	
	nu_conteaza <= '0';

	REGISTRULA: Registru_7Bit_Cusshift port map(outSum, CLK, RRA, LRA, outA, outB(6), SLrA);
	REGISTRULB: Registru_7Bit_Cusshift port map(outTMUX, CLK, RRB, LRB, outB, serial, SLrB);
	REGISTRULC: Registru_7Bit_Cusshift port map(inputB, CLK, RRC, LRC, outC, nu_conteaza, nu_conteaza);
	BITFEEDER: JK_FlipFlop port map(SETJ, RESK, CLK, serial);
	OPSET: JK_FlipFlop port map(setDif, setSum, CLK, operation);
	THREE_BIT_COUTER: Numarator_3Bit port map(RNR, INC, counter);
	
	MUXfeed(6 DOWNTO 0) <= outC;
	MUXfeed(7) <= nu_conteaza;
	
	C_SECTION: MUX_8_1_1Bit port map(MUXfeed, out8MUX, counter);
	
	inAND(0) <= out8MUX;
	inAND(1) <= out8MUX;
	inAND(2) <= out8MUX;
	inAND(3) <= out8MUX;
	inAND(4) <= out8MUX;
	inAND(5) <= out8MUX;
	inAND(6) <= out8MUX;
	AND_COMP: AND_7Bit port map(outB, inAND, outAND);
	
	LMUX_CONTROLLER: JK_FlipFlop port map(LMUXJ, LMUXK, CLK, ctrlLMUX);
	RMUX_CONTROLLER: JK_FlipFlop port map(RMUXJ, RMUXK, CLK, ctrlRMUX);
	LMUX: MUX_2_1_7Bit port map(outA, outB, outLMUX, ctrlLMUX);
	RMUX: MUX_2_1_7Bit port map(outAND, outC, outRMUX, ctrlRMUX);
	
	in_TMUX(6 downto 1) <= outB(6 downto 1);
	in_TMUX(0) <= serial;
	
	TMUX_CONTROLLER: JK_FlipFlop port map(TMUXJ, TMUXK, CLK, ctrlTMUX);
	TMUX: MUX_2_1_7Bit port map( inputA, in_TMUX, outTMUX, ctrlTMUX);
	
	SUMATOR_SCAZATOR: Sumator_Scazator_7Bit port map(outLMUX, outRMUX, operation, outSum, error_overflow);
	
	output <= outA;
	rest <= outB;

	error_div0 <= not (outC(0) or outC(1) or outC(2) or outC(3) or outC(4) or outC(5) or outC(6));
	
	numarator_full <= counter(2) and counter(1) and counter(0);
	registerA6 <= outA(6);
end Behavioral;

